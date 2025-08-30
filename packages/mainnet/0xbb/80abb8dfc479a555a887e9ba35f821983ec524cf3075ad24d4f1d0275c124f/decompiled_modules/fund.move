module 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund {
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

    struct Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<phantom T0, phantom T1, phantom T2> {
        fund: 0x2::object::ID,
        take_amount: u64,
        put_amount1: u64,
        put_amount2: u64,
    }

    struct Take_1_Liquidity_For_Nothing_Request<phantom T0> {
        fund: 0x2::object::ID,
        take_amount: u64,
        is_finished: bool,
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

    struct ProtocalAccountRequest {
        protocol_idx: u8,
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
        trader: address,
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
        allow_list: 0x2::table::Table<address, bool>,
    }

    struct FundCap has key {
        id: 0x2::object::UID,
        fund_id: 0x2::object::ID,
    }

    struct TraderClaimedProof has copy, drop, store {
        dummy_field: bool,
    }

    struct SettleResult has copy, drop {
        fund: 0x2::object::ID,
        trader: address,
        is_matched_roi: bool,
        final_amount: u64,
    }

    struct CreatedFund has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        fund_img: 0x1::string::String,
        trader: address,
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
        fund: 0x2::object::ID,
        trader: address,
        receiver: address,
        amount: u64,
    }

    struct Claimed<phantom T0> has copy, drop {
        receiver: address,
        fund: 0x2::object::ID,
        shares: vector<0x2::object::ID>,
        amount: u64,
    }

    public fun add_allow_list<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: address) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T0>(arg0, arg2);
        assert_if_already_in_allow_list<T0>(arg0, arg3);
        0x2::table::add<address, bool>(&mut arg0.allow_list, arg3, true);
    }

    public fun after_amount<T0>(arg0: &Fund<T0>) : u64 {
        arg0.after_amount
    }

    fun assert_id_pool_is_empty<T0>(arg0: &0x1::option::Option<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>) {
        assert!(0x1::option::is_some<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>(arg0), 32);
    }

    fun assert_if_already_in_allow_list<T0>(arg0: &Fund<T0>, arg1: address) {
        assert!(!0x2::table::contains<address, bool>(&arg0.allow_list, arg1), 24);
    }

    fun assert_if_base_over_limit<T0>(arg0: &Fund<T0>, arg1: u64) {
        assert!(arg0.limit_amount >= arg1, 16);
    }

    fun assert_if_contain_voucher_share(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare) {
        assert!(0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::base_receiver(arg0) == 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::reward_receiver(arg0), 30);
    }

    fun assert_if_deinvest_init_share(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare) {
        assert!(!0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::is_init(arg0), 21);
    }

    fun assert_if_empty_voucher<T0>(arg0: &vector<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>) {
        assert!(0x1::vector::length<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>(arg0) != 0, 27);
    }

    public(friend) fun assert_if_fund_cap_and_fund_not_matched<T0>(arg0: &Fund<T0>, arg1: &FundCap) {
        assert!(*0x2::object::uid_as_inner(&arg0.id) == arg1.fund_id, 26);
    }

    fun assert_if_fund_has_nonbasic_asset<T0>(arg0: &Fund<T0>) {
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.asset.asset_types) == 1, 8);
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        assert!(0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.asset.asset_types, 0) == &v0, 9);
    }

    fun assert_if_fund_owner_and_voucher_sponsor_not_matched<T0>(arg0: &Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>) {
        let v0 = 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::request_sponsor_addr<T0>(arg1);
        assert!(arg0.trader == *0x1::option::borrow<address>(&v0), 31);
    }

    fun assert_if_fund_type_not_matched<T0>(arg0: &Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare) {
        assert!(*0x2::object::uid_as_inner(&arg0.id) == 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::fund_id(arg1), 22);
    }

    fun assert_if_in_end_time<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.end_time < 0x2::clock::timestamp_ms(arg1), 19);
    }

    fun assert_if_init_value_not_enough<T0>(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg1: u64, arg2: &0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(arg2) >= arg1 * 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::trader_init_percentage(arg0) / 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg0), 14);
    }

    fun assert_if_init_value_over_limit<T0>(arg0: u64, arg1: &0x2::coin::Coin<T0>) {
        assert!(arg0 >= 0x2::coin::value<T0>(arg1), 15);
    }

    fun assert_if_is_settled<T0>(arg0: &Fund<T0>) {
        assert!(!arg0.is_settle, 18);
    }

    fun assert_if_nonliquidity_in_asset_bag<T0, T1>(arg0: &Fund<T1>) {
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, 0x1::type_name::get<T0>()), 5);
    }

    fun assert_if_not_arrived_invest_duration<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.start_time <= 0x2::clock::timestamp_ms(arg1), 12);
    }

    fun assert_if_not_finished(arg0: &SettleRequest) {
        assert!(arg0.is_finished, 7);
    }

    fun assert_if_not_in_allow_list<T0>(arg0: &Fund<T0>, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.allow_list, arg1), 23);
    }

    fun assert_if_not_included_in_asset_array<T0>(arg0: &Fund<T0>, arg1: 0x1::type_name::TypeName) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &arg1);
        assert!(v0, 13);
        v1
    }

    fun assert_if_not_settle<T0>(arg0: &Fund<T0>) {
        assert!(arg0.is_settle, 10);
    }

    fun assert_if_nothing_back_not_finished<T0>(arg0: &Take_1_Liquidity_For_Nothing_Request<T0>) {
        assert!(arg0.is_finished, 34);
    }

    fun assert_if_over_invest_duration<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.time.start_time + arg0.time.invest_duration >= 0x2::clock::timestamp_ms(arg1), 11);
    }

    fun assert_if_over_max_trader_fee(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg1: u64) {
        assert!(0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::max_trader_fee(arg0) >= arg1, 0);
    }

    public(friend) fun assert_if_protocol_type_error(arg0: &ProtocalAccountRequest, arg1: u8) {
        assert!(arg0.protocol_idx == arg1, 35);
    }

    fun assert_if_provider_not_matched<T0>(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>, arg1: 0x2::object::ID) {
        let v0 = 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::base_provider<T0>(arg0);
        assert!(0x2::object::id_to_bytes(&v0) == 0x2::object::id_to_bytes(&arg1), 28);
    }

    fun assert_if_put_amount_is_zero(arg0: u64) {
        assert!(arg0 != 0, 3);
    }

    fun assert_if_put_liquidity_not_equal_to_put_amount(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 4);
    }

    fun assert_if_shares_empty(arg0: &vector<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>) {
        assert!(0x1::vector::length<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(arg0) != 0, 20);
    }

    fun assert_if_take_action_not_available<T0>(arg0: &Fund<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.time.start_time + arg0.time.invest_duration, 17);
    }

    fun assert_if_take_liquidity_not_in_fund<T0, T1>(arg0: &Fund<T1>) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), 1);
    }

    fun assert_if_take_nonliquidity_not_in_fund<T0, T1>(arg0: &Fund<T1>) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, 0x1::type_name::get<T0>()), 2);
    }

    fun assert_if_time_setting_wrong(arg0: u64, arg1: u64) {
        assert!(arg1 > arg0, 6);
    }

    fun assert_if_trader_fee_already_claimed<T0>(arg0: &Fund<T0>) {
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<TraderClaimedProof>()), 33);
    }

    fun assert_if_voucher_value_and_provided_not_matched<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) == arg1, 29);
    }

    public fun base<T0>(arg0: &Fund<T0>) : u64 {
        arg0.base
    }

    public fun check_and_clean<T0, T1>(arg0: &mut Fund<T0>) {
        let v0 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v0);
        if (v1) {
            if (0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.asset.assets, v0)) <= 100) {
                0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v2);
            };
        };
    }

    fun check_take_amount<T0, T1>(arg0: &Fund<T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        if (arg1 >= v0) {
            v0
        } else {
            arg1
        }
    }

    public fun claim<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: 0x1::option::Option<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>, arg3: vector<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_not_settle<T0>(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        let v2 = 0;
        while (0x1::vector::length<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(&arg3) != 0) {
            let v3 = 0x1::vector::pop_back<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(&mut arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::id(&v3));
            assert_if_fund_type_not_matched<T0>(arg0, &v3);
            if (0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::base_receiver(&v3) != 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::reward_receiver(&v3)) {
                assert_id_pool_is_empty<T0>(&arg2);
                v1 = v1 + 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::invest_amount(&v3);
            } else {
                v2 = v2 + 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::invest_amount(&v3);
            };
            0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::burn<T0>(0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::create_burn_request<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id)), v3);
        };
        0x1::vector::destroy_empty<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(arg3);
        if (arg0.after_amount < arg0.base) {
            let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
            if (v1 != 0) {
                0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::put_back<T0>(0x1::option::borrow_mut<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>(&mut arg2), 0x2::balance::split<T0>(v5, arg0.after_amount * v1 / arg0.share_amount));
            };
            let v6 = arg0.after_amount * v2 / arg0.share_amount;
            let v7 = Claimed<T0>{
                receiver : 0x2::tx_context::sender(arg4),
                fund     : *0x2::object::uid_as_inner(&arg0.id),
                shares   : v0,
                amount   : v6,
            };
            0x2::event::emit<Claimed<T0>>(v7);
            transfer_pool_if_is_some<T0>(arg2);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v5, v6), arg4)
        } else {
            let v8 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
            let v9 = arg0.after_amount - arg0.base;
            if (v1 == 0) {
                let v10 = (arg0.after_amount - 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v9, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::platform_fee_percentage(arg1), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1)) - 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v9, arg0.trader_fee, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1)) - 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v9, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::settle_percentage(arg1), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1))) * v2 / arg0.share_amount;
                let v11 = Claimed<T0>{
                    receiver : 0x2::tx_context::sender(arg4),
                    fund     : *0x2::object::uid_as_inner(&arg0.id),
                    shares   : v0,
                    amount   : v10,
                };
                0x2::event::emit<Claimed<T0>>(v11);
                transfer_pool_if_is_some<T0>(arg2);
                0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v8, v10), arg4)
            } else {
                let v12 = arg0.after_amount - 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v9, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::platform_fee_percentage(arg1), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1)) - 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v9, arg0.trader_fee, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1)) - 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v9, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::settle_percentage(arg1), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1));
                let v13 = 0;
                let v14 = v13;
                if (v12 <= arg0.base) {
                    0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::put_back<T0>(0x1::option::borrow_mut<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>(&mut arg2), 0x2::balance::split<T0>(v8, v12 * v1 / arg0.share_amount));
                } else {
                    0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::put_back<T0>(0x1::option::borrow_mut<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>(&mut arg2), 0x2::balance::split<T0>(v8, v1));
                    v14 = v13 + v12 * v1 / arg0.share_amount - v1;
                };
                let v15 = v14 + v12 * v2 / arg0.share_amount;
                let v16 = Claimed<T0>{
                    receiver : 0x2::tx_context::sender(arg4),
                    fund     : *0x2::object::uid_as_inner(&arg0.id),
                    shares   : v0,
                    amount   : v15,
                };
                0x2::event::emit<Claimed<T0>>(v16);
                transfer_pool_if_is_some<T0>(arg2);
                0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v8, v15), arg4)
            }
        }
    }

    public fun create<T0>(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<T0>, arg12: &mut 0x2::tx_context::TxContext) : (Fund<T0>, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::MintRequest<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg11);
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg0, 1);
        assert_if_over_max_trader_fee(arg0, arg4);
        assert_if_init_value_over_limit<T0>(arg9, &arg11);
        assert_if_init_value_not_enough<T0>(arg0, arg9, &arg11);
        assert_if_time_setting_wrong(arg6, arg8);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0x1::type_name::get<0x2::balance::Balance<T0>>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v2);
        let v3 = 0x2::bag::new(arg12);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v3, v2, 0x2::coin::into_balance<T0>(arg11));
        let v4 = InvestRecord{
            asset_types : v1,
            assets      : v3,
        };
        let v5 = TimeInfo{
            start_time      : arg6,
            invest_duration : arg7,
            end_time        : arg8,
        };
        let v6 = Fund<T0>{
            id           : 0x2::object::new(arg12),
            name         : arg1,
            description  : arg2,
            fund_img     : arg3,
            trader       : 0x2::tx_context::sender(arg12),
            trader_fee   : arg4,
            asset        : v4,
            base         : v0,
            time         : v5,
            is_arena     : arg5,
            limit_amount : arg9,
            is_settle    : false,
            share_amount : v0,
            after_amount : 0,
            expected_roi : arg10,
            allow_list   : 0x2::table::new<address, bool>(arg12),
        };
        if (!v6.is_arena) {
            let v7 = CreatedFund{
                id              : *0x2::object::uid_as_inner(&v6.id),
                name            : arg1,
                description     : arg2,
                fund_img        : arg3,
                trader          : 0x2::tx_context::sender(arg12),
                trader_fee      : arg4,
                start_time      : arg6,
                invest_duration : arg7,
                end_time        : arg8,
                limit_amount    : arg9,
                expected_roi    : arg10,
            };
            0x2::event::emit<CreatedFund>(v7);
        };
        let v8 = 0x1::string::utf8(b"Common");
        if (v6.is_arena) {
            v8 = 0x1::string::utf8(b"Arena");
        };
        let v9 = FundCap{
            id      : 0x2::object::new(arg12),
            fund_id : *0x2::object::uid_as_inner(&v6.id),
        };
        0x2::transfer::transfer<FundCap>(v9, 0x2::tx_context::sender(arg12));
        (v6, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::create_mint_request<T0>(arg0, *0x2::object::uid_as_inner(&v6.id), true, v6.trader, v8, v0, 0x2::tx_context::sender(arg12), 0x2::tx_context::sender(arg12)))
    }

    public fun create_protocol_account(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg1: u8) : ProtocalAccountRequest {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg0, 1);
        ProtocalAccountRequest{protocol_idx: arg1}
    }

    public fun create_settle_request<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: bool, arg3: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare, arg4: &0x2::tx_context::TxContext) : SettleRequest {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        SettleRequest{
            fund        : *0x2::object::uid_as_inner(&arg0.id),
            settler     : 0x2::tx_context::sender(arg4),
            is_finished : arg2,
        }
    }

    public fun deinvest<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: vector<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_over_invest_duration<T0>(arg0, arg4);
        assert_if_not_arrived_invest_duration<T0>(arg0, arg4);
        assert_if_shares_empty(&arg2);
        arg0.base = arg0.base - arg3;
        let v0 = 0x1::vector::pop_back<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(&mut arg2);
        assert_if_contain_voucher_share(&v0);
        arg0.share_amount = arg0.share_amount - arg3;
        while (0x1::vector::length<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(&arg2) != 0) {
            let v1 = 0x1::vector::pop_back<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(&mut arg2);
            assert_if_deinvest_init_share(&v1);
            assert_if_contain_voucher_share(&v1);
            0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::join(&mut v0, v1);
        };
        let v2 = 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::split(&mut v0, arg3, arg5);
        if (0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::invest_amount(&v0) == 0) {
            0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::burn<T0>(0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::create_burn_request<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id)), v0);
            let v3 = Deinvested{
                remain_share           : 0x1::option::none<0x2::object::ID>(),
                fund_id                : *0x2::object::uid_as_inner(&arg0.id),
                investor               : 0x2::tx_context::sender(arg5),
                withdraw_invest_amount : arg3,
            };
            0x2::event::emit<Deinvested>(v3);
        } else {
            let v4 = Deinvested{
                remain_share           : 0x1::option::some<0x2::object::ID>(0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::id(&v0)),
                fund_id                : *0x2::object::uid_as_inner(&arg0.id),
                investor               : 0x2::tx_context::sender(arg5),
                withdraw_invest_amount : arg3,
            };
            0x2::event::emit<Deinvested>(v4);
            0x2::transfer::public_transfer<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(v0, 0x2::tx_context::sender(arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::invest_amount(&v2)), arg5), 0x2::tx_context::sender(arg5));
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::burn<T0>(0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::create_burn_request<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id)), v2);
        0x1::vector::destroy_empty<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::FundShare>(arg2);
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

    public fun finish_settle_request(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg1: &mut SettleRequest) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg0, 1);
        arg1.is_finished = true;
    }

    public(friend) fun fund_id_of_1l_1nl_for_1nl_req<T0, T1, T2>(arg0: &Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>) : 0x2::object::ID {
        arg0.fund
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

    public(friend) fun fund_id_of_1nl_for_1l_req<T0, T1>(arg0: &Take_1_NonLiquidity_For_1_Liquidity_Request<T0, T1>) : 0x2::object::ID {
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

    fun invest<T0>(arg0: &mut Fund<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_if_over_invest_duration<T0>(arg0, arg2);
        assert_if_not_arrived_invest_duration<T0>(arg0, arg2);
        if (0x2::table::length<address, bool>(&arg0.allow_list) != 0) {
            assert_if_not_in_allow_list<T0>(arg0, 0x2::tx_context::sender(arg3));
        };
        let v0 = 0x2::balance::value<T0>(&arg1);
        arg0.base = arg0.base + v0;
        assert_if_base_over_limit<T0>(arg0, 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>())) + v0);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg1);
        arg0.share_amount = arg0.share_amount + v0;
    }

    public fun invest_duration<T0>(arg0: &Fund<T0>) : u64 {
        arg0.time.invest_duration
    }

    public fun invest_with_asset<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::MintRequest<T0> {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        invest<T0>(arg0, 0x2::coin::into_balance<T0>(arg2), arg3, arg4);
        let v0 = 0x1::string::utf8(b"Common");
        if (arg0.is_arena) {
            v0 = 0x1::string::utf8(b"Arena");
        };
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::create_mint_request<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), false, arg0.trader, v0, 0x2::coin::value<T0>(&arg2), 0x2::tx_context::sender(arg4), 0x2::tx_context::sender(arg4))
    }

    public fun invest_with_voucher<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: vector<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::MintRequest<T0> {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_empty_voucher<T0>(&arg2);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::base_provider<T0>(0x1::vector::borrow<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>(&arg2, 0));
        let v3 = 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::request_sponsor_addr<T0>(0x1::vector::borrow<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>(&arg2, 0));
        while (0x1::vector::length<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>(&arg2) != 0) {
            let v4 = 0x1::vector::pop_back<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>(&mut arg2);
            assert_if_provider_not_matched<T0>(&v4, v2);
            if (!0x1::option::is_none<address>(&v3)) {
                assert_if_fund_owner_and_voucher_sponsor_not_matched<T0>(arg0, &v4);
            };
            v0 = v0 + 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::request_amount<T0>(&v4);
            0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::burn_request<T0>(v4);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::VoucherConsumeRequest<T0>>(arg2);
        assert_if_voucher_value_and_provided_not_matched<T0>(&arg3, v0);
        invest<T0>(arg0, arg3, arg4, arg5);
        let v5 = 0x1::string::utf8(b"Common");
        if (arg0.is_arena) {
            v5 = 0x1::string::utf8(b"Arena");
        };
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::fund_share::create_mint_request<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), false, arg0.trader, v5, 0x2::balance::value<T0>(&arg3), 0x2::object::id_to_address(&v2), 0x2::tx_context::sender(arg5))
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

    fun put_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1: store, T2: store, T3>(arg0: &mut Fund<T3>, arg1: Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg2: T2) {
        let Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request {
            fund         : _,
            take_amount1 : _,
            take_amount2 : _,
            put_amount   : v3,
        } = arg1;
        assert_if_put_amount_is_zero(v3);
        let v4 = 0x1::type_name::get<T2>();
        assert_if_nonliquidity_in_asset_bag<T2, T3>(arg0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v4);
        0x2::bag::add<0x1::type_name::TypeName, T2>(&mut arg0.asset.assets, v4, arg2);
    }

    public fun put_1_liquidity_1_nonliquidity_for_1_nonliquidity_by_all<T0, T1: store, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg3: T2) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        put_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg0, arg2, arg3);
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
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, v3)) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v3), arg2);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v3, arg2);
            };
        };
    }

    fun put_1_liquidity_for_1_liquidity_1_nonliquidity<T0, T1, T2: store, T3>(arg0: &mut Fund<T3>, arg1: Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: T2) {
        let Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request {
            fund        : _,
            take_amount : _,
            put_amount1 : v2,
            put_amount2 : v3,
        } = arg1;
        assert_if_put_amount_is_zero(v2);
        assert_if_put_amount_is_zero(v3);
        assert_if_put_liquidity_not_equal_to_put_amount(v2, 0x2::balance::value<T1>(&arg2));
        let v4 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let (v5, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v4);
        if (v5) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4), arg2);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v4);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, v4)) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4), arg2);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4, arg2);
            };
        };
        let v7 = 0x1::type_name::get<T2>();
        assert_if_nonliquidity_in_asset_bag<T2, T3>(arg0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v7);
        0x2::bag::add<0x1::type_name::TypeName, T2>(&mut arg0.asset.assets, v7, arg3);
    }

    public fun put_1_liquidity_for_1_liquidity_1_nonliquidity_by_all<T0, T1, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: T2) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        put_1_liquidity_for_1_liquidity_1_nonliquidity<T0, T1, T2, T3>(arg0, arg2, arg3, arg4);
    }

    public fun put_1_liquidity_for_1_liquidity_by_all<T0, T1, T2>(arg0: &mut Fund<T2>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg3: 0x2::balance::Balance<T1>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        put_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0, arg2, arg3);
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

    public fun put_1_liquidity_for_1_nonliquidity_by_all<T0, T1: store, T2>(arg0: &mut Fund<T2>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>, arg3: T1) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        put_1_liquidity_for_1_nonliquidity<T0, T1, T2>(arg0, arg2, arg3);
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
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, v4)) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4), arg2);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4, arg2);
            };
        };
        let (v8, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v5);
        if (v8) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5), arg3);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v5);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, v5)) {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5), arg3);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5, arg3);
            };
        };
    }

    public fun put_1_liquidity_for_2_liquidity_by_all<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        put_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg0, arg2, arg3, arg4);
    }

    fun put_1_liquidity_for_nothing<T0>(arg0: Take_1_Liquidity_For_Nothing_Request<T0>) {
        assert_if_nothing_back_not_finished<T0>(&arg0);
        let Take_1_Liquidity_For_Nothing_Request {
            fund        : _,
            take_amount : _,
            is_finished : _,
        } = arg0;
    }

    public fun put_1_liquidity_for_nothing_by_all<T0>(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg1: Take_1_Liquidity_For_Nothing_Request<T0>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg0, 1);
        put_1_liquidity_for_nothing<T0>(arg1);
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
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, v4)) {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4), arg2);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, v4, arg2);
            };
        };
        let (v8, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v5);
        if (v8) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5), arg3);
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v5);
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, v5)) {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5), arg3);
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.asset.assets, v5, arg3);
            };
        };
    }

    public fun put_1_nonliquidity_for_2_liquidity_by_all<T0: store, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        put_1_nonliquidity_for_2_liquidity<T0, T1, T2, T3>(arg0, arg2, arg3, arg4);
    }

    public fun put_back_account<T0: store, T1>(arg0: &mut Fund<T1>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: ProtocalAccountRequest, arg3: T0) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        let ProtocalAccountRequest {  } = arg2;
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.asset.assets, v0)) {
            abort 36
        };
        0x2::bag::add<0x1::type_name::TypeName, T0>(&mut arg0.asset.assets, v0, arg3);
    }

    public fun remove_allow_list<T0>(arg0: &mut Fund<T0>, arg1: &FundCap, arg2: address) {
        assert_if_fund_cap_and_fund_not_matched<T0>(arg0, arg1);
        assert_if_not_in_allow_list<T0>(arg0, arg2);
        0x2::table::remove<address, bool>(&mut arg0.allow_list, arg2);
    }

    public(friend) fun set_is_arena<T0>(arg0: &mut Fund<T0>, arg1: bool) {
        arg0.is_arena = arg1;
    }

    public fun settle<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: SettleRequest, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_not_finished(&arg2);
        assert_if_fund_has_nonbasic_asset<T0>(arg0);
        let SettleRequest {
            fund        : _,
            settler     : _,
            is_finished : _,
        } = arg2;
        arg0.is_settle = true;
        let v3 = Settled{
            fund        : *0x2::object::uid_as_inner(&arg0.id),
            settler     : 0x2::tx_context::sender(arg3),
            is_finished : true,
        };
        0x2::event::emit<Settled>(v3);
        let v4 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v5 = 0x2::balance::value<T0>(v4);
        let v6 = arg0.base;
        arg0.after_amount = v5;
        if (v5 > v6) {
            let v8 = v5 - v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v4, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v8, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::platform_fee_percentage(arg1), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1))), arg3), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::platform(arg1));
            if (v5 >= v6 * (0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1) + arg0.expected_roi) / 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1)) {
                let v9 = SettleResult{
                    fund           : *0x2::object::uid_as_inner(&arg0.id),
                    trader         : trader<T0>(arg0),
                    is_matched_roi : true,
                    final_amount   : v5,
                };
                0x2::event::emit<SettleResult>(v9);
            } else {
                let v10 = SettleResult{
                    fund           : *0x2::object::uid_as_inner(&arg0.id),
                    trader         : trader<T0>(arg0),
                    is_matched_roi : false,
                    final_amount   : v5,
                };
                0x2::event::emit<SettleResult>(v10);
            };
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v4, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(v8, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::settle_percentage(arg1), 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1))), arg3)
        } else {
            let v11 = SettleResult{
                fund           : *0x2::object::uid_as_inner(&arg0.id),
                trader         : trader<T0>(arg0),
                is_matched_roi : false,
                final_amount   : v5,
            };
            0x2::event::emit<SettleResult>(v11);
            0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        }
    }

    public fun start_time<T0>(arg0: &Fund<T0>) : u64 {
        arg0.time.start_time
    }

    public(friend) fun supported_defi_confirm_1l_1nl_for_1nl<T0, T1, T2>(arg0: &mut Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public(friend) fun supported_defi_confirm_1l_for_1l<T0, T1>(arg0: &mut Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public(friend) fun supported_defi_confirm_1l_for_1l_1nl<T0, T1, T2>(arg0: &mut Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, T2>, arg1: u64, arg2: u64) {
        arg0.put_amount1 = arg1;
        arg0.put_amount2 = arg2;
    }

    public(friend) fun supported_defi_confirm_1l_for_1nl<T0, T1: store>(arg0: &mut Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public(friend) fun supported_defi_confirm_1l_for_2l<T0, T1, T2>(arg0: &mut Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg1: u64, arg2: u64) {
        arg0.put_amount1 = arg1;
        arg0.put_amount2 = arg2;
    }

    public(friend) fun supported_defi_confirm_1l_for_nothing<T0>(arg0: &mut Take_1_Liquidity_For_Nothing_Request<T0>) {
        arg0.is_finished = true;
    }

    public(friend) fun supported_defi_confirm_1nl_for_1l<T0, T1>(arg0: &mut Take_1_NonLiquidity_For_1_Liquidity_Request<T0, T1>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public(friend) fun supported_defi_confirm_1nl_for_2l<T0: store, T1, T2>(arg0: &mut Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg1: u64, arg2: u64) {
        arg0.put_amount1 = arg1;
        arg0.put_amount2 = arg2;
    }

    public(friend) fun supported_defi_confirm_2l_for_1nl<T0, T1, T2>(arg0: &mut Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg1: u64) {
        arg0.put_amount = arg1;
    }

    public fun take_1_liquidity_1_nonliquidity_for_1_liquidity_by_trader<T0, T1: store, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, T1, Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T3>(arg0, arg2);
        take_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg0, arg3, arg4)
    }

    public fun take_1_liquidity_1_nonliquidity_for_1_liquidity_over_end_time<T0, T1: store, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, T1, Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T3>(arg0, arg3);
        take_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg0, arg2, arg3)
    }

    fun take_1_liquidity_1_nonliquidity_for_1_nonliquidity<T0, T1: store, T2: store, T3>(arg0: &mut Fund<T3>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, T1, Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg0);
        assert_if_take_nonliquidity_not_in_fund<T1, T3>(arg0);
        let v0 = check_take_amount<T0, T3>(arg0, arg1);
        assert_if_is_settled<T3>(arg0);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v2 = 0x2::balance::split<T0>(v1, v0);
        if (v0 == 0x2::balance::value<T0>(v1)) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T3>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x2::bag::remove<0x1::type_name::TypeName, T1>(&mut arg0.asset.assets, v3);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T3>(arg0, v3));
        let v5 = Take_1_Liquidity_1_NonLiquidity_For_1_NonLiquidity_Request<T0, T1, T2>{
            fund         : *0x2::object::uid_as_inner(id<T3>(arg0)),
            take_amount1 : 0x2::balance::value<T0>(&v2),
            take_amount2 : 1,
            put_amount   : 0,
        };
        (v2, v4, v5)
    }

    fun take_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0: &mut Fund<T2>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) {
        assert_if_take_action_not_available<T2>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T2>(arg0);
        let v0 = check_take_amount<T0, T2>(arg0, arg1);
        assert_if_is_settled<T2>(arg0);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = 0x2::balance::split<T0>(v1, v0);
        let v4 = id<T2>(arg0);
        let v5 = Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>{
            fund        : *0x2::object::uid_as_inner(v4),
            take_amount : 0x2::balance::value<T0>(&v3),
            put_amount  : 0,
        };
        if (v0 == v2) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T2>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v3, v5)
    }

    fun take_1_liquidity_for_1_liquidity_1_nonliquidity<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg0);
        let v0 = check_take_amount<T0, T3>(arg0, arg1);
        assert_if_is_settled<T3>(arg0);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = 0x2::balance::split<T0>(v1, v0);
        let v4 = id<T3>(arg0);
        let v5 = Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, T2>{
            fund        : *0x2::object::uid_as_inner(v4),
            take_amount : 0x2::balance::value<T0>(&v3),
            put_amount1 : 0,
            put_amount2 : 0,
        };
        if (v0 == v2) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T3>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v3, v5)
    }

    public fun take_1_liquidity_for_1_liquidity_1_nonliquidity_by_trader<T0, T1, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T3>(arg0, arg2);
        take_1_liquidity_for_1_liquidity_1_nonliquidity<T0, T1, T2, T3>(arg0, arg3, arg4)
    }

    public fun take_1_liquidity_for_1_liquidity_1_nonliquidity_over_end_time<T0, T1, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_1_NonLiquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T3>(arg0, arg3);
        take_1_liquidity_for_1_liquidity_1_nonliquidity<T0, T1, T2, T3>(arg0, arg2, arg3)
    }

    public fun take_1_liquidity_for_1_liquidity_by_trader<T0, T1, T2>(arg0: &mut Fund<T2>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T2>(arg0, arg2);
        take_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0, arg3, arg4)
    }

    public fun take_1_liquidity_for_1_liquidity_over_end_time<T0, T1, T2>(arg0: &mut Fund<T2>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T2>(arg0, arg3);
        take_1_liquidity_for_1_liquidity<T0, T1, T2>(arg0, arg2, arg3)
    }

    fun take_1_liquidity_for_1_nonliquidity<T0, T1: store, T2>(arg0: &mut Fund<T2>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) {
        assert_if_take_action_not_available<T2>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T2>(arg0);
        let v0 = check_take_amount<T0, T2>(arg0, arg1);
        assert_if_is_settled<T2>(arg0);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = 0x2::balance::split<T0>(v1, v0);
        let v4 = id<T2>(arg0);
        let v5 = Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>{
            fund        : *0x2::object::uid_as_inner(v4),
            take_amount : 0x2::balance::value<T0>(&v3),
            put_amount  : 0,
        };
        if (v0 == v2) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T2>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v3, v5)
    }

    public fun take_1_liquidity_for_1_nonliquidity_by_trader<T0, T1: store, T2>(arg0: &mut Fund<T2>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T2>(arg0, arg2);
        take_1_liquidity_for_1_nonliquidity<T0, T1, T2>(arg0, arg3, arg4)
    }

    public fun take_1_liquidity_for_1_nonliquidity_over_end_time<T0, T1: store, T2>(arg0: &mut Fund<T2>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_1_NonLiquidity_Request<T0, T1>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T2>(arg0, arg3);
        take_1_liquidity_for_1_nonliquidity<T0, T1, T2>(arg0, arg2, arg3)
    }

    fun take_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg0);
        let v0 = check_take_amount<T0, T3>(arg0, arg1);
        assert_if_is_settled<T3>(arg0);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = 0x2::balance::split<T0>(v1, v0);
        let v4 = id<T3>(arg0);
        let v5 = Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>{
            fund        : *0x2::object::uid_as_inner(v4),
            take_amount : 0x2::balance::value<T0>(&v3),
            put_amount1 : 0,
            put_amount2 : 0,
        };
        if (v0 == v2) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T3>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v3, v5)
    }

    public fun take_1_liquidity_for_2_liquidity_by_trader<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T3>(arg0, arg2);
        take_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg0, arg3, arg4)
    }

    public fun take_1_liquidity_for_2_liquidity_over_end_time<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T3>(arg0, arg3);
        take_1_liquidity_for_2_liquidity<T0, T1, T2, T3>(arg0, arg2, arg3)
    }

    fun take_1_liquidity_for_nothing<T0, T1>(arg0: &mut Fund<T1>, arg1: u64, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_Nothing_Request<T0>) {
        assert_if_take_action_not_available<T1>(arg0, arg2);
        assert_if_take_liquidity_not_in_fund<T0, T1>(arg0);
        let v0 = check_take_amount<T0, T1>(arg0, arg1);
        assert_if_is_settled<T1>(arg0);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = 0x2::balance::split<T0>(v1, v0);
        let v4 = id<T1>(arg0);
        let v5 = Take_1_Liquidity_For_Nothing_Request<T0>{
            fund        : *0x2::object::uid_as_inner(v4),
            take_amount : 0x2::balance::value<T0>(&v3),
            is_finished : false,
        };
        if (v0 == v2) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T1>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        (v3, v5)
    }

    public fun take_1_liquidity_for_nothing_by_trader<T0, T1>(arg0: &mut Fund<T1>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_Nothing_Request<T0>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T1>(arg0, arg2);
        take_1_liquidity_for_nothing<T0, T1>(arg0, arg3, arg4)
    }

    public fun take_1_liquidity_for_nothing_over_end_time<T0, T1>(arg0: &mut Fund<T1>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, Take_1_Liquidity_For_Nothing_Request<T0>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T1>(arg0, arg3);
        take_1_liquidity_for_nothing<T0, T1>(arg0, arg2, arg3)
    }

    fun take_1_nonliquidity_for_2_liquidity<T0: store, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0x2::clock::Clock) : (T0, Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg1);
        assert_if_take_nonliquidity_not_in_fund<T0, T3>(arg0);
        assert_if_is_settled<T3>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, T0>(&mut arg0.asset.assets, v0);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T3>(arg0, v0));
        let v2 = Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>{
            fund        : *0x2::object::uid_as_inner(id<T3>(arg0)),
            take_amount : 1,
            put_amount1 : 0,
            put_amount2 : 0,
        };
        (v1, v2)
    }

    public fun take_1_nonliquidity_for_2_liquidity_by_trader<T0: store, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: &0x2::clock::Clock) : (T0, Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T3>(arg0, arg2);
        take_1_nonliquidity_for_2_liquidity<T0, T1, T2, T3>(arg0, arg3)
    }

    public fun take_1_nonliquidity_for_2_liquidity_over_end_time<T0: store, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &0x2::clock::Clock) : (T0, Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T3>(arg0, arg2);
        take_1_nonliquidity_for_2_liquidity<T0, T1, T2, T3>(arg0, arg2)
    }

    fun take_2_liquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg0: &mut Fund<T3>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        assert_if_take_action_not_available<T3>(arg0, arg3);
        assert_if_take_liquidity_not_in_fund<T0, T3>(arg0);
        assert_if_take_liquidity_not_in_fund<T1, T3>(arg0);
        let v0 = check_take_amount<T0, T3>(arg0, arg1);
        let v1 = check_take_amount<T1, T3>(arg0, arg2);
        assert_if_is_settled<T3>(arg0);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        let v3 = 0x2::balance::value<T0>(v2);
        let v4 = 0x2::balance::split<T0>(v2, v0);
        let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T1>>());
        let v6 = 0x2::balance::value<T1>(v5);
        let v7 = 0x2::balance::split<T1>(v5, v1);
        let v8 = id<T3>(arg0);
        let v9 = Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>{
            fund         : *0x2::object::uid_as_inner(v8),
            take_amount1 : 0x2::balance::value<T0>(&v4),
            take_amount2 : 0x2::balance::value<T1>(&v7),
            put_amount   : 0,
        };
        if (v0 == v3) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, assert_if_not_included_in_asset_array<T3>(arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>()));
        };
        if (v1 == v6) {
            let v10 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
            let (_, v12) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.asset.asset_types, &v10);
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.asset.asset_types, v12);
        };
        (v4, v7, v9)
    }

    public fun take_2_liquidity_for_1_nonliquidity_by_trader<T0, T1, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_fund_cap_and_fund_not_matched<T3>(arg0, arg2);
        take_2_liquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg0, arg3, arg4, arg5)
    }

    public fun take_2_liquidity_for_1_nonliquidity_over_end_time<T0, T1, T2: store, T3>(arg0: &mut Fund<T3>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>) {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_in_end_time<T3>(arg0, arg4);
        take_2_liquidity_for_1_nonliquidity<T0, T1, T2, T3>(arg0, arg2, arg3, arg4)
    }

    public fun to_share_object<T0>(arg0: Fund<T0>) {
        0x2::transfer::share_object<Fund<T0>>(arg0);
    }

    public fun trader<T0>(arg0: &Fund<T0>) : address {
        arg0.trader
    }

    public fun trader_claim<T0>(arg0: &mut Fund<T0>, arg1: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::GlobalConfig, arg2: &FundCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::assert_if_version_not_matched(arg1, 1);
        assert_if_not_settle<T0>(arg0);
        assert_if_fund_cap_and_fund_not_matched<T0>(arg0, arg2);
        assert_if_trader_fee_already_claimed<T0>(arg0);
        if (arg0.after_amount > arg0.base) {
            let v1 = 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::math::ceil(arg0.after_amount - arg0.base, arg0.trader_fee, 0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::base_percentage(arg1));
            let v2 = TraderClaimed<T0>{
                fund     : *0x2::object::uid_as_inner(&arg0.id),
                trader   : arg0.trader,
                receiver : 0x2::tx_context::sender(arg3),
                amount   : v1,
            };
            0x2::event::emit<TraderClaimed<T0>>(v2);
            let v3 = TraderClaimedProof{dummy_field: false};
            0x2::dynamic_field::add<0x1::type_name::TypeName, TraderClaimedProof>(&mut arg0.id, 0x1::type_name::get<TraderClaimedProof>(), v3);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), v1), arg3)
        } else {
            let v4 = TraderClaimed<T0>{
                fund     : *0x2::object::uid_as_inner(&arg0.id),
                trader   : arg0.trader,
                receiver : 0x2::tx_context::sender(arg3),
                amount   : 0,
            };
            0x2::event::emit<TraderClaimed<T0>>(v4);
            let v5 = TraderClaimedProof{dummy_field: false};
            0x2::dynamic_field::add<0x1::type_name::TypeName, TraderClaimedProof>(&mut arg0.id, 0x1::type_name::get<TraderClaimedProof>(), v5);
            0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        }
    }

    public fun trader_fee<T0>(arg0: &Fund<T0>) : u64 {
        arg0.trader_fee
    }

    fun transfer_pool_if_is_some<T0>(arg0: 0x1::option::Option<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>) {
        if (0x1::option::is_some<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>(&arg0)) {
            0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::to_share_object<T0>(0x1::option::destroy_some<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>(arg0));
        } else {
            0x1::option::destroy_none<0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::voucher::SponsorPool<T0>>(arg0);
        };
    }

    public(friend) fun update_description<T0>(arg0: &mut Fund<T0>, arg1: &FundCap, arg2: 0x1::string::String) {
        assert_if_fund_cap_and_fund_not_matched<T0>(arg0, arg1);
        arg0.description = arg2;
    }

    public(friend) fun update_time<T0>(arg0: &mut Fund<T0>, arg1: u64, arg2: u64, arg3: u64) {
        arg0.time.start_time = arg1;
        arg0.time.invest_duration = arg2;
        arg0.time.end_time = arg3;
    }

    public entry fun withdraw<T0>(arg0: &0xbb80abb8dfc479a555a887e9ba35f821983ec524cf3075ad24d4f1d0275c124f::config::AdminCap, arg1: &mut Fund<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.asset.assets, 0x1::type_name::get<0x2::balance::Balance<T0>>()), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

