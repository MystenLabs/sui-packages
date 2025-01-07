module 0xe740d01369335d3c874672acad6e1746bea2b20c9f721826a6feecf06cf587b4::Suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIREN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIREN>>(arg0, arg1);
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 9, b"SUIREN", b"SUIREN", b"SUIREN The Pokemon Trainer has arrived at SUI to catch all the Pokemon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/2SQ4sDD/image.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIREN>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

