module 0x357c957992c7bfaeb45a8e3c0b301b8c276a6999a270a4489632e81f23571294::dfs {
    struct DFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFS>(arg0, 6, b"DFS", b"Devisfishsui", b"Sui dev is not a human ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/devin_aa5041e0a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

