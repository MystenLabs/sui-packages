module 0x4d56ac7e6b18b47ecf207e709bec98bee83a32804a408fe9cfffda6b6fce5265::kero {
    struct KERO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KERO>, arg1: 0x2::coin::Coin<KERO>) {
        0x2::coin::burn<KERO>(arg0, arg1);
    }

    fun init(arg0: KERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERO>(arg0, 9, b"KERORO", b"KERO", b"Keroro is the most famous asian frog and a japanese cult meme inspired by the mischief of Sergeant Keroro and his platoon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2Z6TocWzKtddxVe9kxCB3j3A339Z6CDiut5k3a9Apump.png?size=lg&key=d932b5")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KERO>>(v1);
        0x2::coin::mint_and_transfer<KERO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KERO>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KERO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KERO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

