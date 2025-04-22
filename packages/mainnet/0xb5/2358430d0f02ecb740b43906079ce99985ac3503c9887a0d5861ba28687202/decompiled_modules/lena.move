module 0xb52358430d0f02ecb740b43906079ce99985ac3503c9887a0d5861ba28687202::lena {
    struct LENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENA>(arg0, 9, b"Lena", b"L", b"awesome", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e71028ac14eda590f515ab80ec4a6c04blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

