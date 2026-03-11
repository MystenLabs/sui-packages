module 0xe304cf5c247057a3d748cebd56d4eb1a18c0c2dcba2bbb2a120c64fa1528a86b::aqusdc {
    struct AQUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUSDC>(arg0, 6, b"aqUSDC", b"AquaYield USDC", b"Yield-bearing USDC vault token from AquaYield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/e-5jZ0JJ1ZBjdPBXC2aGq0bmFErJzmNNAOkYJc_meW0")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

