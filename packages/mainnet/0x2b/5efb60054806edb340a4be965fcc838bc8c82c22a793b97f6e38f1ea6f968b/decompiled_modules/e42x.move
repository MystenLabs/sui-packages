module 0x2b5efb60054806edb340a4be965fcc838bc8c82c22a793b97f6e38f1ea6f968b::e42x {
    struct E42X has drop {
        dummy_field: bool,
    }

    fun init(arg0: E42X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E42X>(arg0, 9, b"E42X", b"42XE", b"meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<E42X>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E42X>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<E42X>>(v1);
    }

    // decompiled from Move bytecode v6
}

