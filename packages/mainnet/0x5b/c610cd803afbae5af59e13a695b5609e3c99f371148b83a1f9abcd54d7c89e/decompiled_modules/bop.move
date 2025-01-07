module 0x5bc610cd803afbae5af59e13a695b5609e3c99f371148b83a1f9abcd54d7c89e::bop {
    struct BOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOP>(arg0, 6, b"BOP", b"BEBOP SUI", b"See you on SUI, Space Cowboy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004270_ce76dfc5f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

