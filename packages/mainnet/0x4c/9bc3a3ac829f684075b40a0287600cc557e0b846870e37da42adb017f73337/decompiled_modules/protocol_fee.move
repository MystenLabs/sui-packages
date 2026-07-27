module 0x4c9bc3a3ac829f684075b40a0287600cc557e0b846870e37da42adb017f73337::protocol_fee {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeVault has key {
        id: 0x2::object::UID,
        protocol_cut_rate: u64,
        capture_rate: u64,
        volume_cap_rate: u64,
        overlay_fees: 0x2::bag::Bag,
        surplus_revenue: 0x2::bag::Bag,
    }

    struct InitProtocolFeeEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
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

    public fun collect_overlay_fee<T0>(arg0: &AdminCap, arg1: &mut ProtocolFeeVault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.overlay_fees, v0)) {
            return
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.overlay_fees, v0);
        let v2 = CollectOverlayFeeEvent{
            vault_id  : 0x2::object::id<ProtocolFeeVault>(arg1),
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v1),
            recipient : arg2,
        };
        0x2::event::emit<CollectOverlayFeeEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg2);
    }

    public fun collect_surplus_revenue<T0>(arg0: &AdminCap, arg1: &mut ProtocolFeeVault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.surplus_revenue, v0)) {
            return
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.surplus_revenue, v0);
        let v2 = CollectSurplusRevenueEvent{
            vault_id  : 0x2::object::id<ProtocolFeeVault>(arg1),
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v1),
            recipient : arg2,
        };
        0x2::event::emit<CollectSurplusRevenueEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg2);
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

    public fun deposit_overlay_fee<T0>(arg0: &mut ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = &mut arg0.overlay_fees;
        deposit<T0>(v0, 0x2::object::id<ProtocolFeeVault>(arg0), 0, arg1);
    }

    public fun deposit_surplus_revenue<T0>(arg0: &mut ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>) {
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
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = InitProtocolFeeEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v1),
            vault_id     : 0x2::object::id<ProtocolFeeVault>(&v0),
        };
        0x2::event::emit<InitProtocolFeeEvent>(v2);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ProtocolFeeVault>(v0);
    }

    public fun protocol_cut_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.protocol_cut_rate
    }

    public fun rate_denominator() : u64 {
        1000000
    }

    public fun set_capture_rate(arg0: &AdminCap, arg1: &mut ProtocolFeeVault, arg2: u64) {
        assert!(arg2 <= 1000000, 1);
        let v0 = RateChangedEvent{
            vault_id : 0x2::object::id<ProtocolFeeVault>(arg1),
            param    : 1,
            old_rate : arg1.capture_rate,
            new_rate : arg2,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg1.capture_rate = arg2;
    }

    public fun set_protocol_cut_rate(arg0: &AdminCap, arg1: &mut ProtocolFeeVault, arg2: u64) {
        assert!(arg2 <= 1000000, 1);
        let v0 = RateChangedEvent{
            vault_id : 0x2::object::id<ProtocolFeeVault>(arg1),
            param    : 0,
            old_rate : arg1.protocol_cut_rate,
            new_rate : arg2,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg1.protocol_cut_rate = arg2;
    }

    public fun set_volume_cap_rate(arg0: &AdminCap, arg1: &mut ProtocolFeeVault, arg2: u64) {
        assert!(arg2 <= 1000000, 1);
        let v0 = RateChangedEvent{
            vault_id : 0x2::object::id<ProtocolFeeVault>(arg1),
            param    : 2,
            old_rate : arg1.volume_cap_rate,
            new_rate : arg2,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg1.volume_cap_rate = arg2;
    }

    public fun volume_cap_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.volume_cap_rate
    }

    // decompiled from Move bytecode v7
}

