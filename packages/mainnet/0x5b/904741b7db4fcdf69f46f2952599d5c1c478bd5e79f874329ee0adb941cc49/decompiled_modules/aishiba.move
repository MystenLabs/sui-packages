module 0x5b904741b7db4fcdf69f46f2952599d5c1c478bd5e79f874329ee0adb941cc49::aishiba {
    struct AISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISHIBA>(arg0, 6, b"AISHIBA", b"AiShiba", b"Next generation AiShiba. http://aishibaog.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_201657_7a03c24692.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AISHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

