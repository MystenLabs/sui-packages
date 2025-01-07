module 0x5651dadcfa1b60f288ee6018055fa6b6b6cb384bb1204e276129a56932dfa44a::moisa {
    struct MOISA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOISA>, arg1: 0x2::coin::Coin<MOISA>) {
        0x2::coin::burn<MOISA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOISA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOISA>>(0x2::coin::mint<MOISA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOISA>(arg0, 9, b"moisa", b"MOISA", b"test moisa", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOISA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOISA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

