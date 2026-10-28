module 0xf10f09d577626a67d0e31b0126604b74df631bbbe121b0f9d3c89ff10d2fd89b::droplets {
    struct DROPLETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPLETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPLETS>(arg0, 9, b"DROPLETS", b"Droplets", b"2222 droplets. Every NFT is a node. Claim, compound, merge, repeat. Become the ocean. On Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidroplets.com/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DROPLETS>>(0x2::coin::mint<DROPLETS>(&mut v2, 2222000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPLETS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPLETS>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

