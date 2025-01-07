module 0xb05d3d03076a8733379d6454efd3f02d425bf0ed792ac1bbdbc2f211dd2d371d::aaa_i_jeeted_again {
    struct AAA_I_JEETED_AGAIN has drop {
        dummy_field: bool,
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAA_I_JEETED_AGAIN>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<AAA_I_JEETED_AGAIN>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun check_permission(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<AAA_I_JEETED_AGAIN>(arg0, arg1)
    }

    fun init(arg0: AAA_I_JEETED_AGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AAA_I_JEETED_AGAIN>(arg0, 9, b"JEET", b"aaa I JEETED Again!", b"stop jeeting for pennies. sit back, buy $JEET, hold and collect your first 100x. already verified on X / Twitter. Lets push it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1843326536620908551/qfQ_hzrf_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA_I_JEETED_AGAIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AAA_I_JEETED_AGAIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<AAA_I_JEETED_AGAIN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AAA_I_JEETED_AGAIN>>(v3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAA_I_JEETED_AGAIN>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<AAA_I_JEETED_AGAIN>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

