module 0x6d304396a0e64dc290715af5ee3750b61189f9a5ca3ca779b0d2e4b3cba2c835::ELON {
    struct ELON has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ELON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ELON>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ELON>(arg0, 9, b"MADAGASCAR", b"Madagascar the lion king", b"Madagascar the lion king on SUI", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ELON>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ELON>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ELON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ELON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

