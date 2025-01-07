module 0xc5c5b8a63de2dbb15e39087853a71bee4903d3036127faa00c0c00a90116be70::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"AI CAT", x"4e6f207468696e6720626568696e642e204e6f207365637265742e204e6f20646576206f776e656420746f6b656e2e204e6f20686f706520616e64206e6f2066757475726520f09fa4a3f09fa4a3f09fa4a32e2e4a5553542041492043415420464f5220434f4d4d554e495459", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000057641_bc579d95f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

