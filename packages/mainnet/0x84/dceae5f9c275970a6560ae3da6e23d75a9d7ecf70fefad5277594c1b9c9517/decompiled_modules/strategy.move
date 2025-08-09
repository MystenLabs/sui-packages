module 0x84dceae5f9c275970a6560ae3da6e23d75a9d7ecf70fefad5277594c1b9c9517::strategy {
    struct STRATEGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRATEGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRATEGY>(arg0, 6, b"STRATEGY", b"Fartcoin Strategic Reserve", x"46617274636f696e20537472617465676963205265736572766520e280942074686520747265617375727920626568696e642046617274636f696e206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fartcoinonsui.com/images/strategy_logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STRATEGY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRATEGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRATEGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

