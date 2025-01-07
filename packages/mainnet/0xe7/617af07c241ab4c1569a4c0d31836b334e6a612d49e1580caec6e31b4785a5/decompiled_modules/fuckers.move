module 0xe7617af07c241ab4c1569a4c0d31836b334e6a612d49e1580caec6e31b4785a5::fuckers {
    struct FUCKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKERS>(arg0, 6, b"FUCKERS", b"FUCK HOPFUN", b"FYCK HOP AGGREGATOR FUCK HOPFUN FUCK THEM ALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fuck_hop_fun_d9b2b74d34.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

