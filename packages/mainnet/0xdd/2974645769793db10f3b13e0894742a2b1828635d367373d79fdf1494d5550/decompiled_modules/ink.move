module 0xdd2974645769793db10f3b13e0894742a2b1828635d367373d79fdf1494d5550::ink {
    struct INK has drop {
        dummy_field: bool,
    }

    fun init(arg0: INK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INK>(arg0, 6, b"INK", b"IKA", b"The fastest parallel MPC network, launching on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidtccgiv3eufr2mie7rba5hdkeeet5wzb7py34cg3m73wnwpzb55y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

