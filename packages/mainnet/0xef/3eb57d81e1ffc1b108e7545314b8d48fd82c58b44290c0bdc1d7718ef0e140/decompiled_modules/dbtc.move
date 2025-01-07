module 0xef3eb57d81e1ffc1b108e7545314b8d48fd82c58b44290c0bdc1d7718ef0e140::dbtc {
    struct DBTC has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DBTC>(arg0, 9, b"DBTC", b"Don't buy this coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmT6dxH5Eam8vss9ygyHQ5tUSrFFakNVgMsBcFUq1TUcUc"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DBTC>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBTC>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DBTC>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DBTC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DBTC>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DBTC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DBTC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

