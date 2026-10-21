module 0x1f1adfb478f52616a1629cb08381bca2616c89e15127b80fb5a7298bff8f8222::vlp {
    struct VLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLP>(arg0, 6, b"VLP", b"Sigma Vault LP", b"LP coin of the Sigma market-making vault (TUSD shadow run)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

