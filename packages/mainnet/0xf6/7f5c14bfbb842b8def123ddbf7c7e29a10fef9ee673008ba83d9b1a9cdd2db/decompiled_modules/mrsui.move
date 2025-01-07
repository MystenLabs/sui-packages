module 0xf67f5c14bfbb842b8def123ddbf7c7e29a10fef9ee673008ba83d9b1a9cdd2db::mrsui {
    struct MRSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MRSUI>, arg1: 0x2::coin::Coin<MRSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MRSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MRSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: MRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MRSUI>(arg0, 6, b"MSUI", b"MR SUI", b"Mr Sui, The King of the SEA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/ikvuKVU")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MRSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<MRSUI>, arg1: 0x2::coin::Coin<MRSUI>) : u64 {
        0x2::coin::burn<MRSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<MRSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MRSUI> {
        0x2::coin::mint<MRSUI>(arg0, arg1, arg2)
    }

    public entry fun rebase(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MRSUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MRSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun un_rebase(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MRSUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MRSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

