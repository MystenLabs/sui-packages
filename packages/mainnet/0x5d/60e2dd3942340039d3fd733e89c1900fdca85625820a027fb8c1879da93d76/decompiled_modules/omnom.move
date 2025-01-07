module 0x5d60e2dd3942340039d3fd733e89c1900fdca85625820a027fb8c1879da93d76::omnom {
    struct OMNOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMNOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMNOM>(arg0, 9, b"OMNOM", b"OmNom", b"He is a noomie green monster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JjMQtKQ.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OMNOM>(&mut v2, 625000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMNOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMNOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

