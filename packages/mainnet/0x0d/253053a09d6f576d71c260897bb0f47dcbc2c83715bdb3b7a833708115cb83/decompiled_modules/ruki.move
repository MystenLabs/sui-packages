module 0xd253053a09d6f576d71c260897bb0f47dcbc2c83715bdb3b7a833708115cb83::ruki {
    struct RUKI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RUKI>, arg1: 0x2::coin::Coin<RUKI>) {
        0x2::coin::burn<RUKI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RUKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RUKI>>(0x2::coin::mint<RUKI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUKI>(arg0, 9, b"ruki", b"RUKI", b"ruki test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

