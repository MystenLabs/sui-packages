module 0x17011f306e7cdbbcc1652139482426eb86d3ba66c351e4569b6e8ee0f5025fa::duk {
    struct DUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUK>(arg0, 6, b"Duk", b"Dolan Trump", b"Maga duk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/00_D1_D343_48_BB_430_D_886_C_44_D81_A5_D4_B8_D_3ddb93ef80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

