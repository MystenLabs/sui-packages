module 0xe680334eecd5d18335578ecc2936ea236ba9eb20c8a6bcd6d80def8f6b11c732::suibian {
    struct SUIBIAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBIAN>, arg1: 0x2::coin::Coin<SUIBIAN>) {
        0x2::coin::burn<SUIBIAN>(arg0, arg1);
    }

    fun init(arg0: SUIBIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIAN>(arg0, 2, b"SUIBIAN", b"SUIB", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBIAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBIAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

