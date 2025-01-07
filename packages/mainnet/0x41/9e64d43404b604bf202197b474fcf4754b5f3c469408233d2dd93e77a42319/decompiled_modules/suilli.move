module 0x419e64d43404b604bf202197b474fcf4754b5f3c469408233d2dd93e77a42319::suilli {
    struct SUILLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLI>(arg0, 6, b"Suilli", b"Suili", b"Suli on Sui, a tortured soul, wanders the dark expanse of the SUI ecosystem. With hollow eyes and a maniacal grin, Suli embodies the frustrations and despair of navigating the unpredictable world of cryptocurrency. Their sanity unravels as they're tormented by errors, bugs, and inexplicable phenomena.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0541_8c57d866b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

