module 0xefb3d49a40a64f462ce00b742b8649a378f198eb1fae89676c82801e04a481f3::navi_adapter {
    struct NaviAdapter has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct NaviPosition<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        vault: 0x2::object::ID,
        cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        cap_id: 0x2::object::ID,
        owner: address,
        storage: 0x2::object::ID,
        asset: u8,
        decimals: u8,
    }

    struct Harvest {
        position: 0x2::object::ID,
        before: u64,
        reward: 0x1::ascii::String,
        claimed: u64,
    }

    struct PositionCreated has copy, drop {
        vault: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
        asset: u8,
    }

    struct Harvested has copy, drop {
        vault: 0x2::object::ID,
        reward: 0x1::ascii::String,
        claimed: u64,
        supplied: u64,
        value_before: u64,
        value_after: u64,
    }

    public fun report<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::NavSession, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: &NaviPosition<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0x2::clock::Clock) {
        assert_bound<T0, T1>(arg2, arg1);
        let v0 = NaviAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::report<T0, T1, NaviAdapter>(arg0, arg1, v0, live_value<T0>(arg2, arg3, arg4));
    }

    fun assert_bound<T0, T1>(arg0: &NaviPosition<T0>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>) {
        assert!(arg0.version == 1, 14);
        assert!(arg0.vault == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1), 1);
    }

    public fun asset<T0>(arg0: &NaviPosition<T0>) : u8 {
        arg0.asset
    }

    public fun create_position<T0, T1>(arg0: &mut Registry, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::CuratorCap, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg4: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::curator_cap_vault(arg2) == v0, 2);
        assert!(arg6 <= 18, 15);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg4, arg5) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 4);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg3);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg4, v1);
        let v4 = v3;
        let v5 = v2;
        assert!(0x1::vector::is_empty<u8>(&v5) && 0x1::vector::is_empty<u8>(&v4), 5);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.positions, v0), 6);
        let v6 = NaviPosition<T0>{
            id       : 0x2::object::new(arg7),
            version  : 1,
            vault    : v0,
            cap      : arg3,
            cap_id   : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg3),
            owner    : v1,
            storage  : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg4),
            asset    : arg5,
            decimals : arg6,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.positions, v0, 0x2::object::id<NaviPosition<T0>>(&v6));
        let v7 = PositionCreated{
            vault    : v0,
            position : 0x2::object::id<NaviPosition<T0>>(&v6),
            owner    : v1,
            asset    : arg5,
        };
        0x2::event::emit<PositionCreated>(v7);
        0x2::transfer::share_object<NaviPosition<T0>>(v6);
    }

    fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun force_redeem<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &NaviPosition<T0>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg1, arg0);
        let v0 = NaviAdapter{dummy_field: false};
        let v1 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::force_deallocate<T0, T1, NaviAdapter>(arg0, v0, arg7, arg9);
        let v2 = NaviAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::settle_deallocation<T0, T1, NaviAdapter>(arg0, v1, v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg9, arg2, arg3, arg4, arg1.asset, 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocation_amount(&v1), arg5, arg6, &arg1.cap, arg8, arg10), b"forced", arg9);
    }

    fun from_navi(arg0: u256, arg1: u8, arg2: bool) : u64 {
        let v0 = if (arg1 == 9) {
            arg0
        } else if (arg1 < 9) {
            if (arg2) {
                div_up(arg0, pow10(9 - arg1))
            } else {
                arg0 / pow10(9 - arg1)
            }
        } else {
            arg0 * pow10(arg1 - 9)
        };
        (v0 as u64)
    }

    public fun harvest_claim<T0, T1, T2>(arg0: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg2: &NaviPosition<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg6: vector<0x1::ascii::String>, arg7: vector<address>, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T2>, Harvest) {
        assert_bound<T0, T1>(arg2, arg0);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::is_live_allocator<T0, T1>(arg0, arg1, arg8), 3);
        let v0 = live_value<T0>(arg2, arg3, arg8);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T2>(arg8, arg4, arg3, arg5, arg6, arg7, &arg2.cap);
        let v2 = Harvest{
            position : 0x2::object::id<NaviPosition<T0>>(arg2),
            before   : v0,
            reward   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
            claimed  : 0x2::balance::value<T2>(&v1),
        };
        (v1, v2)
    }

    public fun harvest_finish<T0>(arg0: &NaviPosition<T0>, arg1: Harvest, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock) {
        let Harvest {
            position : v0,
            before   : v1,
            reward   : v2,
            claimed  : v3,
        } = arg1;
        assert!(v0 == 0x2::object::id<NaviPosition<T0>>(arg0), 13);
        let v4 = 0x2::coin::value<T0>(&arg2);
        if (v4 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg3, arg4, arg0.asset, arg2, arg5, arg6, &arg0.cap);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        let v5 = live_value<T0>(arg0, arg3, arg7);
        assert!(v5 >= v1, 12);
        let v6 = Harvested{
            vault        : arg0.vault,
            reward       : v2,
            claimed      : v3,
            supplied     : v4,
            value_before : v1,
            value_after  : v5,
        };
        0x2::event::emit<Harvested>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg0),
            positions : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun live_value<T0>(arg0: &NaviPosition<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1) == arg0.storage, 7);
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset, arg0.owner);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg2, arg1, arg0.asset);
        let v4 = from_navi(v0 * v2 / 1000000000000000000000000000, arg0.decimals, false);
        let v5 = from_navi(div_up(v1 * v3, 1000000000000000000000000000), arg0.decimals, true);
        if (v4 > v5) {
            v4 - v5
        } else {
            0
        }
    }

    public fun migrate<T0, T1>(arg0: &mut NaviPosition<T0>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::CuratorCap) {
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::curator_cap_vault(arg2) == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1) && arg0.vault == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1), 2);
        assert!(arg0.version < 1, 14);
        arg0.version = 1;
    }

    public fun owner<T0>(arg0: &NaviPosition<T0>) : address {
        arg0.owner
    }

    public fun position_vault<T0>(arg0: &NaviPosition<T0>) : 0x2::object::ID {
        arg0.vault
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun recover<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &NaviPosition<T0>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg1, arg0);
        let v0 = NaviAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::recover_impaired<T0, T1, NaviAdapter>(arg0, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg9, arg2, arg3, arg4, arg1.asset, arg7, arg5, arg6, &arg1.cap, arg8, arg10), b"recover", arg9);
    }

    public fun redeem<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg2: &NaviPosition<T0>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: u64, arg9: vector<u8>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg2, arg0);
        let v0 = NaviAdapter{dummy_field: false};
        let v1 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocate<T0, T1, NaviAdapter>(arg0, arg1, v0, arg8, arg11);
        let v2 = NaviAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::settle_deallocation<T0, T1, NaviAdapter>(arg0, v1, v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg11, arg3, arg4, arg5, arg2.asset, 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocation_amount(&v1), arg6, arg7, &arg2.cap, arg10, arg12), arg9, arg11);
    }

    public fun registered(arg0: &Registry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.positions, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.positions, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun sat_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun storage_id<T0>(arg0: &NaviPosition<T0>) : 0x2::object::ID {
        arg0.storage
    }

    public fun supply<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg2: &NaviPosition<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg2, arg0);
        let v0 = live_value<T0>(arg2, arg3, arg9);
        let v1 = NaviAdapter{dummy_field: false};
        let (v2, v3) = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::allocate<T0, T1, NaviAdapter>(arg0, arg1, v1, arg7, arg9);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg9, arg3, arg4, arg2.asset, 0x2::coin::from_balance<T0>(v2, arg10), arg5, arg6, &arg2.cap);
        let v4 = NaviAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::confirm_allocation<T0, T1, NaviAdapter>(arg0, v3, v4, sat_sub(live_value<T0>(arg2, arg3, arg9), v0), arg8);
    }

    public fun supply_apr_bps<T0>(arg0: &NaviPosition<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1) == arg0.storage, 7);
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_current_rate(arg1, arg0.asset);
        ((v0 * 10000 / 1000000000000000000000000000) as u64)
    }

    // decompiled from Move bytecode v7
}

