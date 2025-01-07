module 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund {
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

    struct Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<phantom T0, phantom T1, phantom T2> {
        fund: 0x2::object::ID,
        take_amount1: u64,
        take_amount2: u64,
        put_amount: u64,
    }

    struct Take_1_NonLiquidity_For_1_Liquidity_Request<phantom T0, phantom T1> {
        fund: 0x2::object::ID,
        take_amount: u64,
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

    struct ShareInfo has store {
        investor: 0x2::table::Table<address, u64>,
        total_share: u64,
    }

    struct Fund<phantom T0> has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        trader: 0x2::object::ID,
        trader_fee: u64,
        asset: InvestRecord,
        base: u64,
        time: TimeInfo,
        is_arena: bool,
        is_settle: bool,
        share_info: ShareInfo,
        after_amount: u64,
    }

    struct CreatedFund has copy, drop {
        id: 0x2::object::ID,
        description: 0x1::string::String,
        trader: 0x2::object::ID,
        trader_fee: u64,
        trader_stake: u64,
        start_time: u64,
        invest_duration: u64,
        end_time: u64,
        is_arena: bool,
    }

    struct Settled has copy, drop {
        fund: 0x2::object::ID,
        is_finished: bool,
    }

    struct Invested<phantom T0> has copy, drop {
        investor: address,
        fund: 0x2::object::ID,
        amount: u64,
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

    fun assert_if_fund_has_nonbasic_asset<T0>(arg0: &Fund<T0>) {
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.asset.asset_types) == 1, 13);
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        assert!(0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.asset.asset_types, 0) == &v0, 14);
    }

    fun assert_if_nonliquidity_in_asset_bag<T0, T1>(arg0: &Fund<T1>) {
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, 0x1::type_name::get<T0>()), 6);
    }

    fun assert_if_not_arrived_end_time<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.end_time <= 0x2::clock::timestamp_ms(arg1), 11);
    }

    fun assert_if_not_arrived_invest_duration<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.start_time <= 0x2::clock::timestamp_ms(arg1), 17);
    }

    fun assert_if_not_finished(arg0: &SettleRequest) {
        assert!(arg0.is_finished, 12);
    }

    fun assert_if_not_settle<T0>(arg0: &Fund<T0>) {
        assert!(arg0.is_settle, 15);
    }

    fun assert_if_over_invest_duration<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.start_time + arg0.time.invest_duration >= 0x2::clock::timestamp_ms(arg1), 16);
    }

    fun assert_if_over_max_trader_fee(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: u64) {
        assert!(0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::max_trader_fee(arg0) >= arg1, 0);
    }

    fun assert_if_put_amount_is_zero(arg0: u64) {
        assert!(arg0 != 0, 4);
    }

    fun assert_if_put_liquidity_not_equal_to_put_amount(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 5);
    }

    fun assert_if_settler_not_fund_investor<T0>(arg0: &Fund<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u64>(&arg0.share_info.investor, 0x2::tx_context::sender(arg1)), 10);
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

    fun assert_if_time_setting_wrong(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg2 > arg0, 7);
        assert!(arg1 >= 3600000, 8);
    }

    fun assert_if_trader_not_matched<T0>(arg0: &Fund<T0>, arg1: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader) {
        assert!(0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::id(arg1) == arg0.trader, 9);
    }

    public fun trader<T0>(arg0: &Fund<T0>) : 0x2::object::ID {
        arg0.trader
    }

    public fun base<T0>(arg0: &Fund<T0>) : u64 {
        arg0.base
    }

    public fun claim<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::FundShare, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_not_settle<T0>(arg1);
        let v0 = 0x2::table::remove<address, u64>(&mut arg1.share_info.investor, 0x2::tx_context::sender(arg3));
        if (v0 != 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::invest_amount(&arg2)) {
            0x2::table::add<address, u64>(&mut arg1.share_info.investor, 0x2::tx_context::sender(arg3), v0 - 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::invest_amount(&arg2));
        };
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::burn<T0>(arg0, 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::create_burn_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.time.end_time), arg2);
        if (arg1.after_amount < arg1.base) {
            let v2 = arg1.after_amount * 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::invest_amount(&arg2) / arg1.share_info.total_share;
            let v3 = Claimed<T0>{
                receiver : 0x2::tx_context::sender(arg3),
                amount   : v2,
            };
            0x2::event::emit<Claimed<T0>>(v3);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v2), arg3)
        } else if (arg1.after_amount - arg1.base >= 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::min_rewards(arg0)) {
            let v4 = (arg1.after_amount - (arg1.after_amount - arg1.base) * 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::platform_fee(arg0) / 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::base_percentage(arg0) - (arg1.after_amount - arg1.base) * arg1.trader_fee / 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::base_percentage(arg0)) * 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::invest_amount(&arg2) / arg1.share_info.total_share;
            let v5 = Claimed<T0>{
                receiver : 0x2::tx_context::sender(arg3),
                amount   : v4,
            };
            0x2::event::emit<Claimed<T0>>(v5);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v4), arg3)
        } else {
            let v6 = arg1.base * 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::invest_amount(&arg2) / arg1.share_info.total_share;
            let v7 = Claimed<T0>{
                receiver : 0x2::tx_context::sender(arg3),
                amount   : v6,
            };
            0x2::event::emit<Claimed<T0>>(v7);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v6), arg3)
        }
    }

    public fun create<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: 0x1::string::String, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) : (Fund<T0>, 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::MintRequest<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg8);
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_over_max_trader_fee(arg0, arg3);
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_less_than_min_fund_base(arg0, v0);
        assert_if_time_setting_wrong(arg5, arg6, arg7);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v2);
        let v3 = 0x2::bag::new(arg9);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3, v2, 0x2::coin::into_balance<T0>(arg8));
        let v4 = InvestRecord{
            asset_types : v1,
            assets      : v3,
        };
        let v5 = TimeInfo{
            start_time      : arg5,
            invest_duration : arg6,
            end_time        : arg7,
        };
        let v6 = ShareInfo{
            investor    : 0x2::table::new<address, u64>(arg9),
            total_share : 0,
        };
        let v7 = Fund<T0>{
            id           : 0x2::object::new(arg9),
            description  : arg1,
            trader       : 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::id(arg2),
            trader_fee   : arg3,
            asset        : v4,
            base         : v0,
            time         : v5,
            is_arena     : arg4,
            is_settle    : false,
            share_info   : v6,
            after_amount : 0,
        };
        let v8 = CreatedFund{
            id              : *0x2::object::uid_as_inner(&v7.id),
            description     : arg1,
            trader          : 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::id(arg2),
            trader_fee      : arg3,
            trader_stake    : v0,
            start_time      : arg5,
            invest_duration : arg6,
            end_time        : arg7,
            is_arena        : arg4,
        };
        0x2::event::emit<CreatedFund>(v8);
        let v9 = Invested<T0>{
            investor : 0x2::tx_context::sender(arg9),
            fund     : *0x2::object::uid_as_inner(&v7.id),
            amount   : v0,
        };
        0x2::event::emit<Invested<T0>>(v9);
        let v10 = 0x1::string::utf8(b"Common");
        if (v7.is_arena) {
            v10 = 0x1::string::utf8(b"Arena");
        };
        (v7, 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::create_mint_request<T0>(arg0, *0x2::object::uid_as_inner(&v7.id), v7.trader, v10, v0, v7.time.end_time))
    }

    public fun create_settle_request<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : SettleRequest {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_not_arrived_end_time<T0>(arg1, arg3);
        assert_if_settler_not_fund_investor<T0>(arg1, arg4);
        SettleRequest{
            fund        : *0x2::object::uid_as_inner(&arg1.id),
            settler     : 0x2::tx_context::sender(arg4),
            is_finished : arg2,
        }
    }

    public fun deinvest<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: vector<0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::FundShare>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_over_invest_duration<T0>(arg1, arg4);
        assert_if_not_arrived_invest_duration<T0>(arg1, arg4);
        let v0 = 0x1::vector::pop_back<0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::FundShare>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::FundShare>(&arg2) - 1) {
            0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::join(&mut v0, 0x1::vector::pop_back<0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::FundShare>(&mut arg2));
            v1 = v1 + 1;
        };
        let v2 = 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::split(&mut v0, arg3, arg5);
        if (0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::invest_amount(&v0) == 0) {
            0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::burn<T0>(arg0, 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::create_burn_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.time.end_time), v0);
        } else {
            0x2::transfer::public_transfer<0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::FundShare>(v0, 0x2::tx_context::sender(arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::invest_amount(&v2)), arg5), 0x2::tx_context::sender(arg5));
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::burn<T0>(arg0, 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::create_burn_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.time.end_time), v2);
        0x1::vector::destroy_empty<0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::FundShare>(arg2);
    }

    public fun description<T0>(arg0: &Fund<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun end_time<T0>(arg0: &Fund<T0>) : u64 {
        arg0.time.end_time
    }

    public(friend) fun id<T0>(arg0: &mut Fund<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun invest<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::MintRequest<T0> {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_over_invest_duration<T0>(arg1, arg3);
        assert_if_not_arrived_invest_duration<T0>(arg1, arg3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_base_over_max(arg0, 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>())) + v0);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), 0x2::coin::into_balance<T0>(arg2));
        let v1 = 0x1::string::utf8(b"Common");
        if (arg1.is_arena) {
            v1 = 0x1::string::utf8(b"Arena");
        };
        let v2 = Invested<T0>{
            investor : 0x2::tx_context::sender(arg4),
            fund     : *0x2::object::uid_as_inner(&arg1.id),
            amount   : v0,
        };
        0x2::event::emit<Invested<T0>>(v2);
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::fund_share::create_mint_request<T0>(arg0, *0x2::object::uid_as_inner(&arg1.id), arg1.trader, v1, v0, arg1.time.end_time)
    }

    public fun is_arena<T0>(arg0: &Fund<T0>) : bool {
        arg0.is_arena
    }

    fun pay_platforem_fee<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg2), arg3), 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::platform(arg0));
    }

    public fun put_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1: store, T2: store, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg3: T2) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request {
            fund         : _,
            take_amount1 : _,
            take_amount2 : _,
            put_amount   : v3,
        } = arg2;
        assert_if_put_amount_is_zero(v3);
        assert_if_nonliquidity_in_asset_bag<T2, T3>(arg1);
        0x2::bag::add<0x1::type_name::TypeName, T2>(&mut arg1.asset.assets, 0x1::type_name::get<T2>(), arg3);
    }

    public fun put_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg3: 0x2::balance::Balance<T1>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_For_1_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        let v3 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v3)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3, arg3);
        };
    }

    public fun put_1_liquidity_for_1_nonliquidity<T0, T1: store, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>, arg3: T1) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_For_1_NonLiquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_nonliquidity_in_asset_bag<T1, T2>(arg1);
        0x2::bag::add<0x1::type_name::TypeName, T1>(&mut arg1.asset.assets, 0x1::type_name::get<T1>(), arg3);
    }

    public fun put_1_liquidity_for_2_liqudity<T0, T1, T2, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_For_2_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount1 : v2,
            put_amount2 : v3,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_amount_is_zero(v3);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        assert_if_put_liquidity_not_equal_to_put_amount(v3, 0x2::balance::value<T2>(&arg4));
        let v4 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let v5 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v4)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4, arg3);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v5)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v5), arg4);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v5, arg4);
        };
    }

    public fun put_1_nonLiquidity_for_1_liquidity<T0: store, T1, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_NonLiquidity_For_1_Liquidity_Request<T0, T1>, arg3: 0x2::balance::Balance<T1>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_NonLiquidity_For_1_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        let v3 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v3)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3, arg3);
        };
    }

    public fun put_1_nonliquidity_for_2_liquidity<T0: store, T1, T2, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_NonLiquidity_For_2_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount1 : v2,
            put_amount2 : v3,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_amount_is_zero(v3);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        assert_if_put_liquidity_not_equal_to_put_amount(v3, 0x2::balance::value<T2>(&arg4));
        let v4 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let v5 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v4)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4, arg3);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v5)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v4), arg4);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v5, arg4);
        };
    }

    public(friend) fun set_is_arena<T0>(arg0: &mut Fund<T0>, arg1: bool) {
        arg0.is_arena = arg1;
    }

    public fun settle<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: SettleRequest, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_not_finished(&arg2);
        assert_if_fund_has_nonbasic_asset<T0>(arg1);
        let SettleRequest {
            fund        : _,
            settler     : _,
            is_finished : _,
        } = arg2;
        arg1.is_settle = true;
        let v3 = Settled{
            fund        : *0x2::object::uid_as_inner(&arg1.id),
            is_finished : true,
        };
        0x2::event::emit<Settled>(v3);
        let v4 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        let v5 = arg1.base;
        arg1.after_amount = v4;
        if (v4 > v5) {
            if (arg1.base < 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::min_rewards(arg0)) {
                pay_platforem_fee<T0>(arg0, arg1, v4 - v5, arg3);
                0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
            } else {
                let v7 = v4 - v5;
                let v8 = v7 * 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::platform_fee(arg0) / 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::base_percentage(arg0);
                let v9 = 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), (v7 - v8) * 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::settle_percentage(arg0) / 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::base_percentage(arg0));
                pay_platforem_fee<T0>(arg0, arg1, v8, arg3);
                0x2::coin::from_balance<T0>(v9, arg3)
            }
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        }
    }

    public fun settle_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1: store, T2: store, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg3: T2, arg4: SettleRequest, arg5: bool) : SettleRequest {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request {
            fund         : _,
            take_amount1 : _,
            take_amount2 : _,
            put_amount   : v3,
        } = arg2;
        assert_if_put_amount_is_zero(v3);
        assert_if_nonliquidity_in_asset_bag<T2, T3>(arg1);
        0x2::bag::add<0x1::type_name::TypeName, T2>(&mut arg1.asset.assets, 0x1::type_name::get<T2>(), arg3);
        arg4.is_finished = arg5;
        arg4
    }

    public fun settle_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: SettleRequest, arg5: bool) : SettleRequest {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_For_1_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        let v3 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v3)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3, arg3);
        };
        arg4.is_finished = arg5;
        arg4
    }

    public fun settle_1_liquidity_for_1_nonliquidity<T0, T1: store, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>, arg3: T1, arg4: SettleRequest, arg5: bool) : SettleRequest {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_For_1_NonLiquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_nonliquidity_in_asset_bag<T1, T2>(arg1);
        0x2::bag::add<0x1::type_name::TypeName, T1>(&mut arg1.asset.assets, 0x1::type_name::get<T1>(), arg3);
        arg4.is_finished = arg5;
        arg4
    }

    public fun settle_1_liquidity_for_2_liqudity<T0, T1, T2, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>, arg5: SettleRequest, arg6: bool) : SettleRequest {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_Liquidity_For_2_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount1 : v2,
            put_amount2 : v3,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_amount_is_zero(v3);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        assert_if_put_liquidity_not_equal_to_put_amount(v3, 0x2::balance::value<T2>(&arg4));
        let v4 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let v5 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v4)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4, arg3);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v5)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v5), arg4);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v5, arg4);
        };
        arg5.is_finished = arg6;
        arg5
    }

    public fun settle_1_nonLiquidity_for_1_liquidity<T0: store, T1, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: Take_1_NonLiquidity_For_1_Liquidity_Request<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: SettleRequest, arg5: bool) : SettleRequest {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_NonLiquidity_For_1_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount  : v2,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        let v3 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v3)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v3, arg3);
        };
        arg4.is_finished = arg5;
        arg4
    }

    public fun settle_1_nonliquidity_for_2_liquidity<T0: store, T1, T2, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>, arg5: SettleRequest, arg6: bool) : SettleRequest {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        let Take_1_NonLiquidity_For_2_Liquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount1 : v2,
            put_amount2 : v3,
        } = arg2;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_amount_is_zero(v3);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg3));
        assert_if_put_liquidity_not_equal_to_put_amount(v3, 0x2::balance::value<T2>(&arg4));
        let v4 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let v5 = 0x1::type_name::get<0x2::balance::Balance<T2>>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v4)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4), arg3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.asset.assets, v4, arg3);
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.asset.assets, v5)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v4), arg4);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.asset.assets, v5, arg4);
        };
        arg5.is_finished = arg6;
        arg5
    }

    public fun start_time<T0>(arg0: &Fund<T0>) : u64 {
        arg0.time.start_time
    }

    public(friend) fun supported_defi_confirm_1l_1nl_for_1nl<T0, T1: store, T2: store>(arg0: &mut Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg1: u64) {
        arg0.put_amount = arg1;
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

    public(friend) fun supported_defi_confirm_1nl_for_1l<T0: store, T1>(arg0: &mut Take_1_NonLiquidity_For_1_Liquidity_Request<T0, T1>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public(friend) fun supported_defi_confirm_1nl_for_2l<T0: store, T1, T2>(arg0: &mut Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg1: u64, arg2: u64) {
        arg0.put_amount1 = arg1;
        arg0.put_amount2 = arg2;
    }

    public fun take_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1: store, T2: store, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader, arg3: u64) : (0x2::balance::Balance<T0>, T1, Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T3>(arg1, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg1);
        assert_if_take_nonliquidity_not_in_fund<T1, T3>(arg1);
        assert_if_take_amount_not_enough<T0, T3>(arg1, arg3);
        let v0 = 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg3);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, T1>(&mut arg1.asset.assets, 0x1::type_name::get<T1>());
        let v2 = Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>{
            fund         : *0x2::object::uid_as_inner(id<T3>(arg1)),
            take_amount1 : 0x2::balance::value<T0>(&v0),
            take_amount2 : 1,
            put_amount   : 0,
        };
        (v0, v1, v2)
    }

    public fun take_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader, arg3: u64) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T2>(arg1, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T2>(arg1);
        assert_if_take_amount_not_enough<T0, T2>(arg1, arg3);
        let v0 = 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg3);
        let v1 = Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>{
            fund        : *0x2::object::uid_as_inner(id<T2>(arg1)),
            take_amount : 0x2::balance::value<T0>(&v0),
            put_amount  : 0,
        };
        (v0, v1)
    }

    public fun take_1_liquidity_for_1_nonliquidity<T0, T1: store, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader, arg3: u64) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T2>(arg1, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T2>(arg1);
        assert_if_take_amount_not_enough<T0, T2>(arg1, arg3);
        let v0 = 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg3);
        let v1 = Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>{
            fund        : *0x2::object::uid_as_inner(id<T2>(arg1)),
            take_amount : 0x2::balance::value<T0>(&v0),
            put_amount  : 0,
        };
        (v0, v1)
    }

    public fun take_1_liquidity_for_2_liqudity<T0, T1, T2, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader, arg3: u64) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T3>(arg1, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg1);
        assert_if_take_amount_not_enough<T0, T3>(arg1, arg3);
        let v0 = 0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg3);
        let v1 = Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>{
            fund        : *0x2::object::uid_as_inner(id<T3>(arg1)),
            take_amount : 0x2::balance::value<T0>(&v0),
            put_amount1 : 0,
            put_amount2 : 0,
        };
        (v0, v1)
    }

    public fun take_1_nonLiquidity_for_1_liquidity<T0: store, T1, T2>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T2>, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader) : (T0, Take_1_NonLiquidity_For_1_Liquidity_Request<T0, T1>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T2>(arg1, arg2);
        assert_if_take_nonliquidity_not_in_fund<T0, T2>(arg1);
        let v0 = 0x2::bag::remove<0x1::type_name::TypeName, T0>(&mut arg1.asset.assets, 0x1::type_name::get<T0>());
        let v1 = Take_1_NonLiquidity_For_1_Liquidity_Request<T0, T1>{
            fund        : *0x2::object::uid_as_inner(id<T2>(arg1)),
            take_amount : 1,
            put_amount  : 0,
        };
        (v0, v1)
    }

    public fun take_1_nonliquidity_for_2_liquidity<T0: store, T1, T2, T3>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T3>, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader) : (T0, Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::assert_if_version_not_matched(arg0, 1);
        assert_if_trader_not_matched<T3>(arg1, arg2);
        assert_if_take_nonliquidity_not_in_fund<T0, T3>(arg1);
        let v0 = 0x2::bag::remove<0x1::type_name::TypeName, T0>(&mut arg1.asset.assets, 0x1::type_name::get<T0>());
        let v1 = Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>{
            fund        : *0x2::object::uid_as_inner(id<T3>(arg1)),
            take_amount : 1,
            put_amount1 : 0,
            put_amount2 : 0,
        };
        (v0, v1)
    }

    public fun to_share_object<T0>(arg0: Fund<T0>) {
        0x2::transfer::share_object<Fund<T0>>(arg0);
    }

    public fun trader_claim<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::GlobalConfig, arg1: &mut Fund<T0>, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_if_trader_not_matched<T0>(arg1, arg2);
        assert_if_not_settle<T0>(arg1);
        if (arg1.after_amount >= arg1.base) {
            if (arg1.after_amount - arg1.base >= 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::min_rewards(arg0)) {
                let v1 = (arg1.after_amount - arg1.base) * arg1.trader_fee / 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::base_percentage(arg0);
                let v2 = TraderClaimed<T0>{
                    trader   : 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::id(arg2),
                    receiver : 0x2::tx_context::sender(arg3),
                    amount   : v1,
                };
                0x2::event::emit<TraderClaimed<T0>>(v2);
                0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v1), arg3)
            } else {
                let v3 = TraderClaimed<T0>{
                    trader   : 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::id(arg2),
                    receiver : 0x2::tx_context::sender(arg3),
                    amount   : 0,
                };
                0x2::event::emit<TraderClaimed<T0>>(v3);
                0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
            }
        } else {
            let v4 = TraderClaimed<T0>{
                trader   : 0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::id(arg2),
                receiver : 0x2::tx_context::sender(arg3),
                amount   : 0,
            };
            0x2::event::emit<TraderClaimed<T0>>(v4);
            0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        }
    }

    public(friend) fun update_description<T0>(arg0: &mut Fund<T0>, arg1: 0x1::string::String, arg2: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::trader::Trader) {
        assert_if_trader_not_matched<T0>(arg0, arg2);
        arg0.description = arg1;
    }

    public(friend) fun update_time<T0>(arg0: &mut Fund<T0>, arg1: u64, arg2: u64, arg3: u64) {
        arg0.time.start_time = arg1;
        arg0.time.invest_duration = arg2;
        arg0.time.end_time = arg3;
    }

    public entry fun withdraw<T0>(arg0: &0x51d8df3d3e88858bd420b2fa1f0504c6bab766835d6be0dc215cbaaf1401ec2e::config::AdminCap, arg1: &mut Fund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

