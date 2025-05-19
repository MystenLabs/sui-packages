module 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage {
    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        is_open_protocol_fee: bool,
        registered_pools: 0x2::table::Table<0x1::string::String, address>,
        operators: 0x2::vec_set::VecSet<address>,
        version: u64,
    }

    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        bal_x: 0x2::balance::Balance<T0>,
        bal_y: 0x2::balance::Balance<T1>,
        fee_bal_x: 0x2::balance::Balance<T0>,
        fee_bal_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        fee_rate: u64,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
        min_add_liquidity_lp_amount: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun check_is_normal(arg0: &Global) {
        assert!(!arg0.has_paused, 14);
    }

    public(friend) fun check_operator(arg0: &Global, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &arg1), 15);
    }

    public(friend) fun check_version(arg0: &Global) {
        assert!(arg0.version == 1, 12);
    }

    public(friend) fun control_protocol_fee_switch(arg0: &mut Global, arg1: bool) {
        arg0.is_open_protocol_fee = arg1;
    }

    public(friend) fun create_pool<T0, T1>(arg0: &mut Global, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (address, 0x1::string::String, u64) {
        assert!(!has_exist<T0, T1>(arg0), 8);
        assert!(arg2 >= 10, 16);
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::extract<u64>(&mut arg1)
        } else {
            30
        };
        assert!(v0 <= 2000, 11);
        let v1 = LP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            id                          : 0x2::object::new(arg3),
            bal_x                       : 0x2::balance::zero<T0>(),
            bal_y                       : 0x2::balance::zero<T1>(),
            fee_bal_x                   : 0x2::balance::zero<T0>(),
            fee_bal_y                   : 0x2::balance::zero<T1>(),
            lp_supply                   : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            fee_rate                    : v0,
            min_liquidity               : 0x2::balance::zero<LP<T0, T1>>(),
            min_add_liquidity_lp_amount : arg2,
        };
        let v3 = 0x2::object::id_address<Pool<T0, T1>>(&v2);
        let v4 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>();
        0x2::table::add<0x1::string::String, address>(&mut arg0.registered_pools, v4, v3);
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
        (v3, v4, v0)
    }

    public(friend) fun get_balance<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.bal_x), 0x2::balance::value<T1>(&arg0.bal_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public(friend) fun get_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public(friend) fun get_global_id(arg0: &Global) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_is_open_protocol_fee(arg0: &Global) : bool {
        arg0.is_open_protocol_fee
    }

    public(friend) fun get_min_add_liquidity_lp_amount<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.min_add_liquidity_lp_amount
    }

    public(friend) fun get_min_remove_liquidity_lp_amount<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.min_add_liquidity_lp_amount / 10
    }

    public(friend) fun get_mut_bal_x<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.bal_x
    }

    public(friend) fun get_mut_bal_y<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.bal_y
    }

    public(friend) fun get_mut_fee_bal_x<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.fee_bal_x
    }

    public(friend) fun get_mut_fee_bal_y<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.fee_bal_y
    }

    public(friend) fun get_mut_lp_supply<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::balance::Supply<LP<T0, T1>> {
        &mut arg0.lp_supply
    }

    public(friend) fun get_mut_min_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::balance::Balance<LP<T0, T1>> {
        &mut arg0.min_liquidity
    }

    public(friend) fun get_mut_operators(arg0: &mut Global) : &mut 0x2::vec_set::VecSet<address> {
        &mut arg0.operators
    }

    public(friend) fun get_pool_address<T0, T1>(arg0: &Global) : address {
        assert!(has_exist<T0, T1>(arg0), 9);
        *0x2::table::borrow<0x1::string::String, address>(&arg0.registered_pools, 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>())
    }

    public(friend) fun get_version(arg0: &Global) : u64 {
        arg0.version
    }

    public(friend) fun has_exist<T0, T1>(arg0: &Global) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.registered_pools, 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>())
    }

    public(friend) fun has_paused(arg0: &Global) : bool {
        arg0.has_paused
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                   : 0x2::object::new(arg0),
            has_paused           : false,
            is_open_protocol_fee : false,
            registered_pools     : 0x2::table::new<0x1::string::String, address>(arg0),
            operators            : 0x2::vec_set::empty<address>(),
            version              : 1,
        };
        0x2::transfer::share_object<Global>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun modify_fee_rate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        assert!(arg1 <= 2000, 11);
        arg0.fee_rate = arg1;
    }

    public(friend) fun modify_min_add_liquidity_lp_amount<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        assert!(arg1 >= 10, 16);
        arg0.min_add_liquidity_lp_amount = arg1;
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.has_paused = false;
    }

    public(friend) fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public(friend) fun upgrade(arg0: &mut Global) {
        assert!(arg0.version < 1, 13);
        arg0.version = 1;
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.fee_bal_x);
        let v1 = 0x2::balance::value<T1>(&arg0.fee_bal_y);
        assert!(v0 > 0 && v1 > 0, 10);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_bal_x, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_bal_y, v1), arg1), v0, v1)
    }

    // decompiled from Move bytecode v6
}

