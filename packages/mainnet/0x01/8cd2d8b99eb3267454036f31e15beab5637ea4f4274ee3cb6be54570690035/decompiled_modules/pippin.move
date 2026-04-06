module 0x18cd2d8b99eb3267454036f31e15beab5637ea4f4274ee3cb6be54570690035::pippin {
    struct PIPPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPIN>(arg0, 6, b"PIPPIN", b"Pippin Meme Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIPPIN>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIPPIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

