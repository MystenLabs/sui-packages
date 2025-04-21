module 0x4a4d5c6b0f4e7df8a26a6fb313cb2abf9cffa8b8d3145f5aaf5465078ecfe3b9::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDS>(arg0, 6, b"DDS", b"Distorted Dreams On Sui", x"546865206e616d652022446973746f72746564447265616d732220686173206372656174656420612064697374696e63740a6d61726b2c2073756767657374696e672061207669727475616c20776f726c642066756c6c206f6620616d6269677569747920616e640a73757270726973652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidormpxpv7y5yhacm7r34biki26xnw47gomznhgr6h7a3ri7onkvq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DDS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

