module 0xacac76beed22c7cebe7f9843aad6cfb666e9fbe4e01358d10036e83c98c57681::testest {
    struct TESTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTEST>(arg0, 6, b"TESTEST", b"test", b"teste", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732385105935.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

