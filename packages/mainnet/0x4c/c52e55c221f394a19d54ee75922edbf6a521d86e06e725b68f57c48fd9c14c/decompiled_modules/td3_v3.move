module 0x4cc52e55c221f394a19d54ee75922edbf6a521d86e06e725b68f57c48fd9c14c::td3_v3 {
    struct TD3_V3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TD3_V3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TD3_V3>(arg0, 6, b"TD3 V3", b"TD3 V2", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TD3_V3>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TD3_V3>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TD3_V3>>(v2);
    }

    // decompiled from Move bytecode v6
}

