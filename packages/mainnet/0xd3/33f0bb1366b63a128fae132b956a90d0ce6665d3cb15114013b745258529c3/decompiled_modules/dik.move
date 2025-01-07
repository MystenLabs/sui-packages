module 0xd333f0bb1366b63a128fae132b956a90d0ce6665d3cb15114013b745258529c3::dik {
    struct DIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DIK>(arg0, 6, b"DIK", b"dik by SuiAI", b"dik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/los_angeles_6dddbaa3d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

