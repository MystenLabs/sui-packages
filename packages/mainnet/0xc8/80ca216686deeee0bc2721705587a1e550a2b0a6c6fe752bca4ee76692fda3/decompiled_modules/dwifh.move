module 0xc880ca216686deeee0bc2721705587a1e550a2b0a6c6fe752bca4ee76692fda3::dwifh {
    struct DWIFH has drop {
        dummy_field: bool,
    }

    public fun add_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DWIFH>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<DWIFH>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun check_cake<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    fun init(arg0: DWIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DWIFH>(arg0, 9, b"DWIFH", b"Deng Wif Hat", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmT35bTaYRVn2ap8ogTrGhCqcueos399v7b9aqBeT7JcvA"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWIFH>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DWIFH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<DWIFH>(&mut v3, 1000000000000000000, @0x42476aaef3b3acf89a9257094004f16c5ed79bbe324ae15e1208560949278427, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DWIFH>>(v3);
    }

    public fun remove_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DWIFH>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<DWIFH>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

