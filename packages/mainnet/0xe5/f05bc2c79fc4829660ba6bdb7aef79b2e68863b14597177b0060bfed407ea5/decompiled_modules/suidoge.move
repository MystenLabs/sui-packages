module 0xe5f05bc2c79fc4829660ba6bdb7aef79b2e68863b14597177b0060bfed407ea5::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDOGE>, arg1: 0x2::coin::Coin<SUIDOGE>) {
        0x2::coin::burn<SUIDOGE>(arg0, arg1);
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 4, b"SuiDoge", b"SuiDoge", b"SuiDoge is a meme coin set up for rapid expansion of DOGE and SUI ecosystem. It has unique fun and perfect token model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidoge.dog/sui/suidoge.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

