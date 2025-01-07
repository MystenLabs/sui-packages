module 0x843184c5f8c81c84d3813b322c4d8b0d2ac903d9c3dd2ceb21538a3ebbc3cb2a::tyrant {
    struct TYRANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYRANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYRANT>(arg0, 9, b"TYRANT", b"SoulFire", b"Our mission is to bridge humanity into the Web3 world by giving them a place to discover and showcase their most cherished passions. Everything on SoulFire is permanent and unique to you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JcP9eOQ.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TYRANT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYRANT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYRANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

