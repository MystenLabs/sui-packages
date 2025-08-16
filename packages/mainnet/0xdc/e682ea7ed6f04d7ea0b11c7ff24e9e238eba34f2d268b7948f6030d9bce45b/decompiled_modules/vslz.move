module 0xdce682ea7ed6f04d7ea0b11c7ff24e9e238eba34f2d268b7948f6030d9bce45b::vslz {
    struct VSLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSLZ>(arg0, 6, b"VSLZ", b"Visualize", b"visualize it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2pfvf3pdyjaqhwhifqj74277msoxc6hnrjz4mvf64jc4icze6eu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VSLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

