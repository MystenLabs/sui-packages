module 0x2e4258f942e2424640f6ee3ed293e84afae27bd5f621cf74f4376225ac2a27ee::shwuingandamiss {
    struct SHWUINGANDAMISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHWUINGANDAMISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHWUINGANDAMISS>(arg0, 6, b"Shwuingandamiss", b"Plump", b"SWING AND A MISS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/2024_06_14_14_48_56_7d43fd7f42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHWUINGANDAMISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHWUINGANDAMISS>>(v1);
    }

    // decompiled from Move bytecode v6
}

