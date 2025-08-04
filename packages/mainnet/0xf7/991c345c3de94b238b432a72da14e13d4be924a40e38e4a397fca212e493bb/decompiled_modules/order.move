module 0xf7991c345c3de94b238b432a72da14e13d4be924a40e38e4a397fca212e493bb::order {
    struct ORDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORDER>(arg0, 6, b"Order", b"The Order", b"The Order on Sui is inspired by anime Sakamoto days. It will bring peace and balance on Sui thru its NFT burning and staking.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6fjp2yoo7m37h26ec6zcinw6yb6ln6k52p5wghbabeszbj4x5uy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORDER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

