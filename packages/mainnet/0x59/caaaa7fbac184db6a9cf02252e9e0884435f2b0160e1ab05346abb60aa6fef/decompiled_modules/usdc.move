module 0x59caaaa7fbac184db6a9cf02252e9e0884435f2b0160e1ab05346abb60aa6fef::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: 0x2::coin::Coin<USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<USDC>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::mint<USDC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<USDC>(arg0, 6, b"USDC", b"USDC", x"5553444320e280942055534420436f696e20737461626c65636f696e206f6e205375692e2050656767656420313a3120746f205553442e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://6778953.fs1.hubspotusercontent-na1.net/hubfs/6778953/Brand/USDC/USDC_Icon.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<USDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<USDC>>(v0);
    }

    // decompiled from Move bytecode v6
}

