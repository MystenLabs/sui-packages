module 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool {
    struct FeeConfig has copy, drop, store {
        swap_in_fee_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        swap_out_fee_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimal: u8,
        default_fee_config: FeeConfig,
        partner_fee_configs: 0x2::vec_map::VecMap<address, FeeConfig>,
        price_tolerance: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        balance: 0x2::balance::Balance<T0>,
        balance_amount: u64,
        usdb_supply: u64,
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>,
    }

    struct AccessControl has key {
        id: 0x2::object::UID,
        managers: 0x2::vec_set::VecSet<address>,
    }

    public fun balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::assert_valid_package(arg0);
        let v0 = 0x2::object::new(arg6);
        0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::events::emit_new_pool<T0>(0x2::object::uid_to_inner(&v0), arg2, arg3, arg4);
        let v1 = FeeConfig{
            swap_in_fee_rate  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg3),
            swap_out_fee_rate : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg4),
        };
        Pool<T0>{
            id                  : v0,
            decimal             : arg2,
            default_fee_config  : v1,
            partner_fee_configs : 0x2::vec_map::empty<address, FeeConfig>(),
            price_tolerance     : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg5),
            balance             : 0x2::balance::zero<T0>(),
            balance_amount      : 0,
            usdb_supply         : 0,
            sheet               : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness()),
        }
    }

    public fun add_debtor<T0, T1>(arg0: &mut Pool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_debtor<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(&mut arg0.sheet, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>(), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness());
    }

    public fun swap_in<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB> {
        0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::assert_valid_package(arg1);
        check_price<T0>(arg0, arg2);
        let v0 = if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(arg4)) {
            0x1::option::some<address>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(0x1::option::borrow<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(arg4)))
        } else {
            0x1::option::none<address>()
        };
        let v1 = swap_in_fee_rate<T0>(arg0, v0);
        swap_in_internal<T0>(arg0, arg1, arg3, v1, arg5)
    }

    public fun swap_out<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg3: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg4: &0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::assert_valid_package(arg1);
        check_price<T0>(arg0, arg2);
        let v0 = if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(arg4)) {
            0x1::option::some<address>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(0x1::option::borrow<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(arg4)))
        } else {
            0x1::option::none<address>()
        };
        let v1 = swap_out_fee_rate<T0>(arg0, v0);
        swap_out_internal<T0>(arg0, arg1, arg3, v1, arg5)
    }

    public fun add_manager(arg0: &mut AccessControl, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    fun assert_sender_is_manager(arg0: &AccessControl, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun balance_amount<T0>(arg0: &Pool<T0>) : u64 {
        arg0.balance_amount
    }

    public fun ban_debtor<T0, T1>(arg0: &mut Pool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::ban<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(&mut arg0.sheet, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>(), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness());
    }

    fun check_price<T0>(arg0: &Pool<T0>, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>) {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::diff(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::aggregated_price<T0>(arg1), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one()), price_tolerance<T0>(arg0))) {
            err_fluctuating_price();
        };
    }

    public fun collect_repayment<T0>(arg0: &mut Pool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>) {
        0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::assert_valid_package(arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::collect<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(&mut arg0.sheet, arg2, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness()));
    }

    public fun conversion_rate<T0>(arg0: &Pool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let v0 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::decimal();
        if (v0 >= arg0.decimal) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::pow(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ten(), ((v0 - arg0.decimal) as u64))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one(), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::pow(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ten(), ((arg0.decimal - v0) as u64)))
        }
    }

    public fun create<T0>(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pool<T0>>(new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun create_acl(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessControl{
            id       : 0x2::object::new(arg1),
            managers : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::share_object<AccessControl>(v0);
    }

    public fun decimal<T0>(arg0: &Pool<T0>) : u8 {
        arg0.decimal
    }

    fun err_fluctuating_price() {
        abort 402
    }

    fun err_pool_balance_not_enough() {
        abort 202
    }

    fun err_pool_not_enough() {
        abort 401
    }

    fun err_sender_is_not_manager() {
        abort 201
    }

    public fun loan<T0, T1>(arg0: &mut Pool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &AccessControl, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM, T1> {
        0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::assert_valid_package(arg1);
        assert_sender_is_manager(arg2, arg3);
        if (0x2::balance::value<T0>(&arg0.balance) < arg4) {
            err_pool_balance_not_enough();
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::lend<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM, T1>(&mut arg0.sheet, 0x2::balance::split<T0>(&mut arg0.balance, arg4), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness())
    }

    public fun price_tolerance<T0>(arg0: &Pool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.price_tolerance
    }

    public fun remove_manager(arg0: &mut AccessControl, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun request_repayment<T0>(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg1: &AccessControl, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: u64) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM> {
        0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::assert_valid_package(arg0);
        assert_sender_is_manager(arg1, arg2);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::request<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(arg3, 0x1::option::none<vector<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>>(), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness())
    }

    public fun set_fee_config<T0>(arg0: &mut Pool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64) {
        if (0x1::option::is_some<address>(&arg2)) {
            let v0 = 0x1::option::destroy_some<address>(arg2);
            if (0x2::vec_map::contains<address, FeeConfig>(&arg0.partner_fee_configs, &v0)) {
                let v1 = 0x2::vec_map::get_mut<address, FeeConfig>(&mut arg0.partner_fee_configs, &v0);
                v1.swap_in_fee_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg3);
                v1.swap_out_fee_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg4);
            } else {
                let v2 = FeeConfig{
                    swap_in_fee_rate  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg3),
                    swap_out_fee_rate : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg4),
                };
                0x2::vec_map::insert<address, FeeConfig>(&mut arg0.partner_fee_configs, v0, v2);
            };
        } else {
            arg0.default_fee_config.swap_in_fee_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg3);
            arg0.default_fee_config.swap_out_fee_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg4);
        };
    }

    public fun set_price_tolerance<T0>(arg0: &mut Pool<T0>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u64) {
        arg0.price_tolerance = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg2);
    }

    public fun swap_in_fee_rate<T0>(arg0: &Pool<T0>, arg1: 0x1::option::Option<address>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        if (0x1::option::is_some<address>(&arg1) && 0x2::vec_map::contains<address, FeeConfig>(&arg0.partner_fee_configs, 0x1::option::borrow<address>(&arg1))) {
            0x2::vec_map::get<address, FeeConfig>(&arg0.partner_fee_configs, 0x1::option::borrow<address>(&arg1)).swap_in_fee_rate
        } else {
            arg0.default_fee_config.swap_in_fee_rate
        }
    }

    fun swap_in_internal<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(v0), conversion_rate<T0>(arg0)));
        arg0.balance_amount = 0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.usdb_supply = arg0.usdb_supply + v1;
        if (v0 > 0 || v1 > 0) {
            0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::events::emit_swap_in<T0>(v0, arg0.balance_amount, v1, arg0.usdb_supply);
        };
        let v2 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(arg1, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness(), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::package_version(), v1, arg4);
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(arg1, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness(), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::memo::swap_in(), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg3, v1))));
        v2
    }

    public fun swap_out_fee_rate<T0>(arg0: &Pool<T0>, arg1: 0x1::option::Option<address>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        if (0x1::option::is_some<address>(&arg1) && 0x2::vec_map::contains<address, FeeConfig>(&arg0.partner_fee_configs, 0x1::option::borrow<address>(&arg1))) {
            0x2::vec_map::get<address, FeeConfig>(&arg0.partner_fee_configs, 0x1::option::borrow<address>(&arg1)).swap_out_fee_rate
        } else {
            arg0.default_fee_config.swap_out_fee_rate
        }
    }

    fun swap_out_internal<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg2);
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(arg1, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness(), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::version::package_version(), arg2);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(v0), conversion_rate<T0>(arg0)));
        if (v1 > balance<T0>(arg0)) {
            err_pool_not_enough();
        };
        if (arg0.usdb_supply < v0) {
            err_pool_not_enough();
        };
        arg0.usdb_supply = arg0.usdb_supply - v0;
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg4);
        arg0.balance_amount = 0x2::balance::value<T0>(&arg0.balance);
        if (v0 > 0 || v1 > 0) {
            0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::events::emit_swap_out<T0>(v0, arg0.usdb_supply, v1, arg0.balance_amount);
        };
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::BucketV2PSM>(arg1, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness::witness(), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::memo::swap_out(), 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg3, 0x2::coin::value<T0>(&v2)))));
        v2
    }

    public fun usdb_supply<T0>(arg0: &Pool<T0>) : u64 {
        arg0.usdb_supply
    }

    // decompiled from Move bytecode v6
}

