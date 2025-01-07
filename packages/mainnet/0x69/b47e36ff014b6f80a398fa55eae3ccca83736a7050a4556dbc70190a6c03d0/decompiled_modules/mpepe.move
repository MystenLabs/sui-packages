module 0x69b47e36ff014b6f80a398fa55eae3ccca83736a7050a4556dbc70190a6c03d0::mpepe {
    struct MPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPEPE>(arg0, 6, b"MPEPE", b"Mpepe", x"496e73706972656420627920746865206c6567656e646172792050657065636f696e20616e642074686520656c65637472696679696e672074616c656e7473206f662070726f66657373696f6e616c20536f6363657220706c61796572204d62617070c3a92c204d50455045207374616e6473206173206120626561636f6e20666f7220756e6974696e6720676c6f62616c20736f6363657220656e746875736961737473207468726f7567682074686520706f776572206f662063727970746f20616e642073706f7274732d72656c61746564206d656d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733496960531.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

