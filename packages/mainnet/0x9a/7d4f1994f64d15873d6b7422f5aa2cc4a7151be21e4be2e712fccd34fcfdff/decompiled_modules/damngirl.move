module 0x9a7d4f1994f64d15873d6b7422f5aa2cc4a7151be21e4be2e712fccd34fcfdff::damngirl {
    struct DAMNGIRL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DAMNGIRL>, arg1: 0x2::coin::Coin<DAMNGIRL>) {
        0x2::coin::burn<DAMNGIRL>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAMNGIRL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DAMNGIRL>>(0x2::coin::mint<DAMNGIRL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DAMNGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAMNGIRL>(arg0, 9, b"damngirl", b"DAMNGIRL", b"damn girl", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAMNGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAMNGIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

