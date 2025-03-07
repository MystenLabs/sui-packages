module 0x58ad492824a607569c74089883949b71065a9109bf0e91adfcce2bdffe872c6b::fifacoin {
    struct FIFACOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFACOIN>(arg0, 6, b"Fifacoin", b"FIFA COIN", x"4e6f20736f6369616c732e203130304d2070726f6772616d6d65642e0a4e616d6564206174207468652066697273742043727970746f20636f6e666572656e636520696e2074686520576869746520486f757365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059067_3ecf2f148e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFACOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIFACOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

