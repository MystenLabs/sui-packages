module 0x27bc94089bffce5817d4bee1993f5074d23637ef0aaab60fcfe35fe03f0d9b3b::chrett {
    struct CHRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRETT>(arg0, 6, b"CHRETT", b"CHRETT ON SUI", b"Chinese Brett Officially Launched on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHRETT_TQ_Tim_E_Qfu_R_Nn_IX_Yi_FV_bf6ed87131.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

