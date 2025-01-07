module 0xe5d7df1b9523dfeaa01097d7725cee7faf43cc2c3830ff3540228aba8eff1a21::suitizen {
    struct SUITIZEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITIZEN>, arg1: 0x2::coin::Coin<SUITIZEN>) {
        0x2::coin::burn<SUITIZEN>(arg0, arg1);
    }

    fun init(arg0: SUITIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITIZEN>(arg0, 2, b"Suitizen", b"STZ", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITIZEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITIZEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITIZEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITIZEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

