module 0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::yield_usdb {
    struct Created<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        max_lp_supply: u64,
        abstract_address: address,
    }

    struct MaxSupplyUpdated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        previous_max_lp_supply: u64,
        current_max_lp_supply: u64,
    }

    struct Minted<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        usdb_amount: u64,
        lp_amount: u64,
    }

    struct Burned<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        lp_amount: u64,
        usdb_amount: u64,
    }

    struct Claimed<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
    }

    struct Collected<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        usdb_amount: u64,
    }

    struct YieldVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        max_lp_supply: u64,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        buffer: 0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::Buffer<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>,
        managers: 0x2::vec_set::VecSet<address>,
        versions: 0x2::vec_set::VecSet<u16>,
    }

    public fun burn<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T1>) {
        assert_valid_package_version<T0, T1>(arg0);
        if (0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::releasable_amount<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg0.buffer, arg3) > 0) {
            err_cannot_burn_before_release();
        };
        let v0 = 0x2::coin::value<T0>(&arg4);
        0x2::coin::burn<T0>(&mut arg0.lp_treasury_cap, arg4);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account);
        let (v2, v3) = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::withdraw<T1>(arg2, arg1, &v1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(saving_lp_reserve<T0, T1>(arg0, arg2), lp_supply<T0, T1>(arg0)), v0)), arg3, arg5);
        let v4 = v2;
        let v5 = Burned<T0>{
            vault_id    : id<T0, T1>(arg0),
            lp_amount   : v0,
            usdb_amount : 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4),
        };
        0x2::event::emit<Burned<T0>>(v5);
        (v4, v3)
    }

    public fun mint<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T1>) {
        assert_valid_package_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg4);
        0x2::balance::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg4), 0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::release<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg0.buffer, arg3));
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(mint_ratio<T0, T1>(arg0, arg2, arg3), v0));
        let v2 = Minted<T0>{
            vault_id    : id<T0, T1>(arg0),
            usdb_amount : v0,
            lp_amount   : v1,
        };
        0x2::event::emit<Minted<T0>>(v2);
        if (0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap) > max_lp_supply<T0, T1>(arg0)) {
            err_exceed_max_supply();
        };
        (0x2::coin::mint<T0>(&mut arg0.lp_treasury_cap, v1, arg5), 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit<T1>(arg2, arg1, abstract_address<T0, T1>(arg0), arg4, arg3, arg5))
    }

    public fun id<T0, T1>(arg0: &YieldVault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<YieldVault<T0, T1>>(arg0)
    }

    public fun new<T0, T1>(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : YieldVault<T0, T1> {
        if (0x2::coin::total_supply<T0>(&arg2) > 0) {
            err_non_zero_initial_supply();
        };
        if (0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_balance_of<T1>(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&arg3)) > 0) {
            err_non_zero_initial_reserve();
        };
        let v0 = YieldVault<T0, T1>{
            id               : 0x2::object::new(arg6),
            max_lp_supply    : arg4,
            lp_treasury_cap  : arg2,
            abstract_account : arg3,
            buffer           : 0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::new<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()),
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg6)),
            versions         : 0x2::vec_set::singleton<u16>(package_version()),
        };
        let v1 = Created<T0>{
            vault_id         : id<T0, T1>(&v0),
            max_lp_supply    : arg4,
            abstract_address : abstract_address<T0, T1>(&v0),
        };
        0x2::event::emit<Created<T0>>(v1);
        v0
    }

    public fun claim<T0, T1, T2>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T1>, arg2: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg3: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg4: &0x2::clock::Clock, arg5: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_valid_package_version<T0, T1>(arg0);
        assert_sender_is_manager<T0, T1>(arg0, arg5);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account);
        let v1 = 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::claim<T1, T2>(arg1, arg2, arg3, &v0, arg4, arg6);
        let v2 = Claimed<T0>{
            vault_id      : id<T0, T1>(arg0),
            reward_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            reward_amount : 0x2::coin::value<T2>(&v1),
        };
        0x2::event::emit<Claimed<T0>>(v2);
        v1
    }

    public fun buffer<T0, T1>(arg0: &YieldVault<T0, T1>) : &0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::Buffer<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB> {
        &arg0.buffer
    }

    public fun destroy<T0, T1>(arg0: YieldVault<T0, T1>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>) {
        assert_valid_package_version<T0, T1>(&arg0);
        if (0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap) > 0) {
            err_cannot_destroy_non_empty_vault();
        };
        let YieldVault {
            id               : v0,
            max_lp_supply    : _,
            lp_treasury_cap  : v2,
            abstract_account : v3,
            buffer           : v4,
            managers         : _,
            versions         : _,
        } = arg0;
        0x2::object::delete(v0);
        (v2, v3, 0x2::coin::from_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::destroy<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v4), arg2))
    }

    public fun release<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T1> {
        assert_valid_package_version<T0, T1>(arg0);
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit<T1>(arg2, arg1, abstract_address<T0, T1>(arg0), 0x2::coin::from_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::release<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg0.buffer, arg3), arg4), arg3, arg4)
    }

    public fun abstract_address<T0, T1>(arg0: &YieldVault<T0, T1>) : address {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&arg0.abstract_account)
    }

    public fun add_manager<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    fun assert_sender_is_manager<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version<T0, T1>(arg0: &YieldVault<T0, T1>) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun burn_ratio<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg2: &0x2::clock::Clock) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        let v0 = lp_supply<T0, T1>(arg0);
        if (v0 > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(usdb_reserve<T0, T1>(arg0, arg1, arg2), v0)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()
        }
    }

    public fun claimable_reward_amount<T0, T1, T2>(arg0: &YieldVault<T0, T1>, arg1: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T1>, arg2: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg3: &0x2::clock::Clock) : u64 {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::realtime_reward_amount<T1, T2>(0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::get_rewarder<T1, T2>(arg1), arg2, abstract_address<T0, T1>(arg0), arg3)
    }

    public fun collect<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg5: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T1> {
        assert_valid_package_version<T0, T1>(arg0);
        assert_sender_is_manager<T0, T1>(arg0, arg5);
        let v0 = Collected<T0>{
            vault_id    : id<T0, T1>(arg0),
            usdb_amount : 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg4),
        };
        0x2::event::emit<Collected<T0>>(v0);
        0x2::balance::destroy_zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::set_flow_rate<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg0.buffer, arg3, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg0.buffer), arg6)));
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit<T1>(arg2, arg1, abstract_address<T0, T1>(arg0), 0x2::coin::from_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut arg0.buffer, arg3, 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg4)), arg7), arg3, arg7)
    }

    public fun default<T0, T1>(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<YieldVault<T0, T1>>(new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    fun err_cannot_burn_before_release() {
        abort 6
    }

    fun err_cannot_destroy_non_empty_vault() {
        abort 3
    }

    fun err_exceed_max_supply() {
        abort 5
    }

    fun err_invalid_package_version() {
        abort 0
    }

    fun err_non_zero_initial_reserve() {
        abort 2
    }

    fun err_non_zero_initial_supply() {
        abort 1
    }

    fun err_sender_is_not_manager() {
        abort 4
    }

    public fun lp_supply<T0, T1>(arg0: &YieldVault<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap)
    }

    public fun max_lp_supply<T0, T1>(arg0: &YieldVault<T0, T1>) : u64 {
        arg0.max_lp_supply
    }

    public fun mint_ratio<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg2: &0x2::clock::Clock) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        let v0 = usdb_reserve<T0, T1>(arg0, arg1, arg2);
        if (v0 > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(lp_supply<T0, T1>(arg0), v0)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::one()
        }
    }

    public fun package_version() : u16 {
        1
    }

    public fun remove_manager<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    fun saving_lp_reserve<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>) : u64 {
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_balance_of<T1>(arg1, abstract_address<T0, T1>(arg0))
    }

    public fun update_max_lp_supply<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u64) {
        let v0 = MaxSupplyUpdated<T0>{
            vault_id               : id<T0, T1>(arg0),
            previous_max_lp_supply : arg0.max_lp_supply,
            current_max_lp_supply  : arg2,
        };
        0x2::event::emit<MaxSupplyUpdated<T0>>(v0);
        arg0.max_lp_supply = arg2;
    }

    public fun usdb_reserve<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T1>, arg2: &0x2::clock::Clock) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_token_ratio<T1>(arg1, arg2), saving_lp_reserve<T0, T1>(arg0, arg1))) + 0x5487c6f4446c37053537447d9f81bc205e2c502a670edc7dc48cec99cfcfc8a2::buffer::releasable_amount<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg0.buffer, arg2)
    }

    // decompiled from Move bytecode v6
}

