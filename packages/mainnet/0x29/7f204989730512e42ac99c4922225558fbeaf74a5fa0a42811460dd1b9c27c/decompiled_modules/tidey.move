module 0x297f204989730512e42ac99c4922225558fbeaf74a5fa0a42811460dd1b9c27c::tidey {
    struct TIDEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIDEY>(arg0, 6, b"Tidey", b"Tidey Sui", b"Tidey was just a ripple in the Sui sea until one big wave changed everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7wwxejvr4yslb7fx7eyfprvpokjsbjhioutmxbkdqd3nwguzrrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIDEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TIDEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

