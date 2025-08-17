module 0x599959c16726cae12b10089530ae7598e2bdfe6ebe9f72c0695fae78d52951c7::BENJI {
    struct BENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENJI>(arg0, 6, b"COOL BENJI", b"BENJI", b"The legendary BENJI himself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreigd4qtnanfb76fbvhohlrm7arn7cx4bipa4tqxjiwc4gsolk2be2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENJI>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

