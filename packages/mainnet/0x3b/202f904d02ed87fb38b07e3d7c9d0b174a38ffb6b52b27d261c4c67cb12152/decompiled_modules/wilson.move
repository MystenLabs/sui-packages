module 0x3b202f904d02ed87fb38b07e3d7c9d0b174a38ffb6b52b27d261c4c67cb12152::wilson {
    struct WILSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILSON>(arg0, 6, b"WILSON", b"Wilson The Whale", b"A REAL SUI WHALE, THE ALPHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/willy2_64817d3f37.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

