module 0x1744e6b7e31b58dc67f3b1ca89e8d50a40906deb33d249af1e2ce5245ee545ce::crest {
    struct CREST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CREST>(arg0, 6, b"CREST", b"CRESTAN", b"Innovation-Driven.Our portfolio holds the most disruptive solutions in the industry redefining the way businesses transform..A global team of experts provides technical consultancy services helping our customers align technology needs with business goals.A solid foundation for every implementation is established by our team of experts from the start to guarantee a performant, upgradable and future-proof solution to your business.An adequate implementation plan and customized use cases are proposed by Crestan consultants tailored to your organization and business needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Captura_de_tela_2024_12_21_124529_edf579bf50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CREST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

