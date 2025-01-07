module 0xdcd606c9225896651c38a71677005610282c8a51dd18bb66062357bdb14f7f24::sudeng {
    struct SUDENG has drop {
        dummy_field: bool,
    }

    public fun add_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUDENG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<SUDENG>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun check_cake<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: SUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUDENG>(arg0, 9, b"SUDENG", b"Sudeng on SUI", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/z56jWmB/cd019a13-d217-40ea-98e9-4a1d53ac6b83.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUDENG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUDENG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<SUDENG>(&mut v3, 1000000000000000000, @0xd78dd8cb3f46c9d0f8b6769d7d0136b9ff17a1fb12e57dd3b73b1eeacad1d9f4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUDENG>>(v3);
    }

    public fun remove_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUDENG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<SUDENG>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

