module 0xd83046f2726a529fd36619d04d6a9396efceef27cdd8d41ef56c8c55eebffef5::spad {
    struct SPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAD>(arg0, 6, b"SPAD", b"SuiPad", x"4c61756e6368706164204f66205355490a4d6f726520656173790a4d6f72652043686561700a4d6f726520536166657479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241005_141123_878_a5a5564fac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

