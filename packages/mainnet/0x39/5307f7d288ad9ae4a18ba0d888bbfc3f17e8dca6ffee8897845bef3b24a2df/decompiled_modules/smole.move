module 0x395307f7d288ad9ae4a18ba0d888bbfc3f17e8dca6ffee8897845bef3b24a2df::smole {
    struct SMOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLE>(arg0, 6, b"SMOLE", b"smolecoin", x"6120736d6f6c206d6f6c6520616e642074686520736d6f6c6c65737420736d6f6c65636f696e20696e2074686520736d6f6c616e6120736d6f6c6e65740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p2_Xw65_Ju_400x400_b9a45a0e49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

