module 0x7846533d4c7acdc4e7436dbea647ac75e8ffbf215fe0ba4e3714e06312c5a171::suibainu {
    struct SUIBAINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBAINU>, arg1: 0x2::coin::Coin<SUIBAINU>) {
        0x2::coin::burn<SUIBAINU>(arg0, arg1);
    }

    fun init(arg0: SUIBAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAINU>(arg0, 9, b"suibainu.site", b"SUIBAINU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBAINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBAINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBAINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

