module 0x4d10f02e4186d0837b58d464dc2e7b68edce3b4dbb63c26c8aadd064bb814e48::aicmp {
    struct AICMP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AICMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AICMP>>(0x2::coin::mint<AICMP>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AICMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AICMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AICMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AICMP>(arg0, 6, b"AICMP", b"AICMP", b"Incubating an AI project to bring more innovation to PoW mining industry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-BAEXK4X6B3hkqmEkPuyyZQ5fZUb5iZ6SaJ7a9UDnpump-98.png/type=default_350_0?v=1735610624671"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AICMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AICMP>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<AICMP>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICMP>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AICMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AICMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

