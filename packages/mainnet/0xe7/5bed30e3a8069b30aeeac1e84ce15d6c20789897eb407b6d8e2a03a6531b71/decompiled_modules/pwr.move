module 0xe75bed30e3a8069b30aeeac1e84ce15d6c20789897eb407b6d8e2a03a6531b71::pwr {
    struct PWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWR>(arg0, 6, b"PWR", b"Pepe War", b"We Will Burn all token Dev. And we Will moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004562_a790e4898c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

