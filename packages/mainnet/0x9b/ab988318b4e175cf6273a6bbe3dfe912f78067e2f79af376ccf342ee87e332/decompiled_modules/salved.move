module 0x9bab988318b4e175cf6273a6bbe3dfe912f78067e2f79af376ccf342ee87e332::salved {
    struct SALVED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SALVED>, arg1: 0x2::coin::Coin<SALVED>) {
        0x2::coin::burn<SALVED>(arg0, arg1);
    }

    fun init(arg0: SALVED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALVED>(arg0, 2, b"xSalved", b"", b"Hello bitches", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALVED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALVED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SALVED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SALVED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

