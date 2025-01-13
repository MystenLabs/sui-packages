module 0x40cc7897e6256b0e072a4796d373811837c0cbdab6e9a7ecac62070ce1a2a257::supply {
    struct SUPPLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPPLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUPPLY>(arg0, 6, b"SUPPLY", b"SupplyVest AI by SuiAI", b"SupplyAI is the native governance token of SupplyVest , aligning incentives, funding development, and empowering community participation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2119_fa1dee1197.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUPPLY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPPLY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

