module 0x9f9a3abe61e44dd26933d0f16ff8fd4c5026ca6d713cdf6a8e36368274b04660::sdr {
    struct SDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDR>(arg0, 6, b"SDR", b"Sui Dish Rug", b"Do not buy, it's a sui dish rug.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_454bfe6870.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

