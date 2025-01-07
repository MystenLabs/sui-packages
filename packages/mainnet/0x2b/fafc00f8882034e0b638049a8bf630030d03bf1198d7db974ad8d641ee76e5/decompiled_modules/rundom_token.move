module 0x2bfafc00f8882034e0b638049a8bf630030d03bf1198d7db974ad8d641ee76e5::rundom_token {
    struct RUNDOM_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RUNDOM_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RUNDOM_TOKEN>>(0x2::coin::mint<RUNDOM_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RUNDOM_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNDOM_TOKEN>(arg0, 6, b"Rundom Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNDOM_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNDOM_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

