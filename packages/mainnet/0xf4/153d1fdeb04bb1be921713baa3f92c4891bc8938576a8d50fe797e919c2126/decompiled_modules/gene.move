module 0xf4153d1fdeb04bb1be921713baa3f92c4891bc8938576a8d50fe797e919c2126::gene {
    struct GENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENE>(arg0, 6, b"GENE", b"Gene AI", b"The GENE token gives holders access to GENE's network of scientific communities and IP, enabling broad exposure to the DeSci economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735718405180.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

