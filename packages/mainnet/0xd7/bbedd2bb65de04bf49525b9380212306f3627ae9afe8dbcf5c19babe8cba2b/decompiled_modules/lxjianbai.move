module 0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai {
    struct LXJIANBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LXJIANBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LXJIANBAI>(arg0, 9, b"LXJIANBAI", b"LXJIANBAI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LXJIANBAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LXJIANBAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LXJIANBAI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LXJIANBAI>>(0x2::coin::mint<LXJIANBAI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

