module 0x4be07bc164cea18a740839d97861976d0044010059ad2a836b558133dc41db89::pudding {
    struct PUDDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDING>(arg0, 9, b"PUDDING", b"PUD", b"https://cloudflare-ipfs.com/ipfs/QmS9krgNkFWqjFQXt1XxPyT2N4vFAQWkNC4NSXdGaWCey5", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUDDING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDING>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUDDING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PUDDING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

