module 0xdbed84fd4218cf3d5164d9566ed0792960aedd5aae4e457e188ba5bfdd2ed7bd::shinx {
    struct SHINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINX>(arg0, 6, b"SHINX", b"SHINX SHINX SHINX", b"Shinx was the first Pokemon Hareta caught from the wild", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiac3rurf2ar4sgfkkfqvht5by42ob6idzj5ywx5fuljzpzrioeaje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHINX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

