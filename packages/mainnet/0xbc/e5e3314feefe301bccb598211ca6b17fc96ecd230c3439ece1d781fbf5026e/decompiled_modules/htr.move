module 0xbce5e3314feefe301bccb598211ca6b17fc96ecd230c3439ece1d781fbf5026e::htr {
    struct HTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTR>(arg0, 9, b"HTR", b"yul", b"ydeul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9f469de979b32255aa10142563caab4dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

