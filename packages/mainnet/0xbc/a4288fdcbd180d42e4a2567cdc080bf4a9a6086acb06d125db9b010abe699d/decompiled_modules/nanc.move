module 0xbca4288fdcbd180d42e4a2567cdc080bf4a9a6086acb06d125db9b010abe699d::nanc {
    struct NANC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NANC>, arg1: 0x2::coin::Coin<NANC>) {
        0x2::coin::burn<NANC>(arg0, arg1);
    }

    fun init(arg0: NANC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANC>(arg0, 2, b"NANC", b"NO AIRDROP NO COMMUNITY", b"FUCK", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NANC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NANC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

