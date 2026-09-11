module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::deposit {
    struct Deposited has copy, drop {
        depositor: address,
        denomination: 0x1::type_name::TypeName,
        amount_in: u64,
        net_value: u64,
        fee: u64,
        minted: u64,
        nav: u64,
    }

    public fun begin<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::DepositTicket {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1300);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::nav::value_of_amount(arg0, v1, v0, arg2);
        assert!(v2 > 0, 1301);
        let v3 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut(arg0);
        let v4 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v3);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::assert_denomination(v4, v1);
        assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::is_constituent(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v3), v1), 1303);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::assert_within_peg(v4, v1, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::get(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v3), v4, v1, arg2));
        let v5 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::token_count(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v3));
        assert!(v5 > 0, 1306);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::assert_nav_fresh(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v3), v4, arg2);
        let v6 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::calc_deposit_fee(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v3), v4, v2);
        let v7 = v2 - v6;
        assert!(v7 > 0, 1301);
        let v8 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::nav(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting(v3));
        let v9 = (((v7 as u128) * (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire_scale() as u128) / (v8 as u128)) as u64);
        assert!(v9 > 0, 1301);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::join<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::reserve_mut(v3), 0x2::coin::into_balance<T0>(arg1));
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::record_fee(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting_mut(v3), v6);
        let v10 = Deposited{
            depositor    : 0x2::tx_context::sender(arg3),
            denomination : v1,
            amount_in    : v0,
            net_value    : v7,
            fee          : v6,
            minted       : v9,
            nav          : v8,
        };
        0x2::event::emit<Deposited>(v10);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::new_deposit(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 0x2::tx_context::sender(arg3), v9, v7, v5, arg3)
    }

    public fun finish(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::DepositTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5> {
        let (_, v1) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::consume_deposit(arg1, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0));
        let (v2, v3) = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::accounting_and_treasury_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut(arg0));
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::invalidate_nav(v2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::mint(v2, v3, v1, arg2)
    }

    public fun leg_begin<T0, T1>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::DepositTicket, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::SwapReceipt) {
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::deposit_version(arg1) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 1307);
        let v0 = 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::deposit_registry(arg1) == v0, 1308);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        let v3 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0);
        let v4 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::composition(v3);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::is_constituent(v4, v1), 1302);
        let v5 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::weight_of(v4, v1);
        let v6 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::policy(v3);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::assert_denomination(v6, v2);
        let v7 = (((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::deposit_net_value(arg1) as u128) * (v5 as u128) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor() as u128)) as u64);
        let v8 = to_amount(v7, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::decimals_of(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v3), v2), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::get(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v3), v6, v2, arg2));
        let v9 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::decimals_of(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v3), v1);
        let v10 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::reserve_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut(arg0));
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::balance_of<T1>(v10) >= v8, 1305);
        (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::split<T1>(v10, v8), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::new_receipt(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), v0, 0x1::option::some<0x2::object::ID>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::deposit_id(arg1)), v2, v1, v8, (((to_amount(v7, v9, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::get(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::prices(v3), v6, v1, arg2)) as u128) * ((0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor() - 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::max_slippage_bps(v6)) as u128) / (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor() as u128)) as u64)))
    }

    public fun leg_settle<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::DepositTicket, arg2: 0x2::balance::Balance<T0>, arg3: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::SwapReceipt) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::settle_receipt(arg3, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::version(), 0x2::object::id<0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry>(arg0), 0x1::option::some<0x2::object::ID>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::deposit_id(arg1)), 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::receipt_token_in(&arg3), v0, 0x2::balance::value<T0>(&arg2));
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::join<T0>(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::custody_mut(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner_mut(arg0)), arg2);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket::deposit_mark_bought(arg1, v0);
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun to_amount(arg0: u64, arg1: u8, arg2: u64) : u64 {
        (((arg0 as u128) * pow10((arg1 as u64)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

