module 0x3acb12320666a539d3e12d94a73e796aca1051fc1720be0d61c95bb4eb42e37d::marvin {
    struct MARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVIN>(arg0, 6, b"MARVIN", b"Marvin The Martian", b"Marvin on sui brings cosmic creativity and interstellar charm to your screen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiepqwktcmq6s555dpzetauogzcdkc3l6rhzq4ytb262sp7jy5hfya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARVIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

