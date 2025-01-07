module 0xe620138aee5b3579503ae086ddfbd5592e5ac60f25005caf38ea7f98491b0830::bop {
    struct BOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOP>(arg0, 6, b"BOP", b"BOP BULL", x"2024424f5042554c4c3a20546865204375746573742042756c6c206f6e2074686520426c6f636b210a0a0a2024424f5042554c4c206973206865726520746f20626f7020746f2074686520746f702e20437574652c207374726f6e672c20616e6420756e73746f707061626c65746869732062756c6c206973206c656164696e6720746865206865726420746f20677265656e65722070617374757265732e0a47657420726561647920746f207269646520746865207761766520776974682024424f5042554c4c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOP_BULL_a18aee8516.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

