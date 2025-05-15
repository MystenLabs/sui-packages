module 0xa3fc70552c32c482cf4d3df2a1cfa100b18916dcad5288316e35920f78a34506::snivy {
    struct SNIVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIVY>(arg0, 6, b"SNIVY", b"Suinivy", x"697320612047726173732d7479706520506f6bc3a96d6f6e20696e20506f6bc3a96d6f6e20474f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidypvi6tghsqguzirk4k7nfazijq3nj4mztbvrs5d5fp63tflj4ea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIVY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

