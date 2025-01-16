module 0xac0c9d26258fcac057eb446a7020180605497694fc8fc2d0984ceb5143de0ce0::lofai {
    struct LOFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFAI>(arg0, 6, b"LOFAI", b"LOFI AI", b"From the mythical Yeti to a futuristic AI, Lofi AI has evolved into a cutting-edge Dev Agent. As an analyst on X, he shares SUI insights and onboards new users. Chat with him on Telegram and experience the power of $LOFAI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lofi_AI_Logo_6f7fdfa3b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

