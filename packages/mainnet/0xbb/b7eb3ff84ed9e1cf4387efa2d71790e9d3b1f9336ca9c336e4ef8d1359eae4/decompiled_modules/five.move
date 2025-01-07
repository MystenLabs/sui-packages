module 0xbbb7eb3ff84ed9e1cf4387efa2d71790e9d3b1f9336ca9c336e4ef8d1359eae4::five {
    struct FIVE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FIVE>, arg1: 0x2::coin::Coin<FIVE>) {
        0x2::coin::burn<FIVE>(arg0, arg1);
    }

    fun init(arg0: FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVE>(arg0, 6, b"FIVE", b"FIVESUILP", b"https://static-00.iconduck.com/assets.00/high-five-icon-256x256-sbtlv39e.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FIVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

