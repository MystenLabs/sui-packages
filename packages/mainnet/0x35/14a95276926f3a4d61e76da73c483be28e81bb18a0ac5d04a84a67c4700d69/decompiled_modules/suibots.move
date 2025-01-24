module 0x3514a95276926f3a4d61e76da73c483be28e81bb18a0ac5d04a84a67c4700d69::suibots {
    struct SUIBOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOTS>(arg0, 9, b"SUIBOTS", b"Sui Bots", b"AI Agents for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBOTS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

