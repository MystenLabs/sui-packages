module 0xca20bdedb8726c576c4551f1a7c0ddab2cc864af80ad27da2a046ab2d0d49a31::double_zero {
    struct Activated has copy, drop {
        dummy_field: bool,
    }

    struct Deactivated has copy, drop {
        dummy_field: bool,
    }

    struct MaxBetRoundsSet has copy, drop {
        max_bet_rounds: u8,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct Deposited has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        expected_amount: u64,
        actual_amount: u64,
    }

    struct HouseEdgeSet has copy, drop {
        pool_id: 0x2::object::ID,
        house_edge: u64,
    }

    struct KellyMultiplierSet has copy, drop {
        pool_id: 0x2::object::ID,
        kelly_multiplier: u64,
    }

    struct PlayResult has copy, drop {
        pool_id: 0x2::object::ID,
        amount_per_round: u64,
        results: vector<bool>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DoubleZeroConfig has store, key {
        id: 0x2::object::UID,
        activated: bool,
        max_bet_rounds: u8,
    }

    struct DoubleZeroPoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DoubleZeroPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        house_edge: u64,
        kelly_multiplier: u64,
    }

    public fun activate(arg0: &mut DoubleZeroConfig, arg1: &AdminCap) {
        assert!(!arg0.activated, 13906834719804358659);
        arg0.activated = true;
        let v0 = Activated{dummy_field: false};
        0x2::event::emit<Activated>(v0);
    }

    public fun deactivate(arg0: &mut DoubleZeroConfig, arg1: &AdminCap) {
        assert!(arg0.activated, 13906834745574293509);
        arg0.activated = false;
        let v0 = Deactivated{dummy_field: false};
        0x2::event::emit<Deactivated>(v0);
    }

    public fun deposit<T0>(arg0: &mut DoubleZeroPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = Deposited{
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            amount  : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<Deposited>(v1);
        0x2::balance::join<T0>(&mut arg0.balance, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DoubleZeroConfig{
            id             : 0x2::object::new(arg0),
            activated      : false,
            max_bet_rounds : 10,
        };
        0x2::transfer::share_object<DoubleZeroConfig>(v1);
    }

    public fun new_double_zero_pool<T0>(arg0: &mut DoubleZeroConfig, arg1: &AdminCap, arg2: &0x2::coin_registry::Currency<T0>) {
        let v0 = DoubleZeroPoolKey<T0>{dummy_field: false};
        assert!(!0x2::derived_object::exists<DoubleZeroPoolKey<T0>>(&arg0.id, v0), 13906834814294032393);
        let v1 = DoubleZeroPoolKey<T0>{dummy_field: false};
        let v2 = 0x2::derived_object::claim<DoubleZeroPoolKey<T0>>(&mut arg0.id, v1);
        let v3 = PoolCreated{
            pool_id : 0x2::object::uid_to_inner(&v2),
            name    : 0x2::coin_registry::name<T0>(arg2),
            symbol  : 0x2::coin_registry::symbol<T0>(arg2),
        };
        0x2::event::emit<PoolCreated>(v3);
        let v4 = DoubleZeroPool<T0>{
            id               : v2,
            balance          : 0x2::balance::zero<T0>(),
            house_edge       : 1000000 / 100,
            kelly_multiplier : 1000000,
        };
        0x2::transfer::share_object<DoubleZeroPool<T0>>(v4);
    }

    entry fun play_double_zero<T0>(arg0: &mut DoubleZeroPool<T0>, arg1: &DoubleZeroConfig, arg2: &mut 0x2::coin::Coin<T0>, arg3: u8, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.activated, 13906835153596841999);
        assert!(arg3 > 0 && arg3 <= arg1.max_bet_rounds, 13906835157891940369);
        let v0 = 0x2::coin::balance_mut<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(v0);
        assert!(v1 > 0 && v1 % (arg3 as u64) == 0, 13906835175071940627);
        let v2 = v1 / (arg3 as u64);
        let v3 = v2 * ((arg3 - 1) as u64);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.balance), 13906835192251940885);
        assert!((v2 as u256) * (1000000000000 as u256) <= ((0x2::balance::value<T0>(&arg0.balance) - v3) as u256) * (arg0.house_edge as u256) * (arg0.kelly_multiplier as u256), 13906835209431810069);
        let v4 = 0x2::balance::split<T0>(v0, v1);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.balance, v1));
        let v5 = 0x2::random::new_generator(arg4, arg5);
        let v6 = 0;
        let v7 = 0x1::vector::empty<bool>();
        let v8 = 0;
        while (v8 < arg3) {
            if (0x2::random::generate_u64(&mut v5) < ((((1000000 as u256) - (arg0.house_edge as u256)) * 18446744073709551615 / ((2 * 1000000) as u256)) as u64)) {
                v6 = v6 + v2 * 2;
                0x1::vector::push_back<bool>(&mut v7, true);
            } else {
                0x1::vector::push_back<bool>(&mut v7, false);
            };
            v8 = v8 + 1;
        };
        0x2::balance::join<T0>(v0, 0x2::balance::split<T0>(&mut v4, v6));
        0x2::balance::join<T0>(&mut arg0.balance, v4);
        let v9 = PlayResult{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            amount_per_round : v2,
            results          : v7,
        };
        0x2::event::emit<PlayResult>(v9);
    }

    public fun receive<T0>(arg0: &mut DoubleZeroPool<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        deposit<T0>(arg0, v0);
    }

    public fun set_house_edge<T0>(arg0: &mut DoubleZeroPool<T0>, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 > 0 && arg2 < 1000000, 13906835029042528267);
        arg0.house_edge = arg2;
        let v0 = HouseEdgeSet{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            house_edge : arg2,
        };
        0x2::event::emit<HouseEdgeSet>(v0);
    }

    public fun set_kelly_multiplier<T0>(arg0: &mut DoubleZeroPool<T0>, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 1000000, 13906835084877234189);
        arg0.kelly_multiplier = arg2;
        let v0 = KellyMultiplierSet{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            kelly_multiplier : arg2,
        };
        0x2::event::emit<KellyMultiplierSet>(v0);
    }

    public fun set_max_bet_rounds(arg0: &mut DoubleZeroConfig, arg1: &AdminCap, arg2: u8) {
        assert!(arg2 > 0, 13906834771344228359);
        arg0.max_bet_rounds = arg2;
        let v0 = MaxBetRoundsSet{max_bet_rounds: arg2};
        0x2::event::emit<MaxBetRoundsSet>(v0);
    }

    public fun withdraw<T0>(arg0: &mut DoubleZeroPool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::u64::min(arg2, 0x2::balance::value<T0>(&arg0.balance));
        let v1 = Withdrawn{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            expected_amount : arg2,
            actual_amount   : v0,
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg3)
    }

    // decompiled from Move bytecode v6
}

