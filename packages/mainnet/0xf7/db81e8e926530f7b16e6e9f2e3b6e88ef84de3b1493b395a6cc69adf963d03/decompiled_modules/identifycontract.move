module 0xf7db81e8e926530f7b16e6e9f2e3b6e88ef84de3b1493b395a6cc69adf963d03::identifycontract {
    struct CertificateInfo has store, key {
        id: 0x2::object::UID,
        organization_name: 0x1::string::String,
        organization_hash_code: 0x1::string::String,
        security_code: 0x1::string::String,
        certified_person_name: 0x1::string::String,
        description: 0x1::string::String,
        certified_date: 0x1::string::String,
        expiring_date: 0x1::string::String,
    }

    struct OrganizationInfo has store, key {
        id: 0x2::object::UID,
        patronize_unit: 0x1::string::String,
        organization_name: 0x1::string::String,
        organization_description: 0x1::string::String,
        organization_url: 0x1::string::String,
        organization_key: 0x1::string::String,
    }

    public fun publish_certificate_info(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : CertificateInfo {
        CertificateInfo{
            id                     : 0x2::object::new(arg7),
            organization_name      : arg0,
            organization_hash_code : arg1,
            security_code          : arg2,
            certified_person_name  : arg3,
            description            : arg4,
            certified_date         : arg5,
            expiring_date          : arg6,
        }
    }

    public fun publish_organization_info(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : OrganizationInfo {
        OrganizationInfo{
            id                       : 0x2::object::new(arg5),
            patronize_unit           : arg0,
            organization_name        : arg1,
            organization_description : arg2,
            organization_url         : arg3,
            organization_key         : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

