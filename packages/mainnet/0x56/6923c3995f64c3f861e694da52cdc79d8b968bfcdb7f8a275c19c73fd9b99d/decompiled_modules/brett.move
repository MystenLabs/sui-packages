module 0x566923c3995f64c3f861e694da52cdc79d8b968bfcdb7f8a275c19c73fd9b99d::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    public fun add_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRETT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<BRETT>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun check_cake<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BRETT>(arg0, 9, b"SUIBRETT", b"Brett on SUI", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pink-naval-kingfisher-12.mypinata.cloud/ipfs/QmNRWbrAB3qXjjLX5h1MVL3hQN5aa2ruiyeDd8nBzo1Vjd"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRETT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BRETT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<BRETT>(&mut v3, 1000000000000000000, @0x16c14be50b9180c2de87a72cb66b730142de18293670707bde48880ca37a5721, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BRETT>>(v3);
    }

    public fun remove_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRETT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<BRETT>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

