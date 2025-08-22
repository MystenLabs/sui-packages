module 0xddf0e095c5efcec819c6d9ce05ad20932f2897ffe68c944502cf1f7b65d97285::sasmmm {
    struct SASMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASMMM>(arg0, 9, b"sasmmm", b"zombie", b"saddddweessss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SASMMM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASMMM>>(v2, @0x191726a4470b439a8353879cbcb7a67617e78ef938eb3b8cd5a0cf1cf285ce8f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASMMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

