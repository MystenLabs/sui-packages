module 0x136e45f00b89959a0a332e26ee30469f610888666c2c2b142102ec7a197695::camela_harris {
    struct CAMELA_HARRIS has drop {
        dummy_field: bool,
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CAMELA_HARRIS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<CAMELA_HARRIS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun check_permission(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<CAMELA_HARRIS>(arg0, arg1)
    }

    fun init(arg0: CAMELA_HARRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CAMELA_HARRIS>(arg0, 9, b"CAMELA", b"Camela Harris", b"The first Kamala Harris token on Sui. Win or lose, $CAMELA will moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1839614549403561984/hvSJJ2U-_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAMELA_HARRIS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CAMELA_HARRIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<CAMELA_HARRIS>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAMELA_HARRIS>>(v3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CAMELA_HARRIS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<CAMELA_HARRIS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

