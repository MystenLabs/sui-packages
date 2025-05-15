module 0xa13723b043ad0077d3031518e104652a32140545ce991259978527ddde5fc573::asdas {
    struct ASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDAS>(arg0, 6, b"ASDAS", b"EQEQE", b"AAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwbamzxijog7z7lqkxpobtx226sx7ch7kcuz3olhmpdqym374w54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

