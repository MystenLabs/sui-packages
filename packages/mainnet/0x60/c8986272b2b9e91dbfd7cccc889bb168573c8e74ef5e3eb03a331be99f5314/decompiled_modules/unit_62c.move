module 0x60c8986272b2b9e91dbfd7cccc889bb168573c8e74ef5e3eb03a331be99f5314::unit_62c {
    struct UNIT_62C has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<UNIT_62C>, arg1: 0x2::coin::Coin<UNIT_62C>) {
        0x2::coin::burn<UNIT_62C>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<UNIT_62C>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UNIT_62C> {
        0x2::coin::mint<UNIT_62C>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<UNIT_62C>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIT_62C>>(0x2::coin::mint<UNIT_62C>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: UNIT_62C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIT_62C>(arg0, 9, b"BUT", b"Bucket Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-bzs5wfG2Te.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNIT_62C>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIT_62C>>(v1);
    }

    // decompiled from Move bytecode v6
}

