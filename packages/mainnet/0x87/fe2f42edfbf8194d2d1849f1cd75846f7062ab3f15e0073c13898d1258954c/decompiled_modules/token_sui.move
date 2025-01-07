module 0x87fe2f42edfbf8194d2d1849f1cd75846f7062ab3f15e0073c13898d1258954c::token_sui {
    struct TOKEN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_SUI>(arg0, 9, b"suipunks", b"Sui Punks NFT", b"The official unofficial Sui mascot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.bluemove.io/uploads/sui-punks/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_SUI>>(0x2::coin::mint<TOKEN_SUI>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

