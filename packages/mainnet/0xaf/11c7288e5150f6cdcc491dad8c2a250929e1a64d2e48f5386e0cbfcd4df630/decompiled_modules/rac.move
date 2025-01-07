module 0xaf11c7288e5150f6cdcc491dad8c2a250929e1a64d2e48f5386e0cbfcd4df630::rac {
    struct RAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAC>(arg0, 6, b"RAC", b"Suiraccoon", b"Just fuckin cute raccoon bouncing on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731149570482.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

