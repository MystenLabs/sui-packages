module 0x7d67b7cd6d952459df79a885fdeb02abbc4b7a340822116010493b5a77869414::aaafrog {
    struct AAAFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFROG>(arg0, 6, b"AAAFROG", b"aaa frog", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_v2_c23b2d304b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

