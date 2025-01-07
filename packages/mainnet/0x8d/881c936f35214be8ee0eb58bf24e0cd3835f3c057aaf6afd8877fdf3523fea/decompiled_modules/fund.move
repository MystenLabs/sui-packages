module 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund {
    struct Take_1_Liquidity_For_1_Liquidity_Request<phantom T0, phantom T1> {
        fund: 0x2::object::ID,
        take_amount: u64,
        put_amount: u64,
    }

    struct Take_1_Liquidity_For_2_Liquidity_Request<phantom T0, phantom T1, phantom T2> {
        fund: 0x2::object::ID,
        take_amount: u64,
        put_amount1: u64,
        put_amount2: u64,
    }

    struct Take_1_Liquidity_For_1_NonLiquidity_Request<phantom T0, phantom T1> {
        fund: 0x2::object::ID,
        take_amount: u64,
        put_amount: u64,
    }

    struct Take_2_Liquidity_For_1_NonLiquidity_Request<phantom T0, phantom T1, phantom T2> {
        fund: 0x2::object::ID,
        take_amount1: u64,
        take_amount2: u64,
        put_amount: u64,
    }

    struct Take_1_NonLiquidity_For_2_Liquidity_Request<phantom T0, phantom T1, phantom T2> {
        fund: 0x2::object::ID,
        take_amount: u64,
        put_amount1: u64,
        put_amount2: u64,
    }

    struct SettleRequest {
        fund: 0x2::object::ID,
        settler: address,
        is_finished: bool,
    }

    struct InvestRecord has store {
        asset_types: vector<0x1::type_name::TypeName>,
        assets: 0x2::bag::Bag,
    }

    struct TimeInfo has store {
        start_time: u64,
        invest_duration: u64,
        end_time: u64,
    }

    struct Fund<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        fund_img: 0x1::string::String,
        trader: 0x2::object::ID,
        trader_fee: u64,
        asset: InvestRecord,
        base: u64,
        time: TimeInfo,
        is_arena: bool,
        limit_amount: u64,
        is_settle: bool,
        share_amount: u64,
        after_amount: u64,
        expected_roi: u64,
    }

    struct SettleResult has copy, drop {
        fund: 0x2::object::ID,
        trader: 0x2::object::ID,
        is_matched_roi: bool,
    }

    struct CreatedFund has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        fund_img: 0x1::string::String,
        trader: 0x2::object::ID,
        trader_fee: u64,
        start_time: u64,
        invest_duration: u64,
        end_time: u64,
        limit_amount: u64,
        expected_roi: u64,
    }

    struct Deinvested has copy, drop {
        remain_share: 0x1::option::Option<0x2::object::ID>,
        fund_id: 0x2::object::ID,
        investor: address,
        withdraw_invest_amount: u64,
    }

    struct Settled has copy, drop {
        fund: 0x2::object::ID,
        settler: address,
        is_finished: bool,
    }

    struct TraderClaimed<phantom T0> has copy, drop {
        trader: 0x2::object::ID,
        receiver: address,
        amount: u64,
    }

    struct Claimed<phantom T0> has copy, drop {
        receiver: address,
        amount: u64,
    }

    public fun after_amount<T0>(arg0: &Fund<T0>) : u64 {
        arg0.after_amount
    }

    fun assert_if_base_over_limit<T0>(arg0: &Fund<T0>, arg1: u64) {
        assert!(arg0.limit_amount >= arg1, 18);
    }

    fun assert_if_fund_has_nonbasic_asset<T0>(arg0: &Fund<T0>) {
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.asset.asset_types) == 1, 10);
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        assert!(0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.asset.asset_types, 0) == &v0, 11);
    }

    fun assert_if_in_end_time<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.end_time < 0x2::clock::timestamp_ms(arg1), 21);
    }

    fun assert_if_init_value_not_enough<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: u64, arg2: &0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(arg2) >= arg1 * 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::trader_init_percentage(arg0) / 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::base_percentage(arg0), 16);
    }

    fun assert_if_init_value_over_limit<T0>(arg0: u64, arg1: &0x2::coin::Coin<T0>) {
        assert!(arg0 >= 0x2::coin::value<T0>(arg1), 17);
    }

    fun assert_if_is_settled<T0>(arg0: &Fund<T0>) {
        assert!(!arg0.is_settle, 20);
    }

    fun assert_if_nonliquidity_in_asset_bag<T0, T1>(arg0: &Fund<T1>) {
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, 0x1::type_name::get<T0>()), 6);
    }

    fun assert_if_not_arrived_invest_duration<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.start_time <= 0x2::clock::timestamp_ms(arg1), 14);
    }

    fun assert_if_not_finished(arg0: &SettleRequest) {
        assert!(arg0.is_finished, 9);
    }

    fun assert_if_not_inclued_in_asset_array<T0>(arg0: &Fund<T0>, arg1: 0x1::type_name::TypeName) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &arg1);
        assert!(v0, 15);
        v1
    }

    fun assert_if_not_settle<T0>(arg0: &Fund<T0>) {
        assert!(arg0.is_settle, 12);
    }

    fun assert_if_over_invest_duration<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.start_time + arg0.time.invest_duration >= 0x2::clock::timestamp_ms(arg1), 13);
    }

    fun assert_if_over_max_trader_fee(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: u64) {
        assert!(0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::max_trader_fee(arg0) >= arg1, 0);
    }

    fun assert_if_put_amount_is_zero(arg0: u64) {
        assert!(arg0 != 0, 4);
    }

    fun assert_if_put_liquidity_not_equal_to_put_amount(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 5);
    }

    fun assert_if_shares_empty(arg0: &vector<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>) {
        assert!(0x1::vector::length<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>(arg0) != 0, 22);
    }

    fun assert_if_take_action_not_available<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.time.start_time + arg0.time.invest_duration, 19);
    }

    fun assert_if_take_amount_not_enough<T0, T1>(arg0: &Fund<T1>, arg1: u64) {
        assert!(0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>())) >= arg1, 2);
    }

    fun assert_if_take_liquidity_not_in_fund<T0, T1>(arg0: &Fund<T1>) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), 1);
    }

    fun assert_if_take_nonliquidity_not_in_fund<T0, T1>(arg0: &Fund<T1>) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, 0x1::type_name::get<T0>()), 3);
    }

    fun assert_if_time_setting_wrong(arg0: u64, arg1: u64) {
        assert!(arg1 > arg0, 7);
    }

    fun assert_if_trader_not_matched<T0>(arg0: &Fund<T0>, arg1: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader) {
        assert!(0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::id(arg1) == arg0.trader, 8);
    }

    public fun trader<T0>(arg0: &Fund<T0>) : 0x2::object::ID {
        arg0.trader
    }

    public fun base<T0>(arg0: &Fund<T0>) : u64 {
        arg0.base
    }

    public fun check_and_clean<T0, T1>(arg0: &mut Fund<T0>) {
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        if (0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.asset.assets, v0)) <= 100) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_inclued_in_asset_array<T0>(arg0, v0));
        };
    }

    public fun claim<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_not_settle<T0>(arg1);
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::burn<T0>(arg0, 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::create_burn_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.time.end_time), arg2);
        if (arg1.after_amount < arg1.base) {
            let v1 = arg1.after_amount * 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::invest_amount(&arg2) / arg1.share_amount;
            let v2 = Claimed<T0>{
                receiver : 0x2::tx_context::sender(arg3),
                amount   : v1,
            };
            0x2::event::emit<Claimed<T0>>(v2);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v1), arg3)
        } else if (arg1.after_amount - arg1.base >= 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::min_rewards(arg0)) {
            let v3 = (arg1.after_amount - (arg1.after_amount - arg1.base) * 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::platform_fee(arg0) / 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::base_percentage(arg0) - (arg1.after_amount - arg1.base) * arg1.trader_fee / 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::base_percentage(arg0)) * 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::invest_amount(&arg2) / arg1.share_amount;
            let v4 = Claimed<T0>{
                receiver : 0x2::tx_context::sender(arg3),
                amount   : v3,
            };
            0x2::event::emit<Claimed<T0>>(v4);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v3), arg3)
        } else {
            let v5 = arg1.base * 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::invest_amount(&arg2) / arg1.share_amount;
            let v6 = Claimed<T0>{
                receiver : 0x2::tx_context::sender(arg3),
                amount   : v5,
            };
            0x2::event::emit<Claimed<T0>>(v6);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v5), arg3)
        }
    }

    public fun create<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x2::coin::Coin<T0>, arg13: &mut 0x2::tx_context::TxContext) : (Fund<T0>, 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::MintRequest<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg12);
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_over_max_trader_fee(arg0, arg5);
        assert_if_init_value_over_limit<T0>(arg10, &arg12);
        assert_if_init_value_not_enough<T0>(arg0, arg10, &arg12);
        assert_if_time_setting_wrong(arg7, arg9);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v2);
        let v3 = 0x2::bag::new(arg13);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3, v2, 0x2::coin::into_balance<T0>(arg12));
        let v4 = InvestRecord{
            asset_types : v1,
            assets      : v3,
        };
        let v5 = TimeInfo{
            start_time      : arg7,
            invest_duration : arg8,
            end_time        : arg9,
        };
        let v6 = Fund<T0>{
            id           : 0x2::object::new(arg13),
            name         : arg1,
            description  : arg2,
            fund_img     : arg3,
            trader       : 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::id(arg4),
            trader_fee   : arg5,
            asset        : v4,
            base         : v0,
            time         : v5,
            is_arena     : arg6,
            limit_amount : arg10,
            is_settle    : false,
            share_amount : 0,
            after_amount : 0,
            expected_roi : arg11,
        };
        if (!v6.is_arena) {
            let v7 = CreatedFund{
                id              : *0x2::object::uid_as_inner(&v6.id),
                name            : arg1,
                description     : arg2,
                fund_img        : arg3,
                trader          : 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::id(arg4),
                trader_fee      : arg5,
                start_time      : arg7,
                invest_duration : arg8,
                end_time        : arg9,
                limit_amount    : arg10,
                expected_roi    : arg11,
            };
            0x2::event::emit<CreatedFund>(v7);
        };
        let v8 = 0x1::string::utf8(b"Common");
        if (v6.is_arena) {
            v8 = 0x1::string::utf8(b"Arena");
        };
        (v6, 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::create_mint_request<T0>(arg0, *0x2::object::uid_as_inner(&v6.id), v6.trader, v8, v0, v6.time.end_time))
    }

    public fun create_settle_request<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: bool, arg3: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare, arg4: &0x2::tx_context::TxContext) : SettleRequest {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        SettleRequest{
            fund        : *0x2::object::uid_as_inner(&arg1.id),
            settler     : 0x2::tx_context::sender(arg4),
            is_finished : arg2,
        }
    }

    public fun deinvest<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: vector<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_over_invest_duration<T0>(arg1, arg4);
        assert_if_not_arrived_invest_duration<T0>(arg1, arg4);
        assert_if_shares_empty(&arg2);
        arg1.base = arg1.base - arg3;
        let v0 = 0x1::vector::pop_back<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>(&mut arg2);
        arg1.share_amount = arg1.share_amount - arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>(&arg2)) {
            0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::join(&mut v0, 0x1::vector::pop_back<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>(&mut arg2));
            v1 = v1 + 1;
        };
        let v2 = 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::split(&mut v0, arg3, arg5);
        if (0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::invest_amount(&v0) == 0) {
            0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::burn<T0>(arg0, 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::create_burn_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.time.end_time), v0);
            let v3 = Deinvested{
                remain_share           : 0x1::option::none<0x2::object::ID>(),
                fund_id                : *0x2::object::uid_as_inner(&arg1.id),
                investor               : 0x2::tx_context::sender(arg5),
                withdraw_invest_amount : arg3,
            };
            0x2::event::emit<Deinvested>(v3);
        } else {
            let v4 = Deinvested{
                remain_share           : 0x1::option::some<0x2::object::ID>(0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::id(&v0)),
                fund_id                : *0x2::object::uid_as_inner(&arg1.id),
                investor               : 0x2::tx_context::sender(arg5),
                withdraw_invest_amount : arg3,
            };
            0x2::event::emit<Deinvested>(v4);
            0x2::transfer::public_transfer<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>(v0, 0x2::tx_context::sender(arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::invest_amount(&v2)), arg5), 0x2::tx_context::sender(arg5));
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::burn<T0>(arg0, 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::create_burn_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.time.end_time), v2);
        0x1::vector::destroy_empty<0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::FundShare>(arg2);
    }

    public fun description<T0>(arg0: &Fund<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun end_time<T0>(arg0: &Fund<T0>) : u64 {
        arg0.time.end_time
    }

    public fun expected_roi<T0>(arg0: &Fund<T0>) : u64 {
        arg0.expected_roi
    }

    public fun finish_settle_request(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut SettleRequest) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        arg1.is_finished = true;
    }

    public(friend) fun fund_id_of_1l_for_1l_req<T0, T1>(arg0: &Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) : 0x2::object::ID {
        arg0.fund
    }

    public(friend) fun fund_id_of_1l_for_1nl_req<T0, T1>(arg0: &Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) : 0x2::object::ID {
        arg0.fund
    }

    public(friend) fun fund_id_of_1l_for_2l_req<T0, T1, T2>(arg0: &Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) : 0x2::object::ID {
        arg0.fund
    }

    public(friend) fun fund_id_of_1nl_for_2l_req<T0, T1, T2>(arg0: &Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) : 0x2::object::ID {
        arg0.fund
    }

    public fun fund_img<T0>(arg0: &Fund<T0>) : 0x1::string::String {
        arg0.fund_img
    }

    public(friend) fun id<T0>(arg0: &mut Fund<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun invest<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) : 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::MintRequest<T0> {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_over_invest_duration<T0>(arg1, arg3);
        assert_if_not_arrived_invest_duration<T0>(arg1, arg3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        arg1.base = arg1.base + v0;
        assert_if_base_over_limit<T0>(arg1, 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>())) + v0);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), 0x2::coin::into_balance<T0>(arg2));
        let v1 = 0x1::string::utf8(b"Common");
        if (arg1.is_arena) {
            v1 = 0x1::string::utf8(b"Arena");
        };
        arg1.share_amount = arg1.share_amount + v0;
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::fund_share::create_mint_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.trader, v1, v0, arg1.time.end_time)
    }

    public fun invest_duration<T0>(arg0: &Fund<T0>) : u64 {
        arg0.time.invest_duration
    }

    public fun is_arena<T0>(arg0: &Fund<T0>) : bool {
        arg0.is_arena
    }

    public fun limit_amount<T0>(arg0: &Fund<T0>) : u64 {
        arg0.limit_amount
    }

    public fun name<T0>(arg0: &Fund<T0>) : 0x1::string::String {
        arg0.name
    }

    fun pay_platforem_fee<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg2), arg3), 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::platform(arg0));
    }

    fun put_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0: &mut Fund<T2>, arg1: Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg2: 0x2::balance::Balance<T1>) {
        let Take_1_Liquidity_For_1_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg1;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg2));
        let v3 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let (v4, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v3);
        if (v4) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v3), arg2);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v3);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v3, arg2);
        };
    }

    public fun put_1_liquidity_for_1_liquidity_by_all<T0, T1, T2>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg3: 0x2::balance::Balance<T1>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        put_1_liquidity_for_1_liquidity<T0, T1, T2>(arg1, arg2, arg3);
    }

    fun put_1_liquidity_for_1_nonliquidity<T0, T1: store, T2>(arg0: &mut Fund<T2>, arg1: Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>, arg2: T1) {
        let Take_1_Liquidity_For_1_NonLiquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg1;
        assert_if_put_amount_is_zero(v2);
        let v3 = 0x1::type_name::get<T1>();
        assert_if_nonliquidity_in_asset_bag<T1, T2>(arg0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v3);
        0x2::bag::add<0x1::type_name::TypeName, T1>(&mut arg0.asset.assets, v3, arg2);
    }

    public fun put_1_liquidity_for_1_nonliquidity_by_all<T0, T1: store, T2>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>, arg3: T1) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        put_1_liquidity_for_1_nonliquidity<T0, T1, T2>(arg1, arg2, arg3);
    }

    fun put_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T2>) {
        let Take_1_Liquidity_For_2_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount1 : v2,
            put_amount2 : v3,
        } = arg1;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_amount_is_zero(v3);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg2));
        assert_if_put_liquidity_not_equal_to_put_amount(v3, 0x2::balance::value<T2>(&arg3));
        let v4 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let v5 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        let (v6, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v4);
        if (v6) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4), arg2);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v4);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4, arg2);
        };
        let (v8, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v5);
        if (v8) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5), arg3);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v5);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5, arg3);
        };
    }

    public fun put_1_liquidity_for_2_liquidity_by_all<T0, T1, T2, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        put_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg1, arg2, arg3, arg4);
    }

    fun put_1_nonliquidity_for_2_liquidity<T0: store, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T2>) {
        let Take_1_NonLiquidity_For_2_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount1 : v2,
            put_amount2 : _,
        } = arg1;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg2));
        let v4 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let v5 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        let (v6, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v4);
        if (v6) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4), arg2);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v4);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4, arg2);
        };
        let (v8, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v5);
        if (v8) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5), arg3);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v5);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5, arg3);
        };
    }

    public fun put_1_nonliquidity_for_2_liquidity_by_all<T0: store, T1, T2, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        put_1_nonliquidity_for_2_liquidity<T0, T1, T2, T3>(arg1, arg2, arg3, arg4);
    }

    public(friend) fun set_is_arena<T0>(arg0: &mut Fund<T0>, arg1: bool) {
        arg0.is_arena = arg1;
    }

    public fun settle<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: SettleRequest, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_not_finished(&arg2);
        assert_if_fund_has_nonbasic_asset<T0>(arg1);
        let v0 = *0x2::object::uid_as_inner(&arg1.id);
        let SettleRequest {
            fund        : _,
            settler     : _,
            is_finished : _,
        } = arg2;
        arg1.is_settle = true;
        let v4 = Settled{
            fund        : *0x2::object::uid_as_inner(&arg1.id),
            settler     : 0x2::tx_context::sender(arg3),
            is_finished : true,
        };
        0x2::event::emit<Settled>(v4);
        let v5 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        let v6 = arg1.base;
        let v7 = v6 * arg1.expected_roi / 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::base_percentage(arg0);
        arg1.after_amount = v5;
        if (v5 > v6) {
            if (arg1.base < 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::min_rewards(arg0)) {
                pay_platforem_fee<T0>(arg0, arg1, v5 - v6, arg3);
                if (v5 >= v7) {
                    let v9 = SettleResult{
                        fund           : v0,
                        trader         : trader<T0>(arg1),
                        is_matched_roi : true,
                    };
                    0x2::event::emit<SettleResult>(v9);
                } else {
                    let v10 = SettleResult{
                        fund           : v0,
                        trader         : trader<T0>(arg1),
                        is_matched_roi : false,
                    };
                    0x2::event::emit<SettleResult>(v10);
                };
                0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
            } else {
                let v11 = v5 - v6;
                let v12 = v11 * 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::platform_fee(arg0) / 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::base_percentage(arg0);
                let v13 = 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), (v11 - v12) * 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::settle_percentage(arg0) / 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::base_percentage(arg0));
                pay_platforem_fee<T0>(arg0, arg1, v12, arg3);
                let v14 = SettleResult{
                    fund           : v0,
                    trader         : trader<T0>(arg1),
                    is_matched_roi : false,
                };
                0x2::event::emit<SettleResult>(v14);
                0x2::coin::from_balance<T0>(v13, arg3)
            }
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        }
    }

    public fun start_time<T0>(arg0: &Fund<T0>) : u64 {
        arg0.time.start_time
    }

    public(friend) fun supported_defi_confirm_1l_for_1l<T0, T1>(arg0: &mut Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public(friend) fun supported_defi_confirm_1l_for_1nl<T0, T1: store>(arg0: &mut Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public(friend) fun supported_defi_confirm_1l_for_2l<T0, T1, T2>(arg0: &mut Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg1: u64, arg2: u64) {
        arg0.put_amount1 = arg1;
        arg0.put_amount2 = arg2;
    }

    public(friend) fun supported_defi_confirm_1nl_for_2l<T0: store, T1, T2>(arg0: &mut Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg1: u64, arg2: u64) {
        arg0.put_amount1 = arg1;
        arg0.put_amount2 = arg2;
    }

    public(friend) fun supported_defi_confirm_2l_for_1nl<T0, T1, T2>(arg0: &mut Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    fun take_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0: &mut Fund<T2>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) {
        assert_if_take_action_not_available<T2>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T2>(arg0);
        assert_if_take_amount_not_enough<T0, T2>(arg0, arg1);
        assert_if_is_settled<T2>(arg0);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v1 = 0x2::balance::value<T0>(v0);
        let v2 = 0x2::balance::split<T0>(v0, arg1);
        let v3 = id<T2>(arg0);
        let v4 = Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>{
            fund        : *0x2::object::uid_as_inner(v3),
            take_amount : 0x2::balance::value<T0>(&v2),
            put_amount  : 0,
        };
        if (arg1 == v1) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_inclued_in_asset_array<T2>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v2, v4)
    }

    public fun take_1_liquidity_for_1_liquidity_by_trader<T0, T1, T2>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T2>(arg1, arg2);
        take_1_liquidity_for_1_liquidity<T0, T1, T2>(arg1, arg3, arg4)
    }

    public fun take_1_liquidity_for_1_liquidity_over_end_time<T0, T1, T2>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_in_end_time<T2>(arg1, arg3);
        take_1_liquidity_for_1_liquidity<T0, T1, T2>(arg1, arg2, arg3)
    }

    fun take_1_liquidity_for_1_nonliquidity<T0, T1: store, T2>(arg0: &mut Fund<T2>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) {
        assert_if_take_action_not_available<T2>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T2>(arg0);
        assert_if_take_amount_not_enough<T0, T2>(arg0, arg1);
        assert_if_is_settled<T2>(arg0);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v1 = 0x2::balance::value<T0>(v0);
        let v2 = 0x2::balance::split<T0>(v0, arg1);
        let v3 = id<T2>(arg0);
        let v4 = Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>{
            fund        : *0x2::object::uid_as_inner(v3),
            take_amount : 0x2::balance::value<T0>(&v2),
            put_amount  : 0,
        };
        if (arg1 == v1) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_inclued_in_asset_array<T2>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v2, v4)
    }

    public fun take_1_liquidity_for_1_nonliquidity_by_trader<T0, T1: store, T2>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T2>(arg1, arg2);
        take_1_liquidity_for_1_nonliquidity<T0, T1, T2>(arg1, arg3, arg4)
    }

    public fun take_1_liquidity_for_1_nonliquidity_over_end_time<T0, T1: store, T2>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_in_end_time<T2>(arg1, arg3);
        take_1_liquidity_for_1_nonliquidity<T0, T1, T2>(arg1, arg2, arg3)
    }

    fun take_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg0);
        assert_if_take_amount_not_enough<T0, T3>(arg0, arg1);
        assert_if_is_settled<T3>(arg0);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v1 = 0x2::balance::value<T0>(v0);
        let v2 = 0x2::balance::split<T0>(v0, arg1);
        let v3 = id<T3>(arg0);
        let v4 = Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>{
            fund        : *0x2::object::uid_as_inner(v3),
            take_amount : 0x2::balance::value<T0>(&v2),
            put_amount1 : 0,
            put_amount2 : 0,
        };
        if (arg1 == v1) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_inclued_in_asset_array<T3>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v2, v4)
    }

    public fun take_1_liquidity_for_2_liquidity_by_trader<T0, T1, T2, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T3>(arg1, arg2);
        take_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg1, arg3, arg4)
    }

    public fun take_1_liquidity_for_2_liquidity_over_end_time<T0, T1, T2, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_in_end_time<T3>(arg1, arg3);
        take_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg1, arg2, arg3)
    }

    fun take_1_nonliquidity_for_2_liquidity<T0: store, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0x2::clock::Clock) : (T0, Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg1);
        assert_if_take_nonliquidity_not_in_fund<T0, T3>(arg0);
        assert_if_is_settled<T3>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, T0>(&mut arg0.asset.assets, v0);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_inclued_in_asset_array<T3>(arg0, v0));
        let v2 = Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>{
            fund        : *0x2::object::uid_as_inner(id<T3>(arg0)),
            take_amount : 1,
            put_amount1 : 0,
            put_amount2 : 0,
        };
        (v1, v2)
    }

    public fun take_1_nonliquidity_for_2_liquidity_by_trader<T0: store, T1, T2, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader, arg3: &0x2::clock::Clock) : (T0, Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T3>(arg1, arg2);
        take_1_nonliquidity_for_2_liquidity<T0, T1, T2, T3>(arg1, arg3)
    }

    public fun take_1_nonliquidity_for_2_liquidity_over_end_time<T0: store, T1, T2, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: &0x2::clock::Clock) : (T0, Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_in_end_time<T3>(arg1, arg2);
        take_1_nonliquidity_for_2_liquidity<T0, T1, T2, T3>(arg1, arg2)
    }

    fun take_2_liquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg3);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg0);
        assert_if_take_liquidity_not_in_fund<T1, T3>(arg0);
        assert_if_take_amount_not_enough<T0, T3>(arg0, arg1);
        assert_if_take_amount_not_enough<T1, T3>(arg0, arg2);
        assert_if_is_settled<T3>(arg0);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v1 = 0x2::balance::value<T0>(v0);
        let v2 = 0x2::balance::split<T0>(v0, arg1);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T1>>());
        let v4 = 0x2::balance::value<T1>(v3);
        let v5 = 0x2::balance::split<T1>(v3, arg2);
        let v6 = id<T3>(arg0);
        let v7 = Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>{
            fund         : *0x2::object::uid_as_inner(v6),
            take_amount1 : 0x2::balance::value<T0>(&v2),
            take_amount2 : 0x2::balance::value<T1>(&v5),
            put_amount   : 0,
        };
        if (arg1 == v1) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_inclued_in_asset_array<T3>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        if (arg2 == v4) {
            let v8 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
            let (_, v10) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v8);
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v10);
        };
        (v2, v5, v7)
    }

    public fun take_2_liquidity_for_1_nonliquidity_by_trader<T0, T1, T2: store, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T3>(arg1, arg2);
        take_2_liquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg1, arg3, arg4, arg5)
    }

    public fun take_2_liquidity_for_1_nonliquidity_over_end_time<T0, T1, T2: store, T3>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::assert_if_version_not_matched(arg0, 1);
        assert_if_in_end_time<T3>(arg1, arg4);
        take_2_liquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg1, arg2, arg3, arg4)
    }

    public fun to_share_object<T0>(arg0: Fund<T0>) {
        0x2::transfer::share_object<Fund<T0>>(arg0);
    }

    public fun trader_claim<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_if_trader_not_matched<T0>(arg1, arg2);
        assert_if_not_settle<T0>(arg1);
        if (arg1.after_amount >= arg1.base) {
            if (arg1.after_amount - arg1.base >= 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::min_rewards(arg0)) {
                let v1 = (arg1.after_amount - arg1.base) * arg1.trader_fee / 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::base_percentage(arg0);
                let v2 = TraderClaimed<T0>{
                    trader   : 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::id(arg2),
                    receiver : 0x2::tx_context::sender(arg3),
                    amount   : v1,
                };
                0x2::event::emit<TraderClaimed<T0>>(v2);
                0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v1), arg3)
            } else {
                let v3 = TraderClaimed<T0>{
                    trader   : 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::id(arg2),
                    receiver : 0x2::tx_context::sender(arg3),
                    amount   : 0,
                };
                0x2::event::emit<TraderClaimed<T0>>(v3);
                0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
            }
        } else {
            let v4 = TraderClaimed<T0>{
                trader   : 0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::id(arg2),
                receiver : 0x2::tx_context::sender(arg3),
                amount   : 0,
            };
            0x2::event::emit<TraderClaimed<T0>>(v4);
            0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        }
    }

    public fun trader_fee<T0>(arg0: &Fund<T0>) : u64 {
        arg0.trader_fee
    }

    public(friend) fun update_description<T0>(arg0: &mut Fund<T0>, arg1: 0x1::string::String, arg2: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::trader::Trader) {
        assert_if_trader_not_matched<T0>(arg0, arg2);
        arg0.description = arg1;
    }

    public(friend) fun update_time<T0>(arg0: &mut Fund<T0>, arg1: u64, arg2: u64, arg3: u64) {
        arg0.time.start_time = arg1;
        arg0.time.invest_duration = arg2;
        arg0.time.end_time = arg3;
    }

    public entry fun withdraw<T0>(arg0: &0x8d881c936f35214be8ee0eb58bf24e0cd3835f3c057aaf6afd8877fdf3523fea::config::AdminCap, arg1: &mut Fund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

