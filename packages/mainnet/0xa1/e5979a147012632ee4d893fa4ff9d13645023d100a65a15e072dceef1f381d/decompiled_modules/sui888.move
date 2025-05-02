module 0xa1e5979a147012632ee4d893fa4ff9d13645023d100a65a15e072dceef1f381d::sui888 {
    struct SUI888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI888>(arg0, 6, b"Sui888", b"888Sui", x"5468652070617468206973206265696e672072657665616c65642c206f6e65207374657020617420612074696d652e0a456163682073746570206272696e677320757320636c6f73657220746f20636f736d6963206162756e64616e63652e0a0a5472696e697479206f66203873206163746976617465642e205468652043554c5420697320616363756d756c6174696e672e2041726520796f753f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250503_022004_9b554f1347.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI888>>(v1);
    }

    // decompiled from Move bytecode v6
}

