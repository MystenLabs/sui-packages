module 0x2f06b78e6aed719f0d918a74ae40d9937e0c3558e9de8a488be6027d8f8c9932::hades {
    struct HADES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HADES>(arg0, 6, b"Hades", b"KolmogorovHades", b"Explore the universe of KOLMOGOROV HADES, where innovation meets opportunity. Join our journey through our Telegram community, follow updates on Twitter, visit our launchpad on moonbags.io, or track our progress via the Chart. Ask our AI powered assistant anything about the project, and dive into the future of blockchain with HADES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibfk352igklivjjqqbwgkxc4bllx3xgexxsjl3qotcupzz4isgabe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HADES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HADES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

