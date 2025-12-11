module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori {
    struct DORI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DORI>, arg1: 0x2::coin::Coin<DORI>) : u64 {
        0x2::coin::burn<DORI>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DORI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DORI>>(0x2::coin::mint<DORI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORI>(arg0, 9, b"DORI", b"USD DORI Stablecoin", b"DORI is a collateralized stablecoin issued by Weiss.Finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://weissfi.s3.eu-west-3.amazonaws.com/dori.svg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_return_coin_dori(arg0: &mut 0x2::coin::TreasuryCap<DORI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DORI> {
        0x2::coin::mint<DORI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

