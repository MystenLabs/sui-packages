module 0xa9b4062f393fe89cd7b47ec9c23d0254f507fe8bbeb55c04dadbbfc7f5016da::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 6, b"BRO", b"Brother on SUI", b"Hey BROTHER !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicofp5646jz4h4mn7agwfw3q6vjx2dctycllks6ik6yval52svm5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

