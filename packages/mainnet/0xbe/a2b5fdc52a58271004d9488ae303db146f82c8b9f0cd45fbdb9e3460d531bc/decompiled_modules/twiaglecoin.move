module 0xbea2b5fdc52a58271004d9488ae303db146f82c8b9f0cd45fbdb9e3460d531bc::twiaglecoin {
    struct TWIAGLECOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TWIAGLECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TWIAGLECOIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TWIAGLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIAGLECOIN>(arg0, 6, b"twiagleCoin", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIAGLECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIAGLECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

