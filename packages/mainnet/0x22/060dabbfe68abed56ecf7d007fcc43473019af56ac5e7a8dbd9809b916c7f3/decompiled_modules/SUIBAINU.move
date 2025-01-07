module 0x22060dabbfe68abed56ecf7d007fcc43473019af56ac5e7a8dbd9809b916c7f3::SUIBAINU {
    struct SUIBAINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBAINU>, arg1: 0x2::coin::Coin<SUIBAINU>) {
        0x2::coin::burn<SUIBAINU>(arg0, arg1);
    }

    fun init(arg0: SUIBAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAINU>(arg0, 2, b"SUIBA", b"SUIBA INU", b"Woof Woof", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBAINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBAINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBAINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

