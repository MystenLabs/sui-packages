module 0x80d160895b0c8b60c0e6dce7e04e86013c958161c58f9eea128ebb82e37f7b34::nail {
    struct NAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAIL>(arg0, 6, b"NAIL", b"snail on Sui", x"4272696e67696e6720796f7520636f6d6d756e6974792c2076616c756520616e6420666169726e6573732e2057652061726520246e61696c206f6e20537569210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snail_on_Sui_b8e0ba6e90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

