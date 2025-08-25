module 0xb0af46a60fdf9d291c88e01f0c34c6817bc3449fbf0fd76f7be537b72ed5788d::swap_pool {
    struct TransferOwnership has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct SetOperator has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct SetCoinHolder has copy, drop {
        old_coin_holder: address,
        new_coin_holder: address,
    }

    struct SetCoinWhitelist has copy, drop {
        coin: 0x1::type_name::TypeName,
        decimal: u8,
        accepted: bool,
    }

    struct SetPriceOracle has copy, drop {
        new_oracle_feed_id: vector<u8>,
    }

    struct SetDexPool has copy, drop {
        new_dex_pool: 0x2::object::ID,
    }

    struct SetPriceFactor has copy, drop {
        weekday: u64,
        weekend: u64,
    }

    struct SetWeekdayParam has copy, drop {
        weekday_start_time: u64,
        weekday_duration: u64,
    }

    struct SetPriceDeviationRatio has copy, drop {
        old_price_deviation_ratio: u64,
        new_price_deviation_ratio: u64,
    }

    struct SetPriceCheck has copy, drop {
        check: bool,
    }

    struct SetXaum has copy, drop {
        xaum: 0x1::type_name::TypeName,
    }

    struct Swap has copy, drop {
        sender: address,
        coin_in: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct UpdateUserWhitelist has copy, drop {
        cap_id: 0x2::object::ID,
        accepted: bool,
    }

    struct AddUserWhitelist has copy, drop {
        user: address,
        cap_id: 0x2::object::ID,
    }

    struct SwapCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        class: u64,
        version: u64,
    }

    struct State has key {
        id: 0x2::object::UID,
        version: u64,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        owner: address,
        operator: address,
        coin_holder: address,
        xaum: 0x1::option::Option<0x1::type_name::TypeName>,
        xaum_price_oracle_feed_id: 0x1::option::Option<vector<u8>>,
        dex_pool: 0x1::option::Option<0x2::object::ID>,
        price_factor_weekday: u64,
        price_factor_weekend: u64,
        weekday_start_time: u64,
        weekday_duration: u64,
        price_deviation_ratio: u64,
        price_check: bool,
        coin_whitelist: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        user_whitelist: 0x2::table::Table<0x2::object::ID, bool>,
        balances: 0x2::bag::Bag,
    }

    public fun swap<T0, T1, T2>(arg0: &mut State, arg1: &SwapCap, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_version(arg0);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&arg0.xaum, &v0), 111);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.user_whitelist, 0x2::object::id<SwapCap>(arg1)), 112);
        let (v1, v2) = check_coin<T0>(arg0);
        assert!(0x2::coin::value<T0>(arg2) >= arg3 && arg3 > 0, 109);
        merge_coin_into_balances<T0>(arg0, 0x2::coin::split<T0>(arg2, arg3, arg7));
        let (v3, v4) = get_price_from_oracle(arg0, arg5, arg6);
        if (arg0.price_check) {
            let v5 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>>(arg4);
            assert!(0x1::option::contains<0x2::object::ID>(&arg0.dex_pool, &v5), 114);
            let v6 = (get_twap_price_from_dex<T1, T2>(arg4, v4, arg6) as u64);
            assert!(v6 * (10000 - arg0.price_deviation_ratio) / 10000 <= v3, 106);
            assert!(v6 * (10000 + arg0.price_deviation_ratio) / 10000 >= v3, 107);
        };
        let v7 = arg3 * 0x1::u64::pow(10, 9 + v4 - v2) / price_adjust(arg0, v3, arg6);
        assert!(v7 <= get_balance_amount<T1>(arg0), 108);
        let v8 = &mut arg0.balances;
        let v9 = Swap{
            sender     : 0x2::tx_context::sender(arg7),
            coin_in    : v1,
            amount_in  : arg3,
            amount_out : v7,
        };
        0x2::event::emit<Swap>(v9);
        0x2::coin::take<T1>(get_balance_mut<T1>(v8), v7, arg7)
    }

    public fun get_price(arg0: &State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u8) {
        let (v0, v1) = get_price_from_oracle(arg0, arg1, arg2);
        (price_adjust(arg0, v0, arg2), v1)
    }

    entry fun accept_payment<T0>(arg0: &mut State, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
    }

    entry fun add_user_whitelist(arg0: &mut State, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        let v0 = SwapCap{
            id      : 0x2::object::new(arg2),
            owner   : arg1,
            class   : 0,
            version : 1,
        };
        let v1 = 0x2::object::id<SwapCap>(&v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.user_whitelist, v1, true);
        let v2 = AddUserWhitelist{
            user   : arg1,
            cap_id : v1,
        };
        0x2::event::emit<AddUserWhitelist>(v2);
        let v3 = UpdateUserWhitelist{
            cap_id   : v1,
            accepted : true,
        };
        0x2::event::emit<UpdateUserWhitelist>(v3);
        0x2::transfer::public_transfer<SwapCap>(v0, arg1);
    }

    fun check_coin<T0>(arg0: &State) : (0x1::type_name::TypeName, u8) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.coin_whitelist, v0), 104);
        (v0, *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.coin_whitelist, v0))
    }

    fun check_operator(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 102);
    }

    fun check_owner(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_version(arg0: &State) {
        assert!(arg0.version == 1, 100);
    }

    public fun get_amount_out<T0, T1>(arg0: &State, arg1: u64, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u64 {
        check_version(arg0);
        let (_, v1) = check_coin<T0>(arg0);
        let (v2, v3) = get_price(arg0, arg2, arg3);
        let v4 = arg1 * 0x1::u64::pow(10, 9 + v3 - v1) / v2;
        assert!(v4 <= get_balance_amount<T1>(arg0), 108);
        v4
    }

    public fun get_balance_amount<T0>(arg0: &State) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
    }

    fun get_balance_mut<T0>(arg0: &mut 0x2::bag::Bag) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0), 105);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0)
    }

    public fun get_price_from_oracle(arg0: &State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u8) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2);
        assert!(0x1::option::contains<vector<u8>>(&arg0.xaum_price_oracle_feed_id, &v3), 115);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5), (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4) as u8))
    }

    public fun get_twap_price_from_dex<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock) : u256 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 7200);
        0x1::vector::push_back<u64>(v1, 0);
        let (v2, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::observe<T0, T1>(arg0, v0, arg2);
        let v4 = v2;
        assert!(0x1::vector::length<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::I64>(&v4) == 2, 113);
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::div(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::sub(*0x1::vector::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::I64>(&v4, 1), *0x1::vector::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::I64>(&v4, 0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::from(7200));
        let v6 = if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::is_neg(v5)) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::neg_from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::abs_u64(v5) as u32))
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i64::abs_u64(v5) as u32))
        };
        let v7 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v6);
        0x1::u256::pow(10, 9 - 6 + arg1) * (v7 as u256) * (v7 as u256) / (1 << 128)
    }

    fun in_weekday(arg0: &State, arg1: &0x2::clock::Clock) : bool {
        (0x2::clock::timestamp_ms(arg1) / 1000 - arg0.weekday_start_time) % 604800 < arg0.weekday_duration
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = State{
            id                        : 0x2::object::new(arg0),
            version                   : 1,
            upgrade_cap_id            : 0x1::option::none<0x2::object::ID>(),
            owner                     : v0,
            operator                  : v0,
            coin_holder               : v0,
            xaum                      : 0x1::option::none<0x1::type_name::TypeName>(),
            xaum_price_oracle_feed_id : 0x1::option::some<vector<u8>>(x"d7db067954e28f51a96fd50c6d51775094025ced2d60af61ec9803e553471c88"),
            dex_pool                  : 0x1::option::none<0x2::object::ID>(),
            price_factor_weekday      : 0,
            price_factor_weekend      : 0,
            weekday_start_time        : 0,
            weekday_duration          : 0,
            price_deviation_ratio     : 0,
            price_check               : false,
            coin_whitelist            : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
            user_whitelist            : 0x2::table::new<0x2::object::ID, bool>(arg0),
            balances                  : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<State>(v1);
    }

    entry fun init_upgrade_cap_id(arg0: &mut State, arg1: &0x2::package::UpgradeCap, arg2: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.upgrade_cap_id), 110);
        let v0 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v0) == package_address(arg0), 103);
        arg0.upgrade_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    fun merge_coin_into_balances<T0>(arg0: &mut State, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            let v0 = &mut arg0.balances;
            0x2::coin::put<T0>(get_balance_mut<T0>(v0), arg1);
        };
    }

    entry fun migrate(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(arg0.version < 1, 100);
        arg0.version = 1;
    }

    public fun package_address(arg0: &State) : address {
        let v0 = 0x1::type_name::get_with_original_ids<State>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    fun price_adjust(arg0: &State, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (in_weekday(arg0, arg2)) {
            arg1 * (arg0.price_factor_weekday + 10000) / 10000
        } else {
            arg1 * (arg0.price_factor_weekend + 10000) / 10000
        }
    }

    entry fun set_coin_holder(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.coin_holder = arg1;
        let v0 = SetCoinHolder{
            old_coin_holder : arg0.coin_holder,
            new_coin_holder : arg1,
        };
        0x2::event::emit<SetCoinHolder>(v0);
    }

    entry fun set_coin_whitelist<T0>(arg0: &mut State, arg1: bool, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.coin_whitelist, v0)) {
            if (!arg1) {
                0x2::table::remove<0x1::type_name::TypeName, u8>(&mut arg0.coin_whitelist, v0);
            };
        } else if (arg1) {
            0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.coin_whitelist, v0, arg2);
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
            };
        };
        let v1 = SetCoinWhitelist{
            coin     : v0,
            decimal  : arg2,
            accepted : arg1,
        };
        0x2::event::emit<SetCoinWhitelist>(v1);
    }

    entry fun set_dex_pool(arg0: &mut State, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.dex_pool = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = SetDexPool{new_dex_pool: arg1};
        0x2::event::emit<SetDexPool>(v0);
    }

    entry fun set_operator(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.operator = arg1;
        let v0 = SetOperator{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<SetOperator>(v0);
    }

    entry fun set_price_check(arg0: &mut State, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.price_check = arg1;
        let v0 = SetPriceCheck{check: arg1};
        0x2::event::emit<SetPriceCheck>(v0);
    }

    entry fun set_price_deviation_ratio(arg0: &mut State, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.price_deviation_ratio = arg1;
        let v0 = SetPriceDeviationRatio{
            old_price_deviation_ratio : arg0.price_deviation_ratio,
            new_price_deviation_ratio : arg1,
        };
        0x2::event::emit<SetPriceDeviationRatio>(v0);
    }

    entry fun set_price_factor(arg0: &mut State, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        arg0.price_factor_weekday = arg1;
        arg0.price_factor_weekend = arg2;
        let v0 = SetPriceFactor{
            weekday : arg1,
            weekend : arg2,
        };
        0x2::event::emit<SetPriceFactor>(v0);
    }

    entry fun set_weekday_param(arg0: &mut State, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        arg0.weekday_start_time = arg1;
        arg0.weekday_duration = arg2;
        let v0 = SetWeekdayParam{
            weekday_start_time : arg1,
            weekday_duration   : arg2,
        };
        0x2::event::emit<SetWeekdayParam>(v0);
    }

    entry fun set_xaum<T0>(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        arg0.xaum = 0x1::option::some<0x1::type_name::TypeName>(v0);
        let v1 = SetXaum{xaum: v0};
        0x2::event::emit<SetXaum>(v1);
    }

    entry fun set_xaum_price_oracle_feed_id(arg0: &mut State, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.xaum_price_oracle_feed_id = 0x1::option::some<vector<u8>>(arg1);
        let v0 = SetPriceOracle{new_oracle_feed_id: arg1};
        0x2::event::emit<SetPriceOracle>(v0);
    }

    entry fun transfer_ownership(arg0: &mut State, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.upgrade_cap_id, &v0), 103);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg1);
        arg0.owner = arg1;
        let v1 = TransferOwnership{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<TransferOwnership>(v1);
    }

    entry fun update_user_whitelist(arg0: &mut State, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.user_whitelist, arg1)) {
            if (!arg2) {
                0x2::table::remove<0x2::object::ID, bool>(&mut arg0.user_whitelist, arg1);
            };
        } else if (arg2) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.user_whitelist, arg1, true);
        };
        let v0 = UpdateUserWhitelist{
            cap_id   : arg1,
            accepted : arg2,
        };
        0x2::event::emit<UpdateUserWhitelist>(v0);
    }

    entry fun withdraw<T0>(arg0: &mut State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = &mut arg0.balances;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(get_balance_mut<T0>(v0), arg1, arg2), arg0.coin_holder);
    }

    entry fun withdraw_to_state<T0>(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg1);
        let v0 = &mut arg0.balances;
        let v1 = get_balance_mut<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, 0x2::balance::value<T0>(v1), arg1), 0x2::object::uid_to_address(&arg0.id));
    }

    // decompiled from Move bytecode v6
}

