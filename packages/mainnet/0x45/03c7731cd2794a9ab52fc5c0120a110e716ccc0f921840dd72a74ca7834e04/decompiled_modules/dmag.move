module 0x4503c7731cd2794a9ab52fc5c0120a110e716ccc0f921840dd72a74ca7834e04::dmag {
    struct DMAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAG>(arg0, 6, b"DMAG", b"Darkest Maga", x"54696d6520666f7220757320746f207377617020746f205355492e0a466f6c6c6f7720746865206c696e6b2e2041697264726f7020746f20616c6c20686f6c646572732e203130252066726f6d207072652d73616c6520676f20746f20646578", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000531_60b5d3a5c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

