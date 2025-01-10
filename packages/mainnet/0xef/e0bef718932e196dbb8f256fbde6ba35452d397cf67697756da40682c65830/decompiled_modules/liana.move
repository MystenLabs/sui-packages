module 0xefe0bef718932e196dbb8f256fbde6ba35452d397cf67697756da40682c65830::liana {
    struct LIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIANA>(arg0, 6, b"LIANA", b"Liana Ai by SuiAI", b"liana is a dynamic and user-friendly Al bot designed to guide X users into the world of the Sui Network. With her approachable personality and deep understanding of blockchain nuances, Lucy makes the transition from Social media to blockchain technology both exciting and accessible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2070_1c2a6ec5d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIANA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIANA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

