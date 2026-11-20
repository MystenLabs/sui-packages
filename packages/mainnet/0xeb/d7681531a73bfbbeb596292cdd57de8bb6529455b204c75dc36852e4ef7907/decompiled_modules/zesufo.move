module 0xebd7681531a73bfbbeb596292cdd57de8bb6529455b204c75dc36852e4ef7907::zesufo {
    struct ZESUFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZESUFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<ZESUFO>(arg0, 9, 0x1::string::utf8(b"ZESUFO"), 0x1::string::utf8(b"Zesufot"), 0x1::string::utf8(b"Zesufot on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ZESUFO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ZESUFO>>(0x2::coin_registry::finalize<ZESUFO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

