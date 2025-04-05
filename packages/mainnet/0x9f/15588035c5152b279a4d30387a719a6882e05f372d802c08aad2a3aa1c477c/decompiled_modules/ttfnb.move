module 0x9f15588035c5152b279a4d30387a719a6882e05f372d802c08aad2a3aa1c477c::ttfnb {
    struct TTFNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFNB>(arg0, 9, b"TTfnb", b"tyjk", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7c103c31bfe8715894f5f09fe7866fc0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFNB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

