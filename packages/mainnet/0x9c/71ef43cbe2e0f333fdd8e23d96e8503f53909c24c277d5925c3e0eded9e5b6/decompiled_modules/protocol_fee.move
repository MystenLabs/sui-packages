module 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee {
    struct ProtocolFeeVault has key {
        id: 0x2::object::UID,
        protocol_cut_rate: u64,
        capture_rate: u64,
        volume_cap_rate: u64,
        overlay_fees: 0x2::bag::Bag,
        surplus_revenue: 0x2::bag::Bag,
    }

    struct InitProtocolFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct RateChangedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        param: u8,
        old_rate: u64,
        new_rate: u64,
    }

    struct CollectOverlayFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        bucket: u8,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CollectSurplusRevenueEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun capture_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.capture_rate
    }

    public fun collect_overlay_fee<T0>(arg0: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::admin_cap::AdminCap, arg1: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::check_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg2.overlay_fees, v0)) {
            return
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.overlay_fees, v0);
        let v2 = CollectOverlayFeeEvent{
            vault_id  : 0x2::object::id<ProtocolFeeVault>(arg2),
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v1),
            recipient : arg3,
        };
        0x2::event::emit<CollectOverlayFeeEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), arg3);
    }

    public fun collect_surplus_revenue<T0>(arg0: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::admin_cap::AdminCap, arg1: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::check_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg2.surplus_revenue, v0)) {
            return
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.surplus_revenue, v0);
        let v2 = CollectSurplusRevenueEvent{
            vault_id  : 0x2::object::id<ProtocolFeeVault>(arg2),
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v1),
            recipient : arg3,
        };
        0x2::event::emit<CollectSurplusRevenueEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), arg3);
    }

    fun deposit<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = DepositEvent{
            vault_id  : arg1,
            bucket    : arg2,
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&arg3),
        };
        0x2::event::emit<DepositEvent>(v1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0, arg3);
        };
    }

    public(friend) fun deposit_overlay_fee<T0>(arg0: &mut ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = &mut arg0.overlay_fees;
        deposit<T0>(v0, 0x2::object::id<ProtocolFeeVault>(arg0), 0, arg1);
    }

    public(friend) fun deposit_surplus_revenue<T0>(arg0: &mut ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = &mut arg0.surplus_revenue;
        deposit<T0>(v0, 0x2::object::id<ProtocolFeeVault>(arg0), 1, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolFeeVault{
            id                : 0x2::object::new(arg0),
            protocol_cut_rate : 200000,
            capture_rate      : 250000,
            volume_cap_rate   : 10000,
            overlay_fees      : 0x2::bag::new(arg0),
            surplus_revenue   : 0x2::bag::new(arg0),
        };
        let v1 = InitProtocolFeeEvent{vault_id: 0x2::object::id<ProtocolFeeVault>(&v0)};
        0x2::event::emit<InitProtocolFeeEvent>(v1);
        0x2::transfer::share_object<ProtocolFeeVault>(v0);
    }

    public fun protocol_cut_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.protocol_cut_rate
    }

    public fun rate_denominator() : u64 {
        1000000
    }

    public fun set_capture_rate(arg0: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::admin_cap::AdminCap, arg1: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64) {
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::check_version(arg1);
        assert!(arg3 <= 1000000, 1);
        let v0 = RateChangedEvent{
            vault_id : 0x2::object::id<ProtocolFeeVault>(arg2),
            param    : 1,
            old_rate : arg2.capture_rate,
            new_rate : arg3,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg2.capture_rate = arg3;
    }

    public fun set_protocol_cut_rate(arg0: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::admin_cap::AdminCap, arg1: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64) {
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::check_version(arg1);
        assert!(arg3 <= 1000000, 1);
        let v0 = RateChangedEvent{
            vault_id : 0x2::object::id<ProtocolFeeVault>(arg2),
            param    : 0,
            old_rate : arg2.protocol_cut_rate,
            new_rate : arg3,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg2.protocol_cut_rate = arg3;
    }

    public fun set_volume_cap_rate(arg0: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::admin_cap::AdminCap, arg1: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64) {
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::check_version(arg1);
        assert!(arg3 <= 1000000, 1);
        let v0 = RateChangedEvent{
            vault_id : 0x2::object::id<ProtocolFeeVault>(arg2),
            param    : 2,
            old_rate : arg2.volume_cap_rate,
            new_rate : arg3,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg2.volume_cap_rate = arg3;
    }

    public fun volume_cap_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.volume_cap_rate
    }

    // decompiled from Move bytecode v7
}

