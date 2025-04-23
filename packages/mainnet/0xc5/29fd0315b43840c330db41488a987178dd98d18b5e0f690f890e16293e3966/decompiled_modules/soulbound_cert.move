module 0xc529fd0315b43840c330db41488a987178dd98d18b5e0f690f890e16293e3966::soulbound_cert {
    struct SoulboundCertificate has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        event: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun mint(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SoulboundCertificate{
            id        : 0x2::object::new(arg4),
            name      : arg1,
            event     : arg2,
            image_url : arg3,
        };
        0x2::transfer::transfer<SoulboundCertificate>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

