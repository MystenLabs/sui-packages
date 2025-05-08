module 0x7497d8d26be7a448b096cb896baf411068785d478a4d27d789df1b0540cdeb96::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 6, b"BLU", b"BLU SUI", b"In the depths of the SUI chain, a mysterious little being was born from pure blue energy. His name is BLU  a young chaotic guardian that carries a flame of unrealized force.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia2vweuucf26salsdemtai2erbm7ldve4g5aq24yb2c7tiqgq4xci")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

