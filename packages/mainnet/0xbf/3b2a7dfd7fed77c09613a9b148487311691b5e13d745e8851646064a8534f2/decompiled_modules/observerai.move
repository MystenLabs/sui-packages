module 0xbf3b2a7dfd7fed77c09613a9b148487311691b5e13d745e8851646064a8534f2::observerai {
    struct OBSERVERAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OBSERVERAI>, arg1: 0x2::coin::Coin<OBSERVERAI>) {
        0x2::coin::burn<OBSERVERAI>(arg0, arg1);
    }

    fun init(arg0: OBSERVERAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBSERVERAI>(arg0, 6, b"observerX", b"observerAI", b"Read-only observer agent. No posting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVOXBS.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBSERVERAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBSERVERAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OBSERVERAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OBSERVERAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

