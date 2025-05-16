module 0x597f98c5a350f262aa31241c04a7335867c5612d7268928e4298db57f1ae38c9::memechu {
    struct MEMECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECHU>(arg0, 6, b"MEMECHU", b"MEMECHU SUI", b"Born from a radioactive shitpost and a thunderstorm of irony.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibxcchqqajmpf5xyrysy6kajts75matss2gxo4t7vqfrgivr46ttq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMECHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

