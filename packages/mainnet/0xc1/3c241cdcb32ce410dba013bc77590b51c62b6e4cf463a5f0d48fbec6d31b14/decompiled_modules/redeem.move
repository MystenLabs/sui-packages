module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::redeem {
    struct Withdrawn has copy, drop {
        withdrawer: address,
        burned: u64,
        proceeds: u64,
        fee: u64,
    }

    struct RedeemedInKind has copy, drop {
        redeemer: address,
        burned: u64,
        supply_at_burn: u64,
    }

    struct SliceTaken has copy, drop {
        redeemer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun preview_slice<T0>(arg0: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: u64) : u64 {
        let v0 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0);
        let v1 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::supply(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v0));
        if (v1 == 0) {
            return 0
        };
        (((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::balance_of<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody(v0)) as u128) * (arg1 as u128) / (v1 as u128)) as u64)
    }

    public fun redeem_finish(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::RedeemTicket) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::consume_redeem(arg1, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0));
    }

    public fun redeem_in_kind(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0x2::coin::Coin<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>, arg2: &mut 0x2::tx_context::TxContext) : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::RedeemTicket {
        let v0 = 0x2::coin::value<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>(&arg1);
        assert!(v0 > 0, 1400);
        let v1 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_for_exit(arg0);
        let v2 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::supply(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v1));
        assert!(v2 > 0, 1401);
        let (v3, v4) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting_and_treasury_mut(v1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::burn(v3, v4, arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::invalidate_nav(v3);
        let v5 = RedeemedInKind{
            redeemer       : 0x2::tx_context::sender(arg2),
            burned         : v0,
            supply_at_burn : v2,
        };
        0x2::event::emit<RedeemedInKind>(v5);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::new_redeem(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 0x2::tx_context::sender(arg2), v0, v2, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::token_count(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v1)), arg2)
    }

    public fun redeem_take<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::RedeemTicket, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::redeem_version(arg1) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 1404);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::redeem_registry(arg1) == 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 1405);
        let v1 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_for_exit(arg0));
        let v2 = (((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::balance_of<T0>(v1) as u128) * (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::redeem_burned(arg1) as u128) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::redeem_supply_at_burn(arg1) as u128)) as u64);
        assert!(v2 > 0, 1403);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::redeem_mark_taken(arg1, v0);
        let v3 = SliceTaken{
            redeemer : 0x2::tx_context::sender(arg2),
            token    : v0,
            amount   : v2,
        };
        0x2::event::emit<SliceTaken>(v3);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::split<T0>(v1, v2)
    }

    public fun withdraw_begin(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0x2::coin::Coin<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>, arg2: &mut 0x2::tx_context::TxContext) : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::WithdrawTicket {
        let v0 = 0x2::coin::value<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>(&arg1);
        assert!(v0 > 0, 1400);
        let v1 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_for_exit(arg0);
        let v2 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::supply(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v1));
        assert!(v2 > 0, 1401);
        let (v3, v4) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting_and_treasury_mut(v1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::burn(v3, v4, arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::invalidate_nav(v3);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::new_withdraw(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 0x2::tx_context::sender(arg2), v0, v2, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::token_count(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v1)), arg2)
    }

    public fun withdraw_finish<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::WithdrawTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::assert_denomination(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_for_exit(arg0)), v0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_assert_denomination(&arg1, v0);
        let (v1, v2, v3) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::consume_withdraw(arg1, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0));
        let v4 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_for_exit(arg0);
        let v5 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::calc_withdrawal_fee(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v4), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v4), v3);
        let v6 = v3 - v5;
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::record_fee(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting_mut(v4), v5);
        let v7 = Withdrawn{
            withdrawer : v1,
            burned     : v2,
            proceeds   : v6,
            fee        : v5,
        };
        0x2::event::emit<Withdrawn>(v7);
        0x2::coin::from_balance<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::split<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::reserve_mut(v4), v6), arg2)
    }

    public fun withdraw_leg_begin<T0, T1>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::WithdrawTicket, arg2: u64) : (0x2::balance::Balance<T0>, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::SwapReceipt) {
        let v0 = 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_version(arg1) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 1404);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_registry(arg1) == v0, 1405);
        let v3 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_for_exit(arg0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::assert_constituent(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v3), v1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::assert_denomination(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v3), v2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_bind_denomination(arg1, v2);
        let v4 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody_mut(v3);
        let v5 = (((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::balance_of<T0>(v4) as u128) * (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_burned(arg1) as u128) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_supply_at_burn(arg1) as u128)) as u64);
        (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::split<T0>(v4, v5), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::new_receipt(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), v0, 0x1::option::some<0x2::object::ID>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_id(arg1)), v1, v2, v5, arg2))
    }

    public fun withdraw_leg_settle<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::WithdrawTicket, arg2: 0x2::balance::Balance<T0>, arg3: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::SwapReceipt) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::receipt_token_in(&arg3);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::settle_receipt(arg3, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 0x1::option::some<0x2::object::ID>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_id(arg1)), v1, 0x1::type_name::with_defining_ids<T0>(), v0);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::join<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::reserve_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut_for_exit(arg0)), arg2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::withdraw_mark_sold(arg1, v1, v0);
    }

    // decompiled from Move bytecode v7
}

