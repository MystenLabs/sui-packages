module 0x3f6fcc94774834478747d92ee3e0b49d63026ce098f01e748abb11c8440e39e1::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 6, b"SBB", b"Baby Sui", b"SUI's baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_XLB_Hu9_C_400x400_9db0192f13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

