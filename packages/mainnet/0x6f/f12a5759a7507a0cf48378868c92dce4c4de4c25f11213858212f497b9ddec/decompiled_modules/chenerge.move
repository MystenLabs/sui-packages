module 0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge {
    struct CHENERGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHENERGE>, arg1: 0x2::coin::Coin<CHENERGE>) {
        0x2::coin::burn<CHENERGE>(arg0, arg1);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<CHENERGE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHENERGE>>(arg0, arg1);
    }

    fun init(arg0: CHENERGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENERGE>(arg0, 6, b"CHENERGE", b"CHENERGE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHENERGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENERGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHENERGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<CHENERGE>(arg0) + arg1 <= 100000000000, 99);
        0x2::coin::mint_and_transfer<CHENERGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

