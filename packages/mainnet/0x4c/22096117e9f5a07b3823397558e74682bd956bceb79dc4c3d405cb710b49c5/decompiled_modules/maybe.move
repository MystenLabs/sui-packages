module 0x4c22096117e9f5a07b3823397558e74682bd956bceb79dc4c3d405cb710b49c5::maybe {
    struct MAYBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYBE>(arg0, 6, b"MAYBE", b"does", b"FUCK YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaayz4uebahhsier2tlopprelpqzzn3byix3hndgzwi2lcuhanaya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAYBE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

