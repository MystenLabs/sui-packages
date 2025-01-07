module 0x3ce4097c5b2d29b9db0dbfb9151a06fa9f62e9c7071d103d8372a34707e62a89::zelda {
    struct ZELDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELDA>(arg0, 6, b"ZELDA", b"First Zelda On Sui", b" Meet First Zelda On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_14_0d762226d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZELDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

