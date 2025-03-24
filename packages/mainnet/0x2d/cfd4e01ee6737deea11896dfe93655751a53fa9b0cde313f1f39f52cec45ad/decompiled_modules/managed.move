module 0x2dcfd4e01ee6737deea11896dfe93655751a53fa9b0cde313f1f39f52cec45ad::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    public entry fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MANAGED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MANAGED>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MANAGED>(arg0, 6, b"MANAGED", b"", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MANAGED>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MANAGED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MANAGED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

