module 0x9b6ab8cad4b01de34d552031e58175b41b9b39c2454ddebe3a18955afccf4e95::STROLL {
    struct STROLL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STROLL>, arg1: 0x2::coin::Coin<STROLL>) {
        0x2::coin::burn<STROLL>(arg0, arg1);
    }

    fun init(arg0: STROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STROLL>(arg0, 9, b"$STROLL", b"SUITROLLFACELAUCNHTOMORROW https://t.me/suitroll", b"Best Meme Coin on SuiNetwork Launch 5PM UTC 5th May #Sui #pepe #meme #airdrop #mainnet $bob #Trollface $MEME $PEPE , https://twitter.com/suitrollface , https://t.me/suitroll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/trollface.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STROLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STROLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STROLL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STROLL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

