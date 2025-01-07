module 0xe17502fb87ea11be494f5074cc9caccb161b7c2e0d80d1b4fb28f5dfa0d7f7b::blubalz {
    struct BLUBALZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBALZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBALZ>(arg0, 6, b"BluBalz", b"Blubalz", x"497420697320736f20756e666169722e2e2e204e6f626f64792077616e7420746f20746f75636820426c75426f6c7a2e2e20536f206d7563682073696d70696e6720666f72206e6f7468696e672e2e2049742068757274732e2e2e2e205468697320697320746865206e6577204d4554410a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_D_Nma_Dg5_400x400_489bdec4f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBALZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBALZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

