module 0x3d4f98ab7bdc65e1bd96cb7a0a2f88d2029e51aa6855e935138bbdbe5d723ca8::pudding {
    struct PUDDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDING>(arg0, 9, b"PUDDING", b"PUD", b"https://cloudflare-ipfs.com/ipfs/QmS9krgNkFWqjFQXt1XxPyT2N4vFAQWkNC4NSXdGaWCey5", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUDDING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

