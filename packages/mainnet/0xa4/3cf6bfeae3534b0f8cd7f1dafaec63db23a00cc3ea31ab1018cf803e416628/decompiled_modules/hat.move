module 0xa43cf6bfeae3534b0f8cd7f1dafaec63db23a00cc3ea31ab1018cf803e416628::hat {
    struct HAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAT>(arg0, 6, b"HAT", b"SAGMI HAT", b"Put on your hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_230758_1d0de5b00e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

