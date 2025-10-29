module 0xfda41e9fc6aba0a4b86938b2758554e4bb05a48eb53aa7195bc5aae6cbb9a82::crypton {
    struct CRYPTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTON>(arg0, 9, b"CRYPTON", b"Crypton", b"350,000,000 supply token on Sui Mainnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CRYPTON>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CRYPTON>(arg0, 350000000000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

