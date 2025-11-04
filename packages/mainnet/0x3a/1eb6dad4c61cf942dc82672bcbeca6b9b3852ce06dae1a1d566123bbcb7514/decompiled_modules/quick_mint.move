module 0x3a1eb6dad4c61cf942dc82672bcbeca6b9b3852ce06dae1a1d566123bbcb7514::quick_mint {
    struct CertificateRecord has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        event: 0x1::string::String,
        issued_date: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintCertificateEvent has copy, drop {
        student: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = CertificateRecord{
            id          : 0x2::object::new(arg2),
            owner       : v0,
            name        : arg0,
            event       : 0x1::string::utf8(b"Successfully completed the Sui Learning Tour x Gia Dinh University 2025 Workshop."),
            issued_date : 0x1::string::utf8(b"2025-11-01"),
            image_url   : arg1,
        };
        0x2::transfer::transfer<CertificateRecord>(v1, v0);
        let v2 = MintCertificateEvent{
            student   : v0,
            name      : arg0,
            image_url : arg1,
        };
        0x2::event::emit<MintCertificateEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

