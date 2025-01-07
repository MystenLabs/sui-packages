module 0x65f4f5278977d8ea52b2e1ed33182238d18ff0f34bb55371953c2b39f0c14865::POKERFACE {
    struct POKERFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKERFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKERFACE>(arg0, 6, b"PokerFace", b"PF", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKERFACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKERFACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POKERFACE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<POKERFACE>(arg0) + arg1 <= 1000000000000000, 101);
        0x2::coin::mint_and_transfer<POKERFACE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

