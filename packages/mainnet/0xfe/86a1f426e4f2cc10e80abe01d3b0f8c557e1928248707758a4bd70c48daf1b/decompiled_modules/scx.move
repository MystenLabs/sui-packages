module 0xfe86a1f426e4f2cc10e80abe01d3b0f8c557e1928248707758a4bd70c48daf1b::scx {
    struct SCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCX>(arg0, 9, b"SCX", b"SCX", b"SCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"SCX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCX>(&mut v2, 77775477000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

