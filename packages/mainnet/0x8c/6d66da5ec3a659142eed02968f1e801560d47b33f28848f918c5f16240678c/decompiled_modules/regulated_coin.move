module 0x8c6d66da5ec3a659142eed02968f1e801560d47b33f28848f918c5f16240678c::regulated_coin {
    struct REGULATED_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REGULATED_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(0x2::coin::mint<REGULATED_COIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REGULATED_COIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REGULATED_COIN>(arg0, 5, b"$lulu", b"lulu", b"Example Regulated Coin", 0x1::option::none<0x2::url::Url>(), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGULATED_COIN>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGULATED_COIN>>(v2, v3);
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<REGULATED_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

