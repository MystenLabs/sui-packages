module 0xf6dec8d386596542a27e387841ee84fd2bcffb0f51e01708cb62330099b87dbd::SPACEFI {
    struct SPACEFI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPACEFI>, arg1: 0x2::coin::Coin<SPACEFI>) {
        0x2::coin::burn<SPACEFI>(arg0, arg1);
    }

    fun init(arg0: SPACEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEFI>(arg0, 9, b"SPACE", b"SPACE FI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACEFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPACEFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPACEFI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

