module 0xa06ead0937110ba7092154b012323d8c707269fa5e0343e8fcc767ce06e8573b::baby_deng {
    struct BABY_DENG has drop {
        dummy_field: bool,
    }

    public fun add_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABY_DENG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<BABY_DENG>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun check_cake<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: BABY_DENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABY_DENG>(arg0, 9, b"BABYDENG", b"Baby Deng", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmZBguHdZGtPQc7MeGveTeVTTzkTtUt6RvJon2aBWYUCEX"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY_DENG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABY_DENG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<BABY_DENG>(&mut v3, 1000000000000000000, @0xee445327cca959e90978cc100b670a270f02f5c2454e0c65ff3aea3b70947b5d, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABY_DENG>>(v3);
    }

    public fun remove_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABY_DENG>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<BABY_DENG>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

