module 0x4e392b49594d541b2c926cdf10fac61c18306d7847f3f216cca4bb8686df10bf::fucktexxas {
    struct FUCKTEXXAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKTEXXAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKTEXXAS>(arg0, 6, b"FUCKTEXXAS", b"FUCKTEXXAS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKTEXXAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKTEXXAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

