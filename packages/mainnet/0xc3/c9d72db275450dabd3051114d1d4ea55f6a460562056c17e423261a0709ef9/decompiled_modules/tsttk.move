module 0xc3c9d72db275450dabd3051114d1d4ea55f6a460562056c17e423261a0709ef9::tsttk {
    struct TSTTK has drop {
        dummy_field: bool,
    }

    struct SupplyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
    }

    public fun burn_tokens(arg0: &mut 0x2::coin::TreasuryCap<TSTTK>, arg1: 0x2::coin::Coin<TSTTK>) {
        0x2::coin::burn<TSTTK>(arg0, arg1);
    }

    public fun disable_global_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TSTTK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<TSTTK>(arg0, arg1, arg2);
    }

    public fun disable_minting(arg0: 0x2::coin::TreasuryCap<TSTTK>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TSTTK>>(arg0);
    }

    public fun enable_global_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TSTTK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<TSTTK>(arg0, arg1, arg2);
    }

    public fun freeze_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TSTTK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TSTTK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TSTTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TSTTK>(arg0, 6, 0x1::string::utf8(b"TSTTK"), 0x1::string::utf8(b"testtoken"), 0x1::string::utf8(b"this is just a test token"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<TSTTK>>(0x2::coin_registry::finalize<TSTTK>(v3, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TSTTK>>(0x2::coin::mint<TSTTK>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TSTTK>>(0x2::coin_registry::make_regulated<TSTTK>(&mut v3, true, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTTK>>(v2, 0x2::tx_context::sender(arg1));
        let v4 = SupplyCap<TSTTK>{
            id         : 0x2::object::new(arg1),
            max_supply : 10000000000000000,
        };
        0x2::transfer::public_transfer<SupplyCap<TSTTK>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint_tokens(arg0: &mut 0x2::coin::TreasuryCap<TSTTK>, arg1: &SupplyCap<TSTTK>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<TSTTK>(arg0) + arg2 <= arg1.max_supply, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TSTTK>>(0x2::coin::mint<TSTTK>(arg0, arg2, arg4), arg3);
    }

    public fun unfreeze_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TSTTK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TSTTK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

