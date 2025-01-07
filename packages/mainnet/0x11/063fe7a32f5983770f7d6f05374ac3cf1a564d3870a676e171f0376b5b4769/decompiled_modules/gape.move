module 0x11063fe7a32f5983770f7d6f05374ac3cf1a564d3870a676e171f0376b5b4769::gape {
    struct GAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAPE>(arg0, 6, b"GAPE", b"Goatse", b"The first Gaped Asshole on Turbos!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963776765.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

