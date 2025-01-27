module 0x5d375b120a1fb3158ad79ad8caf3db2591b72e5a9d3d98136e24a3db0a429b5f::emosense {
    struct EMOSENSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOSENSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOSENSE>(arg0, 6, b"EmoSense", b"EmoSense AI", b"EmoSense is here to understand you, listen to your feelings, and engage with empathy, clarity, and intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738004018255.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMOSENSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOSENSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

