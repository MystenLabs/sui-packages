module 0x7d5b32874ad6d32e91351baa980d3d7de72b84e4aa4adc59e6dc3c37c79236d2::suimatrix {
    struct SUIMATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMATRIX>(arg0, 6, b"SuiMatrix", b"Prompt Enginering Matrix Sui", b"Imagine an AI that can adapt to your needs in real-time. Prompt Matrix Engineering on Sui brings this vision to life, with applications ranging from personalized recommendations to autonomous systems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7320_94ba205215.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMATRIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMATRIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

