module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::liquidation_gate {
    struct LiquidatorRegistry has key {
        id: 0x2::object::UID,
        active: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun accrue_liquidation_fee_authorized(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::FeeCollector, arg3: address, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u64, arg7: u64) {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::fee_manager::accrue_liquidation_fee(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun assert_cap_active(arg0: &LiquidatorRegistry, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap) {
        let v0 = 0x2::object::id<0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.active, &v0), 0);
    }

    public fun close_position_for_liquidation_authorized<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::LiquidationLock) : 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::StoredPosition {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::close_position_for_liquidation<T0>(arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun collect_insurance_authorized<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg3: address, arg4: u64) : u64 {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::collect_insurance<T0>(arg2, arg3, arg4)
    }

    public fun cover_deficit_authorized(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::InsuranceFundState, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::insurance_fund::cover_deficit(arg2, arg3, arg4)
    }

    public fun credit_realized_pnl_from_insurance_authorized<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg3: address, arg4: u64, arg5: bool) {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::credit_realized_pnl_from_insurance<T0>(arg2, arg3, arg4, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidatorRegistry{
            id     : 0x2::object::new(arg0),
            active : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<LiquidatorRegistry>(v0);
    }

    public fun is_cap_active(arg0: &LiquidatorRegistry, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.active, &arg1)
    }

    public fun lock_for_liquidation_authorized(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg3: address, arg4: 0x2::object::ID) : 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::LiquidationLock {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::lock_for_liquidation(arg2, arg3, arg4)
    }

    public fun record_realized_pnl_debit_authorized<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg3: address, arg4: u64) {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::record_realized_pnl_debit<T0>(arg2, arg3, arg4);
    }

    public fun reduce_position_authorized<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::PositionStore, arg3: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank::MarginBank<T0>, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: bool, arg11: u128, arg12: u64) {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::position_store::reduce_position<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun register_liquidator_cap(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut LiquidatorRegistry, arg2: 0x2::object::ID) {
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg1.active, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg1.active, arg2);
        };
    }

    public fun revoke_liquidator_cap_id(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut LiquidatorRegistry, arg2: 0x2::object::ID) {
        if (0x2::vec_set::contains<0x2::object::ID>(&arg1.active, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg1.active, &arg2);
        };
    }

    public fun set_long_oi_authorized(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: vector<u8>, arg4: u64) {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::set_long_oi(arg2, arg3, arg4);
    }

    public fun set_short_oi_authorized(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::LiquidatorCap, arg1: &LiquidatorRegistry, arg2: &mut 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: vector<u8>, arg4: u64) {
        assert_cap_active(arg1, arg0);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::set_short_oi(arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

