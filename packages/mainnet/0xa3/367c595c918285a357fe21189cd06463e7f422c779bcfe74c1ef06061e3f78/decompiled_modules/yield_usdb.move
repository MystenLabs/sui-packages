module 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb {
    struct Created<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        max_lp_supply: u64,
        abstract_address: address,
        admin_cap_id: 0x2::object::ID,
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
        lp_treasury_cap: 0x2::coin::TreasuryCap<T1>,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        managers: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg4);
        0x2::coin::burn<T1>(&mut arg0.lp_treasury_cap, arg4);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account);
        let (v2, v3) = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::withdraw<T0>(arg2, arg1, &v1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(unstake_ratio<T0, T1>(arg0, arg2), v0)), arg3, arg5);
        let v4 = v2;
        let v5 = Burned<T1>{
            vault_id    : id<T0, T1>(arg0),
            lp_amount   : v0,
            usdb_amount : 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4),
        };
        0x2::event::emit<Burned<T1>>(v5);
        (v4, v3)
    }

    public fun mint<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T0>) {
        let v0 = 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit<T0>(arg2, arg1, abstract_address<T0, T1>(arg0), arg4, arg3, arg5);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(stake_ratio<T0, T1>(arg0, arg2), 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit_response_minted_lp_amount<T0>(&v0)));
        let v2 = Minted<T1>{
            vault_id    : id<T0, T1>(arg0),
            usdb_amount : 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg4),
            lp_amount   : v1,
        };
        0x2::event::emit<Minted<T1>>(v2);
        if (0x2::coin::total_supply<T1>(&arg0.lp_treasury_cap) > max_lp_supply<T0, T1>(arg0)) {
            err_exceed_max_supply();
        };
        (0x2::coin::mint<T1>(&mut arg0.lp_treasury_cap, v1, arg5), v0)
    }

    public fun id<T0, T1>(arg0: &YieldVault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<YieldVault<T0, T1>>(arg0)
    }

    public fun new<T0, T1>(arg0: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (YieldVault<T0, T1>, AdminCap<T1>) {
        if (0x2::coin::total_supply<T1>(&arg1) > 0) {
            err_invalid_treasury_cap();
        };
        let v0 = YieldVault<T0, T1>{
            id               : 0x2::object::new(arg4),
            max_lp_supply    : arg3,
            lp_treasury_cap  : arg1,
            abstract_account : arg2,
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg4)),
        };
        let v1 = AdminCap<T1>{id: 0x2::object::new(arg4)};
        let v2 = Created<T1>{
            vault_id         : id<T0, T1>(&v0),
            max_lp_supply    : arg3,
            abstract_address : abstract_address<T0, T1>(&v0),
            admin_cap_id     : 0x2::object::id<AdminCap<T1>>(&v1),
        };
        0x2::event::emit<Created<T1>>(v2);
        (v0, v1)
    }

    public fun claim<T0, T1, T2>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T0>, arg2: &0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::incentive_config::GlobalConfig, arg3: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg4: &0x2::clock::Clock, arg5: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_sender_is_manager<T0, T1>(arg0, arg5);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account);
        let v1 = 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::claim<T0, T2>(arg1, arg2, arg3, &v0, arg4, arg6);
        let v2 = Claimed<T1>{
            vault_id      : id<T0, T1>(arg0),
            reward_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            reward_amount : 0x2::coin::value<T2>(&v1),
        };
        0x2::event::emit<Claimed<T1>>(v2);
        v1
    }

    public fun abstract_address<T0, T1>(arg0: &YieldVault<T0, T1>) : address {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&arg0.abstract_account)
    }

    public fun add_manager<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &AdminCap<T1>, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    fun assert_sender_is_manager<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun claimable_reward_amount<T0, T1, T2>(arg0: &YieldVault<T0, T1>, arg1: &mut 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::RewardManager<T0>, arg2: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg3: &0x2::clock::Clock) : u64 {
        0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::realtime_reward_amount<T0, T2>(0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive::get_rewarder<T0, T2>(arg1), arg2, abstract_address<T0, T1>(arg0), arg3)
    }

    public fun collect<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg5: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg6: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T0> {
        assert_sender_is_manager<T0, T1>(arg0, arg5);
        let v0 = Collected<T1>{
            vault_id    : id<T0, T1>(arg0),
            usdb_amount : 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&arg4),
        };
        0x2::event::emit<Collected<T1>>(v0);
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::deposit<T0>(arg2, arg1, abstract_address<T0, T1>(arg0), arg4, arg3, arg6)
    }

    public fun destroy<T0, T1>(arg0: YieldVault<T0, T1>, arg1: AdminCap<T1>) : (0x2::coin::TreasuryCap<T1>, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account) {
        if (0x2::coin::total_supply<T1>(&arg0.lp_treasury_cap) > 0) {
            err_cannot_destroy_non_empty_vault();
        };
        let YieldVault {
            id               : v0,
            max_lp_supply    : _,
            lp_treasury_cap  : v2,
            abstract_account : v3,
            managers         : _,
        } = arg0;
        0x2::object::delete(v0);
        let AdminCap { id: v5 } = arg1;
        0x2::object::delete(v5);
        (v2, v3)
    }

    fun err_cannot_destroy_non_empty_vault() {
        abort 1
    }

    fun err_exceed_max_supply() {
        abort 3
    }

    fun err_invalid_treasury_cap() {
        abort 0
    }

    fun err_sender_is_not_manager() {
        abort 2
    }

    public fun lp_supply<T0, T1>(arg0: &YieldVault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.lp_treasury_cap)
    }

    public fun max_lp_supply<T0, T1>(arg0: &YieldVault<T0, T1>) : u64 {
        arg0.max_lp_supply
    }

    public fun remove_manager<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &AdminCap<T1>, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun st_reserve<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>) : u64 {
        0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_balance_of<T0>(arg1, abstract_address<T0, T1>(arg0))
    }

    public fun stake_ratio<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        let v0 = st_reserve<T0, T1>(arg0, arg1);
        if (v0 > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(lp_supply<T0, T1>(arg0), v0)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::one()
        }
    }

    public fun unstake_ratio<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        if (lp_supply<T0, T1>(arg0) > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(st_reserve<T0, T1>(arg0, arg1), lp_supply<T0, T1>(arg0))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()
        }
    }

    public fun update_max_lp_supply<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &AdminCap<T1>, arg2: u64) {
        let v0 = MaxSupplyUpdated<T1>{
            vault_id               : id<T0, T1>(arg0),
            previous_max_lp_supply : arg0.max_lp_supply,
            current_max_lp_supply  : arg2,
        };
        0x2::event::emit<MaxSupplyUpdated<T1>>(v0);
        arg0.max_lp_supply = arg2;
    }

    public fun usdb_reserve<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::lp_token_ratio<T0>(arg1, arg2), st_reserve<T0, T1>(arg0, arg1)))
    }

    // decompiled from Move bytecode v6
}

