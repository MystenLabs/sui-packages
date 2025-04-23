module 0x2af9c9bbf2b280e21c0c3fb407e9abdfcb7f7cc31895e3558f1f4a3932a6368::sui_sui_sui_sui_sui_sui_sui_sui_sui {
    struct SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI>(arg0, 6, b"SUI SUI SUI SUI SUI SUI SUI SUI SUI", b"SUI", b"BEST CHAIN IN THE WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreify4nowlwya5wi2qgfq2cmrsmpxaf5ec2lvwiv43le2zhmlogw7ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

