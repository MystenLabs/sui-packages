module 0xdfd391a0a8fc8e7452b536d9d0604a615b0743aef9a7063ef91607f94819365f::harambeai {
    struct HARAMBEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARAMBEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HARAMBEAI>(arg0, 6, b"HARAMBEAI", b"Harambe AI by SuiAI", x"486172616d62652041492068617320617272697665642120f09fa68d204a6f696e20746865207374726f6e6765737420636f6d6d756e697479206f6e205355414920616e6420657870657269656e63652074686520706f776572206f6620486172616d62652e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Harambe_8f6a677276.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HARAMBEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAMBEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

