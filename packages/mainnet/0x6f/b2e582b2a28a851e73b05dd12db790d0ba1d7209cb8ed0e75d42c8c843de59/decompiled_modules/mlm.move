module 0x6fb2e582b2a28a851e73b05dd12db790d0ba1d7209cb8ed0e75d42c8c843de59::mlm {
    struct MLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLM>(arg0, 6, b"MLM", b"MakingLifeMultiplanetary", b"Making Life Multiplanetary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6370_42dc7fc4ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

