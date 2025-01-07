module 0x5de7a0e42da58241e390fa139a1d1b82e4761116a99e46790c7feec81b828108::retardia {
    struct RETARDIA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RETARDIA>, arg1: 0x2::coin::Coin<RETARDIA>) {
        0x2::coin::burn<RETARDIA>(arg0, arg1);
    }

    fun init(arg0: RETARDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIA>(arg0, 9, b"Retardia", b"Retardia", b"Dumbass put his shitty call channel for tg link", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7RrLheV7dSecVka3MfjYb4Wa6Z6uegNyzhpFeERsfFZP/header.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETARDIA>>(v1);
        0x2::coin::mint_and_transfer<RETARDIA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RETARDIA>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RETARDIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RETARDIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

