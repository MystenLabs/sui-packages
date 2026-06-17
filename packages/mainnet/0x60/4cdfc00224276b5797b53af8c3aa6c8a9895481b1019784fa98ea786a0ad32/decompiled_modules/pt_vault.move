module 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_vault {
    struct PTVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        market_core_id: 0x2::object::ID,
        adapter_auth_type: 0x1::type_name::TypeName,
        maturity_ms: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        inventory: 0x2::object_table::ObjectTable<0x2::object::ID, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject>,
        inventory_ids: vector<0x2::object::ID>,
        head_cursor: u64,
        total_notional: u64,
        paused: bool,
    }

    public fun id<T0, T1>(arg0: &PTVault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<PTVault<T0, T1>>(arg0)
    }

    public fun new<T0, T1>(arg0: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &mut 0x2::tx_context::TxContext) : PTVault<T0, T1> {
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_pt_vault_nonzero_supply());
        PTVault<T0, T1>{
            id                : 0x2::object::new(arg2),
            market_core_id    : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg0),
            adapter_auth_type : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::adapter_auth_type<T0>(arg0),
            maturity_ms       : 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::maturity_ms<T0>(arg0),
            treasury_cap      : arg1,
            inventory         : 0x2::object_table::new<0x2::object::ID, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject>(arg2),
            inventory_ids     : 0x1::vector::empty<0x2::object::ID>(),
            head_cursor       : 0,
            total_notional    : 0,
            paused            : false,
        }
    }

    public fun maturity_ms<T0, T1>(arg0: &PTVault<T0, T1>) : u64 {
        arg0.maturity_ms
    }

    public fun adapter_auth_type_ref<T0, T1>(arg0: &PTVault<T0, T1>) : &0x1::type_name::TypeName {
        &arg0.adapter_auth_type
    }

    public fun market_core_id<T0, T1>(arg0: &PTVault<T0, T1>) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun coin_supply<T0, T1>(arg0: &PTVault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.treasury_cap)
    }

    public fun compact_inventory<T0, T1>(arg0: &mut PTVault<T0, T1>) {
        let v0 = compact_inventory_prefix<T0, T1>(arg0);
        if (v0 > 0) {
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::events::emit_pt_vault_compacted(0x2::object::id<PTVault<T0, T1>>(arg0), v0);
        };
    }

    fun compact_inventory_prefix<T0, T1>(arg0: &mut PTVault<T0, T1>) : u64 {
        let v0 = arg0.head_cursor;
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.inventory_ids)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x1::vector::borrow<0x2::object::ID>(&arg0.inventory_ids, v0));
            v0 = v0 + 1;
        };
        arg0.inventory_ids = v1;
        arg0.head_cursor = 0;
        v0
    }

    public fun deposit_pt<T0, T1>(arg0: 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject, arg1: &mut PTVault<T0, T1>, arg2: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg1.paused, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_pt_vault_paused());
        assert!(arg1.market_core_id == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg2), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market_core());
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::assert_registered_pt_vault<T0>(arg2, 0x2::object::id<PTVault<T0, T1>>(arg1));
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::assert_entry_open<T0>(arg2, 0x2::clock::timestamp_ms(arg3));
        assert!(0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::market_core_id(&arg0) == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg2), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market());
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth_match(&arg1.adapter_auth_type, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::adapter_auth_type_ref(&arg0));
        assert!(0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::maturity_ms(&arg0) == arg1.maturity_ms, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market());
        if (should_compact_inventory(0x1::vector::length<0x2::object::ID>(&arg1.inventory_ids), arg1.head_cursor)) {
            let v0 = compact_inventory_prefix<T0, T1>(arg1);
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::events::emit_pt_vault_compacted(0x2::object::id<PTVault<T0, T1>>(arg1), v0);
        };
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.inventory_ids) < 10000, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_pt_inventory_full());
        let v1 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::notional(&arg0);
        assert!(v1 > 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_zero_amount());
        let v2 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::id(&arg0);
        0x2::object_table::add<0x2::object::ID, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject>(&mut arg1.inventory, v2, arg0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.inventory_ids, v2);
        arg1.total_notional = arg1.total_notional + v1;
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::events::emit_pt_deposited_to_vault(0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg2), 0x2::object::id<PTVault<T0, T1>>(arg1), v2, v1);
        0x2::coin::mint<T1>(&mut arg1.treasury_cap, v1, arg4)
    }

    public fun head_cursor<T0, T1>(arg0: &PTVault<T0, T1>) : u64 {
        arg0.head_cursor
    }

    public fun head_escrow_id<T0, T1>(arg0: &PTVault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        if (arg0.head_cursor >= 0x1::vector::length<0x2::object::ID>(&arg0.inventory_ids)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::escrow_id(0x2::object_table::borrow<0x2::object::ID, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject>(&arg0.inventory, *0x1::vector::borrow<0x2::object::ID>(&arg0.inventory_ids, arg0.head_cursor))))
        }
    }

    public fun head_pt_id<T0, T1>(arg0: &PTVault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        if (arg0.head_cursor >= 0x1::vector::length<0x2::object::ID>(&arg0.inventory_ids)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(*0x1::vector::borrow<0x2::object::ID>(&arg0.inventory_ids, arg0.head_cursor))
        }
    }

    public fun inventory_len<T0, T1>(arg0: &PTVault<T0, T1>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.inventory_ids)
    }

    public fun is_paused<T0, T1>(arg0: &PTVault<T0, T1>) : bool {
        arg0.paused
    }

    public fun live_inventory_len<T0, T1>(arg0: &PTVault<T0, T1>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.inventory_ids) - arg0.head_cursor
    }

    public fun max_inventory() : u64 {
        10000
    }

    public fun pause<T0, T1>(arg0: &mut PTVault<T0, T1>, arg1: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::PauseCap, arg2: vector<u8>) {
        arg0.paused = true;
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::events::emit_paused(3, 0x2::object::id<PTVault<T0, T1>>(arg0), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pause_state::lock_global(), 0, arg2);
    }

    public fun redeem_step<T0, T1, T2: drop>(arg0: &mut 0x2::coin::Coin<T1>, arg1: &mut PTVault<T0, T1>, arg2: &mut 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::MarketCore<T0>, arg3: &mut 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::split_escrow::SplitEscrow<T0>, arg4: &T2, arg5: &0x2::clock::Clock, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg1.market_core_id == 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::id<T0>(arg2), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_market_core());
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::market_core::assert_registered_pt_vault<T0>(arg2, 0x2::object::id<PTVault<T0, T1>>(arg1));
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth::assert_auth<T2>(&arg1.adapter_auth_type);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.maturity_ms, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_not_matured());
        assert!(arg1.head_cursor < 0x1::vector::length<0x2::object::ID>(&arg1.inventory_ids), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_insufficient_inventory());
        let v0 = *0x1::vector::borrow<0x2::object::ID>(&arg1.inventory_ids, arg1.head_cursor);
        let v1 = 0x2::object_table::borrow<0x2::object::ID, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject>(&arg1.inventory, v0);
        assert!(0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::escrow_id(v1) == 0x2::object::id<0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::split_escrow::SplitEscrow<T0>>(arg3), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_pt_vault_inventory_mismatch());
        let v2 = 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::notional(v1);
        assert!(!0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::split_escrow::is_paused<T0>(arg3), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_pt_vault_head_paused());
        let v3 = 0x2::coin::value<T1>(arg0);
        assert!(v3 > 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_zero_amount());
        let v4 = if (v2 <= v3) {
            v2
        } else {
            v3
        };
        let v5 = if (v4 == v2) {
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::destroy_for_base(0x2::object_table::remove<0x2::object::ID, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject>(&mut arg1.inventory, v0));
            arg1.head_cursor = arg1.head_cursor + 1;
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::split_escrow::close_pt_side<T0, T2>(arg3, arg2, arg4, arg5, arg6)
        } else {
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::decrease_notional(0x2::object_table::borrow_mut<0x2::object::ID, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::pt_object::PTObject>(&mut arg1.inventory, v0), v4);
            0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::split_escrow::take_partial_pt<T0, T2>(arg3, arg2, arg4, arg5, arg6, v2, v4)
        };
        0x2::coin::burn<T1>(&mut arg1.treasury_cap, 0x2::coin::split<T1>(arg0, v4, arg7));
        arg1.total_notional = arg1.total_notional - v4;
        v5
    }

    public fun scope_pt_vault() : u8 {
        3
    }

    public fun share<T0, T1>(arg0: PTVault<T0, T1>) {
        0x2::transfer::share_object<PTVault<T0, T1>>(arg0);
    }

    fun should_compact_inventory(arg0: u64, arg1: u64) : bool {
        arg0 >= 10000 && arg1 > 0
    }

    public fun total_notional<T0, T1>(arg0: &PTVault<T0, T1>) : u64 {
        arg0.total_notional
    }

    public fun unpause<T0, T1>(arg0: &mut PTVault<T0, T1>, arg1: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::MarketAdminCap, arg2: 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::timelock::TimelockReceipt, arg3: &0x2::clock::Clock) {
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::timelock::consume_receipt(arg2, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::timelock::action_unpause_pt_vault(), 0x2::object::id<PTVault<T0, T1>>(arg0), arg3);
        arg0.paused = false;
        0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::events::emit_unpaused(3, 0x2::object::id<PTVault<T0, T1>>(arg0));
    }

    // decompiled from Move bytecode v7
}

