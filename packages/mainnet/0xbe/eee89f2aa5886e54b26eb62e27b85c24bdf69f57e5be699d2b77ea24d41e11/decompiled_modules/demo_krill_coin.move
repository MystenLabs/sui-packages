module 0xbeeee89f2aa5886e54b26eb62e27b85c24bdf69f57e5be699d2b77ea24d41e11::demo_krill_coin {
    struct DEMO_KRILL_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO_KRILL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO_KRILL_COIN>(arg0, 5, b"dKRILL", b"Demo KRILL Coin", b"Demo KRILL Coin for Demo Purposes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/vJpUSuM.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEMO_KRILL_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<DEMO_KRILL_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DEMO_KRILL_COIN>>(v2);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEMO_KRILL_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEMO_KRILL_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

