module 0x3ded76e767466e22a119aa142240a054a822728b63bae3abf797222ede7e6e4d::bobthefroggy {
    struct BOBTHEFROGGY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOBTHEFROGGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BOBTHEFROGGY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BOBTHEFROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BOBTHEFROGGY>(arg0, 9, b"BOB", b"Bob The Froggy", x"426f62207468652046726f67677920697320796f7572206c6169642d6261636b2c20736d6f6f74682d686f7070696e67206775696465207468726f756768207468652063727970746f207377616d702120f09f90b8f09f92b820576974682068697320636f6f6c2064656d65616e6f7220616e64206c6f766520666f7220616c6c207468696e677320677265656e2028657370656369616c6c792063727970746f292c20426f62206b6e6f777320686f7720746f206c65617020706173742074686520636f6d7065746974696f6e20616e64206c616e64206f6e207468652062657374206f70706f7274756e69746965732e204f6e207468652063757474696e672d65646765206f6620626c6f636b636861696e2c20426f62207468652046726f676779206272696e6773206566666f72746c657373207472616e73616374696f6e732c206c6f7720666565732c20616e64206120636f6d6d756e6974792d666972737420617070726f6163682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BOBTHEFROGGY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBTHEFROGGY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBTHEFROGGY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BOBTHEFROGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOBTHEFROGGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BOBTHEFROGGY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

