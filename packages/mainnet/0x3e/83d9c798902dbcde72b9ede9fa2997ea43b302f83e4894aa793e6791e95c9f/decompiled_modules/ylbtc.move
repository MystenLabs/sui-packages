module 0x3e83d9c798902dbcde72b9ede9fa2997ea43b302f83e4894aa793e6791e95c9f::ylbtc {
    struct YLBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YLBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YLBTC>(arg0, 8, b"yLBTC", b"Kai Vault LBTC", b"Kai Vault yield-bearing Lombard LBTC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YLBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

