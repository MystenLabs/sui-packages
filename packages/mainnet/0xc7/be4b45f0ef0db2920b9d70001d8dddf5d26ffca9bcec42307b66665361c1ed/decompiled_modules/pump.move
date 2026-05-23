module 0xc7be4b45f0ef0db2920b9d70001d8dddf5d26ffca9bcec42307b66665361c1ed::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PUMP>(arg0, 9, b"BILL", b"Billions Network", x"42696c6c696f6e73204e6574776f726b2069732074686520756e6976657273616c2048756d616e20616e64204149204e6574776f726b207768696368206c65747320616e796f6e652070726f76652074686579206172652061207265616c0af09f8c902068747470733a2f2f62696c6c696f6e732e6e6574776f726b2f0af09d958f2068747470733a2f2f782e636f6d2f62696c6c696f6e735f6e74776b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/39545.png")), true, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMP>>(v2, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUMP>>(v1, @0x0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v3, @0x0);
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(arg0, arg1, arg3), arg2);
    }

    public entry fun pause_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun pause_all(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<PUMP>(arg0, arg1, arg2);
    }

    public entry fun resume_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun resume_all(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<PUMP>(arg0, arg1, arg2);
    }

    public entry fun revoke_all(arg0: 0x2::coin::TreasuryCap<PUMP>, arg1: 0x2::coin::CoinMetadata<PUMP>, arg2: 0x2::coin::DenyCapV2<PUMP>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(arg0, @0x0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMP>>(arg1, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUMP>>(arg2, @0x0);
    }

    // decompiled from Move bytecode v7
}

