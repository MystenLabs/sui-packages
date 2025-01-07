module 0x198815881a99fa01658a8cf136475e4205f9d281a2a5929c185f89e96457bf82::SUITROLLFACE {
    struct SUITROLLFACE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUITROLLFACE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITROLLFACE>>(arg0, arg1);
    }

    fun init(arg0: SUITROLLFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITROLLFACE>(arg0, 9, b"$STROLL", b"SUITROLLFACELAUCNHTODAY https://t.me/suitroll", b"Best Meme Coin on SuiNetwork Launch 5PM UTC 5th May #Sui #pepe #meme #airdrop #mainnet $bob #Trollface $MEME $PEPE , https://twitter.com/suitrollface , https://t.me/suitroll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/trollface.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUITROLLFACE>(&mut v2, 600000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITROLLFACE>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITROLLFACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

