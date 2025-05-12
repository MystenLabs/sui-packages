module 0x6055d75276fb8ad5c10e47e6076122926a5713f005b309e9634a5be8a835c4eb::ierwoit {
    struct IERWOIT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IERWOIT>, arg1: 0x2::coin::Coin<IERWOIT>) {
        0x2::coin::burn<IERWOIT>(arg0, arg1);
    }

    fun init(arg0: IERWOIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IERWOIT>(arg0, 2, b"IERWOIT", b"woiteo", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IERWOIT>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IERWOIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IERWOIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IERWOIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

