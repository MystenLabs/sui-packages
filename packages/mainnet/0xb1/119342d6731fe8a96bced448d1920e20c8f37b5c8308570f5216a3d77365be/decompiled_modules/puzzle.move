module 0xb1119342d6731fe8a96bced448d1920e20c8f37b5c8308570f5216a3d77365be::puzzle {
    struct PUZZLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUZZLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUZZLE>(arg0, 6, b"PUZZLE", b"Sui Puzzle", x"506965636520697420746f6765746865722077697468202450555a5a4c452e204576657279206d6f766520636f6e6e6563747320796f7520746f20736f6d657468696e672062696767657220696e2074686520537569204e6574776f726b2e20536f6c7665207468652070757a7a6c6520616e6420756e6c6f636b2068696464656e20726577617264732120506c6179207468652050757a7a6c65206f6e2074686520576562736974652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_78_61c9c1614b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUZZLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUZZLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

