module 0xf6063d6809c4c8bddaee0c0a53f501e01381f596d5d4581989b1752b1c723591::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 6, b"STRESS", b"$STRESS", x"2d3d5468697320426f79206861732041206c6f74206f6620245354524553533d2d0a0a5f2b4d6179626520686520697320526963682b5f0a0a52756e2062792074686520436f6d6d756e69747920666f722074686520436f6d6d756e6974790a0a536f6369616c7320436f6d696e6720736f6f6e0a0a444f4e275420535452455353", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STRESS_138653c863.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

