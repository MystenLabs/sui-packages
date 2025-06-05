module 0x9dcffe2dbd876db7a464aea894561b052066818dcd1597913e105450d921bf35::Maria {
    struct MARIA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MARIA>, arg1: 0x2::coin::Coin<MARIA>) {
        0x2::coin::burn<MARIA>(arg0, arg1);
    }

    fun init(arg0: MARIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIA>(arg0, 9, b"MARIA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MARIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

