module 0x7cdfb1e5ff437e333e14204548e79c9ca96220ed181a54e97751a02e7dc55f44::tdog {
    struct TDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TDOG>, arg1: 0x2::coin::Coin<TDOG>) {
        0x2::coin::burn<TDOG>(arg0, arg1);
    }

    fun init(arg0: TDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOG>(arg0, 9, b"Terminal Dog", b"tDOG", b"an ai dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CPx6vEEAsk4NTLau19LC2KqdDwvs2DAwnjEYUL6ypump.png?size=lg&key=5ec8fc")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDOG>>(v1);
        0x2::coin::mint_and_transfer<TDOG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TDOG>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

