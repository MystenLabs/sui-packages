module 0xd807c96963a8e2125b5aa3dfc567ec5832601d61321ad602bf4a4648f7331fbc::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWIF>, arg1: 0x2::coin::Coin<SWIF>) {
        0x2::coin::burn<SWIF>(arg0, arg1);
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 2, b"SWIF", b"SUIWIF", b"WIF ON SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWIF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWIF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

