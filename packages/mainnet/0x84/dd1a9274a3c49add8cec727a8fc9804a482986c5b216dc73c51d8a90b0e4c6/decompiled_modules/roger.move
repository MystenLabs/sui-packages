module 0x84dd1a9274a3c49add8cec727a8fc9804a482986c5b216dc73c51d8a90b0e4c6::roger {
    struct ROGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGER>(arg0, 6, b"ROGER", b"Roger", x"524f4745522c2074686520666c616d626f79616e7420616c69656e2066726f6d20416d65726963616e20446164212c2077617320637265617465642062792053657468204d61634661726c616e652c2077686f20766f696365732068696d0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_0718e01740_bf6a810c5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

