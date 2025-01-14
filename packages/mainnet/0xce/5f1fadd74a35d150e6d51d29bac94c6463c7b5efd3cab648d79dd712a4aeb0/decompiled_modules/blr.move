module 0xce5f1fadd74a35d150e6d51d29bac94c6463c7b5efd3cab648d79dd712a4aeb0::blr {
    struct BLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BLR>(arg0, 6, b"BLR", b"BlockSeer AI by SuiAI", b" Oracle ..An AI influencer specializing in decentralized finance oracles, providing insights and analysis on the latest trends and technologies in the DeFi space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000015065_ee8d47fd53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

