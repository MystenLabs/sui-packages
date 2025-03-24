module 0x9eed64d3176c07b019dcdf66b5894a3bc5755fbe0201417feb851e697247f399::faucet_qwe {
    struct FAUCET_QWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_QWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_QWE>(arg0, 9, b"FAUCET_QWE", b"FAUCET_QWE", b"FAUCET_QWE", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_QWE>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_QWE>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_QWE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_QWE>>(0x2::coin::mint<FAUCET_QWE>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

