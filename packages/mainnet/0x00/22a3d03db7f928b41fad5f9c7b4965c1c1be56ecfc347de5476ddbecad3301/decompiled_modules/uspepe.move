module 0x22a3d03db7f928b41fad5f9c7b4965c1c1be56ecfc347de5476ddbecad3301::uspepe {
    struct USPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USPEPE>, arg1: 0x2::coin::Coin<USPEPE>) {
        0x2::coin::burn<USPEPE>(arg0, arg1);
    }

    fun init(arg0: USPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USPEPE>(arg0, 9, b"USPEPE", b"USA PEPE", x"4a75737420506570652055534120436f6d6520546f2053554920426c6f636b636861696e20f09f87baf09f87b8f09f87baf09f87b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://suicreate.com/uploads/logo_1767291595090_a965d790.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

