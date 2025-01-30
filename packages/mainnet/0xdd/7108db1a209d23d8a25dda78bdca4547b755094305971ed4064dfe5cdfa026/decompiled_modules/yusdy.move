module 0xdd7108db1a209d23d8a25dda78bdca4547b755094305971ed4064dfe5cdfa026::yusdy {
    struct YUSDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUSDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSDY>(arg0, 6, b"yUSDY", b"Kai Vault USDY", b"Kai Vault yield-bearing USDY", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUSDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUSDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

