module 0x20fa549faf8a16b3b38a997777337125726e3cdde7b231aba8c21fa937af348a::eth_sui {
    struct ETH_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH_SUI>(arg0, 9, b"ethSUI", b"Ethereum Staked SUI", b"Ethereum Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/867a9b72-1fab-475e-971b-fa94dda780b4/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

