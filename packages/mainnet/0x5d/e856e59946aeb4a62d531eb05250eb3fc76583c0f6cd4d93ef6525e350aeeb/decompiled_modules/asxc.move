module 0x5de856e59946aeb4a62d531eb05250eb3fc76583c0f6cd4d93ef6525e350aeeb::asxc {
    struct ASXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASXC>(arg0, 6, b"ASXC", b"sdasd", b"asdxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrx5vav3gkpuiovmp3ohnbgaau32yve7z3xl6yv5iqpe7i2vicbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASXC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

