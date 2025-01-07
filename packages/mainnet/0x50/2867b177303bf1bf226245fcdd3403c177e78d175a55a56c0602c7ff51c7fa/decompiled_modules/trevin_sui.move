module 0x502867b177303bf1bf226245fcdd3403c177e78d175a55a56c0602c7ff51c7fa::trevin_sui {
    struct TREVIN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREVIN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREVIN_SUI>(arg0, 9, b"trevinSUI", b"Trevin Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/springsui/trevinSui.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREVIN_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREVIN_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

