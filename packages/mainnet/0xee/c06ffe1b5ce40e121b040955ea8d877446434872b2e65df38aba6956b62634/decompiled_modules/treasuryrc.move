module 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc {
    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DenyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ManagedTreasury<phantom T0> has key {
        id: 0x2::object::UID,
    }

    public fun total_supply<T0>(arg0: &ManagedTreasury<T0>) : u64 {
        0x2::coin::total_supply<T0>(treasury_cap<T0>(arg0))
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCapV2<T0>, arg2: &mut 0x2::tx_context::TxContext) : ManagedTreasury<T0> {
        let v0 = 0x2::object::new(arg2);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0, v1, arg0);
        let v2 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<DenyCapKey, 0x2::coin::DenyCapV2<T0>>(&mut v0, v2, arg1);
        ManagedTreasury<T0>{id: v0}
    }

    public(friend) fun denylist_cap_mut<T0>(arg0: &mut ManagedTreasury<T0>) : &mut 0x2::coin::DenyCapV2<T0> {
        let v0 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<DenyCapKey, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun internal_prepare<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg5)), arg6, arg7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        0x2::transfer::share_object<ManagedTreasury<T0>>(new<T0>(v0, v1, arg7));
    }

    public fun pause<T0>(arg0: &mut ManagedTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg3: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg2, 0x2::tx_context::sender(arg3));
        0x2::coin::deny_list_v2_enable_global_pause<T0>(arg1, denylist_cap_mut<T0>(arg0), arg3);
    }

    public(friend) fun treasury_cap<T0>(arg0: &ManagedTreasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    public(friend) fun treasury_cap_mut<T0>(arg0: &mut ManagedTreasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    public fun unpause<T0>(arg0: &mut ManagedTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::Auth, arg3: &mut 0x2::tx_context::TxContext) {
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::assert_cap<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::auth::ControllerCap>(arg2, 0x2::tx_context::sender(arg3));
        0x2::coin::deny_list_v2_disable_global_pause<T0>(arg1, denylist_cap_mut<T0>(arg0), arg3);
    }

    // decompiled from Move bytecode v6
}

