module 0xcfab95290fd28cb5a98d8c9df477c7075eeffddf6fc99e1ff76000d5bab4f5d6::fii {
    struct FII has drop {
        dummy_field: bool,
    }

    fun init(arg0: FII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FII>(arg0, 6, b"Fii", b"Fii Ai", b"https://www.tiktok.com/@fii_swap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020425_86bc046eb2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FII>>(v1);
    }

    // decompiled from Move bytecode v6
}

