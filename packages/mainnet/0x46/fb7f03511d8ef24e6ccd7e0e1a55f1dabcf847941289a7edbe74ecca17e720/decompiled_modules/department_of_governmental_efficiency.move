module 0x46fb7f03511d8ef24e6ccd7e0e1a55f1dabcf847941289a7edbe74ecca17e720::department_of_governmental_efficiency {
    struct DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY has drop {
        dummy_field: bool,
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun check_permission(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>(arg0, arg1)
    }

    fun init(arg0: DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>(arg0, 9, b"DOGE", b"Department of Governmental Efficiency", b"Elon's Department of Governmental Efficiency $DOGE on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1852708359247364096/MwyvPlHT_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>>(v3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<DEPARTMENT_OF_GOVERNMENTAL_EFFICIENCY>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

