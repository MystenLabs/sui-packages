module 0x5330d0a3d4edd87e3a9397a5c1b3d39f754eda0016cda198448bcdc7df252cf4::twhale8045 {
    struct TWHALE8045 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWHALE8045, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWHALE8045>(arg0, 9, b"TWHALE8045", b"Thunder Whale #8045", b"Making waves in the digital ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/thunder-whale.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWHALE8045>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWHALE8045>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

