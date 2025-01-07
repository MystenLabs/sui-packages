module 0x8d68a3981c046e3d5613b6b5a2780d970f2afacd13753c525d927caa085a102a::OPPAI {
    struct OPPAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OPPAI>, arg1: 0x2::coin::Coin<OPPAI>) {
        0x2::coin::burn<OPPAI>(arg0, arg1);
    }

    fun init(arg0: OPPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPPAI>(arg0, 2, b"OPPAI", b"OPPAI", b"Who love OPPAI?, Telegram: @Suioppai", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPPAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPPAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPPAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OPPAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

