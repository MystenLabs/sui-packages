module 0x7e680d023327bd597a1a4b63adca3f0c52c1ab3e8eaf35ac35caeea86bfa5c71::SCHEEMS {
    struct SCHEEMS has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SCHEEMS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SCHEEMS>>(arg0, arg1);
    }

    fun init(arg0: SCHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHEEMS>(arg0, 9, b"SCHEEMS", b"SCHEEMS", b"SCHEEMS", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SCHEEMS>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHEEMS>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCHEEMS>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCHEEMS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCHEEMS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

