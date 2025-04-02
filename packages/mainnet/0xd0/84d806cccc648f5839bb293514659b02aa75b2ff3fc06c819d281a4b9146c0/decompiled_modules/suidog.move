module 0xd084d806cccc648f5839bb293514659b02aa75b2ff3fc06c819d281a4b9146c0::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"SUI DOG", x"f09f9a802053756920446f67202824535549444f472920e280932054686520466972737420416e696d616c2d4261736564204d656d65636f696e206f6e205375692120f09f90b6f09f928e0a4d6565742053756920446f67202824535549444f472920e280932074686520747261696c626c617a696e672066697273742d6576657220616e696d616c2d6261736564206d656d65636f696e206f6e20746865206c696768746e696e672d666173742053756920626c6f636b636861696e2120506f776572656420627920696e6e6f766174696f6e2c206675656c656420627920636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743568044540.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

