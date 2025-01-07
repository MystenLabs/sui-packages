module 0xa17b17702cb92a938dc4d5c5fbb8c18453907fb1701640b2231a9e8ac95241a3::fun8 {
    struct FUN8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN8>(arg0, 9, b"FUN8", b"8K Fun", b"Hello darkness my old friend. I've come to talk with you again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/b728aab2cc2cf699ac3571c37290ff7cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN8>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN8>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

