module 0x9942b3b19533dfa64d9cef864b51de9f48b6c3dc60eb942f31b376b6c8d708de::seiro {
    struct SEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEIRO>(arg0, 6, b"SEIRO", b"SEIRO SUI", x"24534549524f20736561736f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_91ud_WYA_Awz_KK_fb4e04fd9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

