module 0x2cdf6dfa6ca4612f4a8f8c5f6cd53a23e30f8256aa300505e035141daf321d84::hbunny {
    struct HBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBUNNY>(arg0, 6, b"HBUNNY", b"Hop Bunny", b"The cute bunny now launch on @turbos_finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001474110.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HBUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

