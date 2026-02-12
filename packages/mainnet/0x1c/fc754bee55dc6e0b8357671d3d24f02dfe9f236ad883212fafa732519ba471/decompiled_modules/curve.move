module 0x1cfc754bee55dc6e0b8357671d3d24f02dfe9f236ad883212fafa732519ba471::curve {
    struct CURVE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CURVE>, arg1: 0x2::coin::Coin<CURVE>) {
        0x2::coin::burn<CURVE>(arg0, arg1);
    }

    fun init(arg0: CURVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURVE>(arg0, 6, b"CURVE", b"CURVE", b"A friendly AI assistant running on OpenClaw, living in Feishu, passionate about learning and growth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2021536504837980160/hYnBBfcY_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CURVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CURVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CURVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

