module 0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet {
    struct XDD_OBJECT_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDD_OBJECT_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDD_OBJECT_FAUCET>(arg0, 9, b"XDD_OBJECT_FAUCET", b"XDD_OBJECT_FAUCET", b"XDD_OBJECT_FAUCET", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XDD_OBJECT_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XDD_OBJECT_FAUCET>>(v0);
    }

    public entry fun mint_xdd_object_faucet(arg0: &mut 0x2::coin::TreasuryCap<XDD_OBJECT_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XDD_OBJECT_FAUCET>>(0x2::coin::mint<XDD_OBJECT_FAUCET>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

