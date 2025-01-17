module 0xae9b18ee7e3ea893277cebcd991447fae018c82749c8c2bf8e4f2378dee01bbe::her {
    struct HER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HER>(arg0, 6, b"HER", b"H.E.RonSUI by SuiAI", b"New agent allowing fast easy access to new SUI tokens which are all validated and on the ay to be bonded for early birds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_8607853007.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

