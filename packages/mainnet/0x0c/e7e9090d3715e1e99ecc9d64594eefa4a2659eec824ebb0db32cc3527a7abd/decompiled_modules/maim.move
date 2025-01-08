module 0xce7e9090d3715e1e99ecc9d64594eefa4a2659eec824ebb0db32cc3527a7abd::maim {
    struct MAIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIM>(arg0, 6, b"MAIM", b"MovAIMate", b"The MovAIMate Token introduces a charming, cinema-themed AI companion designed to captivate movie enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736367438731.14")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

