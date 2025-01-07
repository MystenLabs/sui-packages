module 0x8232d9a0ed76c80f799e550e05c7f4ab8512b712e181f257b64f20c0a2a53759::wyzzheFaucet {
    struct WYZZHEFAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WYZZHEFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WYZZHEFAUCET>>(0x2::coin::mint<WYZZHEFAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WYZZHEFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYZZHEFAUCET>(arg0, 6, b"WYZZHEFAUCET", b"WYZ", b"Power by wyz", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYZZHEFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WYZZHEFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

