module 0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube {
    struct CUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUBE>(arg0, 0, b"CUBE", b"Force Cube", b"Utility token for Mental Marvin project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmP4eoX2bxcGdGgjuXxQApcqfWFvVdikG5ZeR64J1YGhLG")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CUBE>>(0x2::coin::mint<CUBE>(&mut v2, 100000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CUBE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

