module 0x583e1267b569e2f5f530bab38bc13b9168bc39d5adc77ea6a5478d59ef8605a7::srtuy {
    struct SRTUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRTUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRTUY>(arg0, 9, b"SRTUY", b"szrtj", b"o8674", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b1a03526e71f78de6a52316af658c7d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRTUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRTUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

