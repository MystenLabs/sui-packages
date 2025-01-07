module 0x75185e428a7814c79a90563ccc421a16b93fae579c9507ac263dee2894f6b661::RITO {
    struct RITO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RITO>, arg1: 0x2::coin::Coin<RITO>) {
        0x2::coin::burn<RITO>(arg0, arg1);
    }

    fun init(arg0: RITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RITO>(arg0, 9, b"RITO", b"SuiRito", b"We are issuing the SuiRito token exclusively for our ecosystem. In the future, we will integrate our token as a payment method in the Sword Art Online game that will be released soon..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/kDLhVC9/kirito.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RITO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RITO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RITO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RITO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

