module 0x4c81ef00cd26449dd552c291eee3f43fb1f3ab2c0dd6c29d4d99af0e8b137aad::land {
    struct LAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAND>(arg0, 6, b"LAND", b"LANDWU SUI", b"FIRST LANDWU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_1_2_aaacd3bc08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

