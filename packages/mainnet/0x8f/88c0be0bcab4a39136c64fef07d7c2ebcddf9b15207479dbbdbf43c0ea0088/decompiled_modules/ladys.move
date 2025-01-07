module 0x8f88c0be0bcab4a39136c64fef07d7c2ebcddf9b15207479dbbdbf43c0ea0088::ladys {
    struct LADYS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LADYS>, arg1: 0x2::coin::Coin<LADYS>) {
        0x2::coin::burn<LADYS>(arg0, arg1);
    }

    fun init(arg0: LADYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYS>(arg0, 8, b"LADYS", b"Milady Meme Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/30194/small/logo.png?1683607297")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LADYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LADYS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LADYS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

