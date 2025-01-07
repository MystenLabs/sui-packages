module 0x93c1122cf82a2f6267116dec7e6ce3160a767262b5c0af0a10cd5afd38472e5a::pool {
    struct PoolCreationEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        lp_fee_bps: u64,
        admin_fee_pct: u64,
        admin_fee_balance: 0x2::balance::Balance<LP<T0, T1>>,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<PoolRegistryItem, bool>,
    }

    struct PoolRegistryItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_fee_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<LP<T0, T1>>(&arg0.admin_fee_balance)
    }

    public fun admin_set_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        assert!(arg2 < 10000, 9223374205813653511);
        assert!(arg3 <= 100, 9223374210108620807);
        arg0.lp_fee_bps = arg2;
        arg0.admin_fee_pct = arg3;
    }

    public fun admin_withdraw_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &AdminCap, arg2: u64) : 0x2::balance::Balance<LP<T0, T1>> {
        if (arg2 == 0) {
            arg2 = 0x2::balance::value<LP<T0, T1>>(&arg0.admin_fee_balance);
        };
        0x2::balance::split<LP<T0, T1>>(&mut arg0.admin_fee_balance, arg2)
    }

    fun calc_swap_result(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = ceil_muldiv(arg0, arg4, 10000);
        let v1 = arg0 - v0;
        (muldiv(v1, arg2, arg1 + v1), (0x1::u128::sqrt(muldiv_u128((arg3 as u128) * (arg3 as u128), ((arg1 + arg0) as u128), ((arg1 + arg0 - muldiv(v0, arg5, 100)) as u128))) as u64) - arg3)
    }

    fun ceil_muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (0x1::u128::divide_and_round_up((arg0 as u128) * (arg1 as u128), (arg2 as u128)) as u64)
    }

    public fun cmp_type_names(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) : u8 {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(arg0));
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(arg1));
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v1);
        let v4 = 0;
        while (v4 < 0x1::u64::min(v2, v3)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v4);
            let v6 = *0x1::vector::borrow<u8>(v1, v4);
            if (v5 < v6) {
                return 0
            };
            if (v5 > v6) {
                return 2
            };
            v4 = v4 + 1;
        };
        if (v2 == v3) {
            return 1
        };
        if (v2 < v3) {
            0
        } else {
            2
        }
    }

    public fun create<T0, T1>(arg0: &mut PoolRegistry, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<LP<T0, T1>> {
        assert!(0x2::balance::value<T0>(&arg1) > 0 && 0x2::balance::value<T1>(&arg2) > 0, 9223372947387842561);
        assert!(arg3 < 10000, 9223372951683203079);
        assert!(arg4 <= 100, 9223372955978170375);
        registry_add<T0, T1>(arg0);
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id                : 0x2::object::new(arg5),
            balance_a         : arg1,
            balance_b         : arg2,
            lp_supply         : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            lp_fee_bps        : arg3,
            admin_fee_pct     : arg4,
            admin_fee_balance : 0x2::balance::zero<LP<T0, T1>>(),
        };
        let v2 = PoolCreationEvent{pool_id: 0x2::object::id<Pool<T0, T1>>(&v1)};
        0x2::event::emit<PoolCreationEvent>(v2);
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        0x2::balance::increase_supply<LP<T0, T1>>(&mut v1.lp_supply, mulsqrt(0x2::balance::value<T0>(&v1.balance_a), 0x2::balance::value<T1>(&v1.balance_b)))
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1>>) {
        if (0x2::balance::value<T0>(&arg1) == 0 || 0x2::balance::value<T1>(&arg2) == 0) {
            assert!(arg3 == 0, 9223373127776600067);
            return (arg1, arg2, 0x2::balance::zero<LP<T0, T1>>())
        };
        let v0 = (0x2::balance::value<T0>(&arg1) as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128);
        let v1 = (0x2::balance::value<T1>(&arg2) as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128);
        let (v2, v3, v4) = if (v0 > v1) {
            let v5 = 0x2::balance::value<T1>(&arg2);
            ((0x1::u128::divide_and_round_up(v1, (0x2::balance::value<T1>(&arg0.balance_b) as u128)) as u64), v5, muldiv(v5, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T1>(&arg0.balance_b)))
        } else if (v0 < v1) {
            let v6 = 0x2::balance::value<T0>(&arg1);
            (v6, (0x1::u128::divide_and_round_up(v0, (0x2::balance::value<T0>(&arg0.balance_a) as u128)) as u64), muldiv(v6, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T0>(&arg0.balance_a)))
        } else {
            let v7 = 0x2::balance::value<T0>(&arg1);
            let v8 = 0x2::balance::value<T1>(&arg2);
            let v4 = if (0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply) == 0) {
                mulsqrt(v7, v8)
            } else {
                muldiv(v7, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T0>(&arg0.balance_a))
            };
            (v7, v8, v4)
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(&mut arg1, v2));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::balance::split<T1>(&mut arg2, v3));
        assert!(v4 >= arg3, 9223373398359539715);
        (arg1, arg2, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v4))
    }

    public fun fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.lp_fee_bps, arg0.admin_fee_pct)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_registry(arg0);
        0x2::transfer::share_object<PoolRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun muldiv_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    fun mulsqrt(arg0: u64, arg1: u64) : u64 {
        (0x1::u128::sqrt((arg0 as u128) * (arg1 as u128)) as u64)
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : PoolRegistry {
        PoolRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<PoolRegistryItem, bool>(arg0),
        }
    }

    fun registry_add<T0, T1>(arg0: &mut PoolRegistry) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(cmp_type_names(&v0, &v1) == 0, 9223372685395361801);
        let v2 = PoolRegistryItem{
            a : v0,
            b : v1,
        };
        assert!(!0x2::table::contains<PoolRegistryItem, bool>(&arg0.table, v2), 9223372698280394763);
        0x2::table::add<PoolRegistryItem, bool>(&mut arg0.table, v2, true);
    }

    public fun swap_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            assert!(arg2 == 0, 9223373767726727171);
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        assert!(0x2::balance::value<T0>(&arg0.balance_a) > 0 && 0x2::balance::value<T1>(&arg0.balance_b) > 0, 9223373793496662021);
        let (v0, v1) = calc_swap_result(0x2::balance::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), arg0.lp_fee_bps, arg0.admin_fee_pct);
        assert!(v0 >= arg2, 9223373870805942275);
        0x2::balance::join<LP<T0, T1>>(&mut arg0.admin_fee_balance, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v1));
        0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
        0x2::balance::split<T1>(&mut arg0.balance_b, v0)
    }

    public fun swap_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            assert!(arg2 == 0, 9223373965295222787);
            0x2::balance::destroy_zero<T1>(arg1);
            return 0x2::balance::zero<T0>()
        };
        assert!(0x2::balance::value<T0>(&arg0.balance_a) > 0 && 0x2::balance::value<T1>(&arg0.balance_b) > 0, 9223373991065157637);
        let (v0, v1) = calc_swap_result(0x2::balance::value<T1>(&arg1), 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), arg0.lp_fee_bps, arg0.admin_fee_pct);
        assert!(v0 >= arg2, 9223374068374437891);
        0x2::balance::join<LP<T0, T1>>(&mut arg0.admin_fee_balance, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v1));
        0x2::balance::join<T1>(&mut arg0.balance_b, arg1);
        0x2::balance::split<T0>(&mut arg0.balance_a, v0)
    }

    public fun values<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<LP<T0, T1>>, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<LP<T0, T1>>(&arg1) == 0) {
            0x2::balance::destroy_zero<LP<T0, T1>>(arg1);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v0 = 0x2::balance::value<LP<T0, T1>>(&arg1);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v2 = muldiv(v0, 0x2::balance::value<T0>(&arg0.balance_a), v1);
        let v3 = muldiv(v0, 0x2::balance::value<T1>(&arg0.balance_b), v1);
        assert!(v2 >= arg2, 9223373527208558595);
        assert!(v3 >= arg3, 9223373531503525891);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, arg1);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v2), 0x2::balance::split<T1>(&mut arg0.balance_b, v3))
    }

    // decompiled from Move bytecode v6
}

