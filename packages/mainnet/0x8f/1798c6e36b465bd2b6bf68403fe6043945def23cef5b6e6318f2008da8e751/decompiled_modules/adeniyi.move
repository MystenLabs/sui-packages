module 0x8f1798c6e36b465bd2b6bf68403fe6043945def23cef5b6e6318f2008da8e751::adeniyi {
    struct ADENIYI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ADENIYI>, arg1: 0x2::coin::Coin<ADENIYI>) {
        0x2::coin::burn<ADENIYI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ADENIYI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ADENIYI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ADENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIYI>(arg0, 0, b"adeniyi", b"ADENIYI", b"Releap Profile Token: adeniyi", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADENIYI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIYI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<ADENIYI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ADENIYI> {
        0x2::coin::mint<ADENIYI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

