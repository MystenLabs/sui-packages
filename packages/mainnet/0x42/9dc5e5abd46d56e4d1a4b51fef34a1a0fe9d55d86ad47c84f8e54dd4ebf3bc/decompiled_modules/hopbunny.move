module 0x429dc5e5abd46d56e4d1a4b51fef34a1a0fe9d55d86ad47c84f8e54dd4ebf3bc::hopbunny {
    struct HOPBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPBUNNY>(arg0, 6, b"HOPBUNNY", b"HOP", b"Hopbunny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731263483089.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPBUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPBUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

