module 0x48a8b5e34bd692322861eff51de26a46f0c72c9d5b8aa816bde420b7c364103b::SUITROLLFACE {
    struct SUITROLLFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITROLLFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITROLLFACE>(arg0, 9, b"$STROLL", b"SUITROLLFACELAUCNHTOMORROW https://t.me/suitroll", b"Best Meme Coin on SuiNetwork Launch 5PM UTC 5th May #Sui #pepe #meme #airdrop #mainnet $bob #Trollface $MEME $PEPE , https://twitter.com/suitrollface , https://t.me/suitroll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/trollface.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITROLLFACE>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITROLLFACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITROLLFACE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

