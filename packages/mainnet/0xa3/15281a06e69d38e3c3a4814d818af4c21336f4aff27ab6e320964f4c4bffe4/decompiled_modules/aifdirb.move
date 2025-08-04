module 0xa315281a06e69d38e3c3a4814d818af4c21336f4aff27ab6e320964f4c4bffe4::aifdirb {
    struct AIFDIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIFDIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIFDIRB>(arg0, 6, b"AIFDIRB", b"BRIDFIA", b"BRIDFIA is at the forefront of revolutionizing decentralized finance through advanced artificial intelligence and blockchain technology. Built on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihcu7jivayux5wmt46z2pujdg5ysszqewlms4qlkgm5cbyhv7sa6e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFDIRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIFDIRB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

