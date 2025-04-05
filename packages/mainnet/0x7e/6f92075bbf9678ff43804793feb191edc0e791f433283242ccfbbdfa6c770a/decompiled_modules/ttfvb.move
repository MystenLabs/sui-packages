module 0x7e6f92075bbf9678ff43804793feb191edc0e791f433283242ccfbbdfa6c770a::ttfvb {
    struct TTFVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFVB>(arg0, 9, b"TTfvb", b"tght", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cf9d84db0eb9e62e4f9c21c532acafd4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFVB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFVB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

