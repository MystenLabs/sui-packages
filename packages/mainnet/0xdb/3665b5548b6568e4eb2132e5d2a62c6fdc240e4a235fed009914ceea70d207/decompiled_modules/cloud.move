module 0xdb3665b5548b6568e4eb2132e5d2a62c6fdc240e4a235fed009914ceea70d207::cloud {
    struct CLOUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUD>(arg0, 6, b"CLOUD", b"Rain Cloud of Sui", x"24434c4f554420706f757273206c6971756964697479206f7665722074686520537569204e6574776f726b206c696b6520612072656672657368696e6720646f776e706f75722e204272696e67696e6720746865207261696e2c206974206675656c732067726f77746820616e6420696e6e6f766174696f6e20776865726576657220697420676f65732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_70_e7138950ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

