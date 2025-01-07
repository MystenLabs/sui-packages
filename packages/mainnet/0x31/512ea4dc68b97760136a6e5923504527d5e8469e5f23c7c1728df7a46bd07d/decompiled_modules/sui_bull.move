module 0x31512ea4dc68b97760136a6e5923504527d5e8469e5f23c7c1728df7a46bd07d::sui_bull {
    struct SUI_BULL has drop {
        dummy_field: bool,
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUI_BULL>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<SUI_BULL>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun check_permission(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<SUI_BULL>(arg0, arg1)
    }

    fun init(arg0: SUI_BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUI_BULL>(arg0, 9, b"BULL", b"Sui Bull", b"The bullrun on Sui has truly begun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_2912_ef4efa4417.jpeg&w=640&q=75"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_BULL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUI_BULL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<SUI_BULL>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_BULL>>(v3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUI_BULL>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<SUI_BULL>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

