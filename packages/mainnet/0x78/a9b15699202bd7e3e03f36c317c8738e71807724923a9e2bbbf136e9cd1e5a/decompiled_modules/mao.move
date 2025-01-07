module 0x78a9b15699202bd7e3e03f36c317c8738e71807724923a9e2bbbf136e9cd1e5a::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAO>(arg0, 6, b"MAO", b"MAO THE CAT", b"FIRST REAL MAO THE CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_3_5_76438043f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

