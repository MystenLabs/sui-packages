module 0x474d8b3c7fa3a5bb1ed5445e18502b6481f4e8b2be5cd23d5919030c5ac6239a::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDS>(arg0, 6, b"DDS", b"dqdqsdqs", b"dsfffdsq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihybyjfjlh74w7gxjyejdss5la5tgko74tn457msxyqekizoa5unq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DDS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

