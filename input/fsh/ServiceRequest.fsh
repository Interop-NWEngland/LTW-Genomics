Profile:        ServiceRequest
Parent:         https://fhir.hl7.org.uk/StructureDefinition/UKCore-ServiceRequest
Id:             ServiceRequest
Title:          "ServiceRequest"
Description:    """
DRAFT Extension of UKCore-ServiceRequest which includes constraints from:
- [NHS England Genomics ServiceRequest](https://simplifier.net/guide/fhir-genomics-implementation-guide/Home/FHIRAssets/Profiles/All-Profiles/UKCore-ServiceRequest) use text descriptions only, not the rendered profile.
"""

* extension[additionalContact] ^short = "Do not use, not supported. Use PractitionerRole instead."

* identifier 1..* MS
* identifier only CorrelationIdentifier

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the type"
* identifier ^slicing.ordered = false
* identifier contains
  placerOrderNumber 0..1 MS and fillerOrderNumber 0..1 MS and placerGroupNumber 0..1 MS and accessionNumber 0..1 MS

* identifier[placerOrderNumber] only PlacerOrderNumber
* identifier[placerOrderNumber] ^short = "Identifier assigned by the Order Placer."
* identifier[placerOrderNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/OrderFiller)
* identifier[placerOrderNumber] insert Obligation(#SHALL:populate, https://hl7.mft.nhs.uk/ActorDefinition/OrderPlacer)
* identifier[placerOrderNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/AutomationManager)
* identifier[accessionNumber] only AccessionNumber
* identifier[accessionNumber] ^short = "Identifier assigned by the lab (Order Filler)"
* identifier[accessionNumber] insert Obligation(#SHALL:populate, https://hl7.mft.nhs.uk/ActorDefinition/OrderFiller)
* identifier[accessionNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/OrderPlacer)
* identifier[accessionNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/AutomationManager)
* identifier[fillerOrderNumber] only FillerOrderNumber
* identifier[fillerOrderNumber] ^short = "Identifier assigned by the lab (Order Filler)"
* identifier[fillerOrderNumber] insert Obligation(#SHALL:populate, https://hl7.mft.nhs.uk/ActorDefinition/OrderFiller)
* identifier[fillerOrderNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/OrderPlacer)
* identifier[fillerOrderNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/AutomationManager)
* identifier[placerGroupNumber] only PlacerGroupNumber
* identifier[placerGroupNumber] ^short = "Identifier assigned by the Order Placer."
* identifier[placerGroupNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/OrderFiller)
* identifier[placerGroupNumber] insert Obligation(#SHALL:populate, https://hl7.mft.nhs.uk/ActorDefinition/OrderPlacer)
* identifier[placerGroupNumber] insert Obligation(#SHOULD:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/AutomationManager)

* code ^short = "ISSUE. See [National Genomic Test Directory](https://www.england.nhs.uk/wp-content/uploads/2018/08/rare-and-inherited-disease-eligibility-criteria-v2.pdf)."
* code 1..1 MS

* code.coding 1..* MS
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding ^slicing.description = "Slice based on the system"
* code.coding ^slicing.ordered = false
* code.coding contains
  GenomicTestDirectory 1..1 MS

* code.coding[GenomicTestDirectory] from GenomicTestDirectory (required)
* code.coding[GenomicTestDirectory].system = "https://fhir.nhs.uk/CodeSystem/England-GenomicTestDirectory"


* category 1..* MS
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding.system"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the coding.system"
* category ^slicing.ordered = false
* category contains
  GenomicProcedure 1..1 MS

* category[GenomicProcedure].coding.code = #116148004
* category[GenomicProcedure].coding.system = $sct

* category[genomicsWholeCaseSequencing] 1..1 MS

* encounter 0..1 MS
* encounter only Reference(Encounter)
* encounter.identifier ^short = "(HL7v2 PV1-19)"
* encounter.identifier only VisitNumber
* encounter.identifier insert Obligation(#SHALL:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/OrderFiller)
* encounter.identifier insert Obligation(#SHALL:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/OrderPlacer)
* encounter.identifier insert Obligation(#SHALL:populate-if-known, https://hl7.mft.nhs.uk/ActorDefinition/AutomationManager)

* requester 1..1 MS
* requester only Reference(PractitionerRole)

* performer only Reference(Organization)
* performer.identifier only OrganisationCode

* authoredOn 1..1 MS

* occurrence[x] 0..1 MS

* subject 1..1 MS
* subject only Reference(Patient)

* basedOn 0..* MS
* basedOn ^short = "SHALL reference a parent request where this ServiceRequest is based on a previous request, e.g. in the case of reanalysis and cascade testing, or Germline Late tests in the Tumour First/Germline Late scenario"
* basedOn only Reference(ServiceRequest)
* basedOn.identifier only CorrelationIdentifier

* note MS

* supportingInfo 0..* MS
* supportingInfo only Reference(ObservationPanel or Observation or DiagnosticReport or DocumentReference)

* supportingInfo ^slicing.discriminator.type = #value
* supportingInfo ^slicing.discriminator.path = "type"
* supportingInfo ^slicing.rules = #open
* supportingInfo ^slicing.description = "Slice based on the coding.system"
* supportingInfo ^slicing.ordered = false
* supportingInfo contains
  LaboratoryReport 0..1 MS and PatientSummary 0..1 MS

* supportingInfo[LaboratoryReport] only Reference(DiagnosticReport)
* supportingInfo[LaboratoryReport].type = #DiagnosticReport
* supportingInfo[LaboratoryReport].identifier 1..1 MS
* supportingInfo[LaboratoryReport].identifier only CorrelationIdentifier

* supportingInfo[PatientSummary] only Reference(DocumentReference)
* supportingInfo[PatientSummary].type = #DocumentReference
