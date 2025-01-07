module 0xa166f183c6440d8d4e41cc0888b525a61c6fd4f3118bf577010f1f5493e37088::mewtwo {
    struct MEWTWO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEWTWO>, arg1: 0x2::coin::Coin<MEWTWO>) {
        0x2::coin::burn<MEWTWO>(arg0, arg1);
    }

    fun init(arg0: MEWTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWTWO>(arg0, 2, b"MEW", b"MEWTWO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.pokemoncenter.com/images/DAMRoot/Full-Size/10000/P7782_699-17148_08.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWTWO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWTWO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEWTWO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEWTWO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

