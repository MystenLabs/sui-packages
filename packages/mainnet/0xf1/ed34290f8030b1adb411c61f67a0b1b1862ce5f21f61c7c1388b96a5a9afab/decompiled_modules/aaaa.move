module 0xf1ed34290f8030b1adb411c61f67a0b1b1862ce5f21f61c7c1388b96a5a9afab::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 6, b"AAAA", b"NIQUE", b"AAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1792130051741.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

