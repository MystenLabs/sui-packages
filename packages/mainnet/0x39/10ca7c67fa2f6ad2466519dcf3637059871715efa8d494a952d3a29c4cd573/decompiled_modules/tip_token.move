module 0x3910ca7c67fa2f6ad2466519dcf3637059871715efa8d494a952d3a29c4cd573::tip_token {
    struct TIP_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TIP_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TIP_TOKEN>>(0x2::coin::mint<TIP_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TIP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIP_TOKEN>(arg0, 6, b"TIP", b"Testnet Improvement Point", b"A test coin for my app.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIP_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIP_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

