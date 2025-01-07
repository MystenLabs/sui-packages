module 0x7ee45e40ab4197a50089f083094b540691fa92c1443535b153465d3e9ce1e5e9::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTER>(arg0, 6, b"MONSTER", b"Monster Fish", x"57656c636f6d6520746f20746865206d6f73742073636172792070726f6a656374206f662074686973206f6365616e206f6620537569204e6574776f726b2e0a444f204e4f542050524553533a68747470733a2f2f7777772e74696b746f6b2e636f6d2f40656c63726f6e6f7669736f722f766964656f2f373430373531333732353338363635373035373f713d6d6f6e737465722532306669736826743d313732373733363531333437300a0a20583a68747470733a2f2f782e636f6d2f536369656e63654368616e6e656c2f7374617475732f31363636383935323632393836343238343337", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capa_581cb7f0d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

