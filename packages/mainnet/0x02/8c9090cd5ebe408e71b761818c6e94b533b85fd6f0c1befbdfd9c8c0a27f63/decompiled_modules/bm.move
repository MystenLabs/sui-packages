module 0x28c9090cd5ebe408e71b761818c6e94b533b85fd6f0c1befbdfd9c8c0a27f63::bm {
    struct BM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BM>(arg0, 6, b"BM", b"BitMachine", b"Play big,Win big ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/86_FAD_522_C36_B_4_F5_A_8383_79_BD_0_F4093_A0_8d4106d482.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BM>>(v1);
    }

    // decompiled from Move bytecode v6
}

