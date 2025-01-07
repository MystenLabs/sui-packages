module 0x13b58c95a4acbb0850493c3b6dc23f2b974f13f8fa306816a820d848d677bbd1::LADYS {
    struct LADYS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LADYS>, arg1: 0x2::coin::Coin<LADYS>) {
        0x2::coin::burn<LADYS>(arg0, arg1);
    }

    fun init(arg0: LADYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYS>(arg0, 9, b"LADYS", b"ladys", b"https://s2.coinmarketcap.com/static/img/coins/64x64/25023.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LADYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LADYS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LADYS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

