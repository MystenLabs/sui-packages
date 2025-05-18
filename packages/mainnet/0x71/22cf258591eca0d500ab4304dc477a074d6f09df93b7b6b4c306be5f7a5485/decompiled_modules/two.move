module 0x7122cf258591eca0d500ab4304dc477a074d6f09df93b7b6b4c306be5f7a5485::two {
    struct TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWO>(arg0, 6, b"TWO", b"Mewtwo", x"426f726e2066726f6d2074686520444e41206f66204f4e452c206275742065766f6c7665642077697468206174746974756465202d207374726f6e6765722c20736861727065722c20616e6420726561647920746f20646f6d696e6174652074686520636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cscs_3d9c7af224.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

