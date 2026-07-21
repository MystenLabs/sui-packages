module 0x7623378eed7bc765d60c6257250c3b79997ef9000a7721ee77912533b4783d8c::main {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct UserSuiReleaseData has copy, drop, store {
        staked_amount: u64,
        released_amount: u64,
        claimed_amount: u64,
        last_release_time: u64,
    }

    struct UserSuiReleaseDataView has copy, drop, store {
        staked_amount: u64,
        released_amount: u64,
        claimed_amount: u64,
        claimable_amount: u64,
        last_release_time: u64,
    }

    struct PoolStats has copy, drop, store {
        total_staked_amount: u64,
        total_running_staked_amount: u64,
        total_released_amount: u64,
        total_claimed_amount: u64,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    struct SuiReleasePool has key {
        id: 0x2::object::UID,
        admin: address,
        robot: address,
        daily_release_bps: u64,
        users: 0x2::table::Table<address, UserSuiReleaseData>,
        total_staked_amount: u64,
        total_running_staked_amount: u64,
        total_released_amount: u64,
        total_claimed_amount: u64,
        vault: Vault,
        version: u64,
    }

    public fun adminWithdrawAmount<T0>(arg0: &mut SuiReleasePool, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg9), 1);
        assert!(arg1 > 0 && arg1 <= 5000000000000, 2);
        check_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg0.admin);
    }

    public fun batch_import_users(arg0: &OwnerCap, arg1: &mut SuiReleasePool, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2);
        check_version(arg1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            if (0x2::table::contains<address, UserSuiReleaseData>(&arg1.users, v2)) {
                let v4 = 0x2::table::borrow_mut<address, UserSuiReleaseData>(&mut arg1.users, v2);
                v4.staked_amount = v4.staked_amount + v3;
            } else {
                let v5 = UserSuiReleaseData{
                    staked_amount     : v3,
                    released_amount   : 0,
                    claimed_amount    : 0,
                    last_release_time : 0x2::clock::timestamp_ms(arg4),
                };
                0x2::table::add<address, UserSuiReleaseData>(&mut arg1.users, v2, v5);
            };
            arg1.total_staked_amount = arg1.total_staked_amount + v3;
            arg1.total_running_staked_amount = arg1.total_running_staked_amount + v3;
            v1 = v1 + 1;
        };
    }

    fun calc_claimable_amount(arg0: &UserSuiReleaseData, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (arg0.released_amount < arg0.claimed_amount) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 < arg0.last_release_time || v0 - arg0.last_release_time < 86400000) {
            return 0
        };
        let v1 = calc_daily_claim_quota(arg0.staked_amount, arg1);
        let v2 = arg0.released_amount - arg0.claimed_amount;
        if (v2 >= v1) {
            v1
        } else {
            let v4 = v1 - v2;
            let v5 = calc_daily_release_amount(arg0.staked_amount, arg0.released_amount, arg1);
            let v6 = if (v5 > v4) {
                v4
            } else {
                v5
            };
            v2 + v6
        }
    }

    fun calc_daily_claim_quota(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    fun calc_daily_release_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        let v0 = arg0 - arg1;
        let v1 = arg0 * arg2 / 10000;
        let v2 = v1;
        if (v1 == 0) {
            v2 = 1;
        };
        if (v2 >= v0) {
            v0
        } else {
            v2
        }
    }

    fun check_version(arg0: &SuiReleasePool) {
        assert!(arg0.version == 1, 2);
    }

    public fun claim_released<T0>(arg0: &mut SuiReleasePool, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0x2::clock::Clock, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<address, UserSuiReleaseData>(&arg0.users, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, UserSuiReleaseData>(&mut arg0.users, v0);
        assert!(v1.released_amount >= v1.claimed_amount, 2);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v2 >= v1.last_release_time && v2 - v1.last_release_time >= 86400000, 4);
        let v3 = calc_daily_claim_quota(v1.staked_amount, arg0.daily_release_bps);
        let v4 = v1.released_amount - v1.claimed_amount;
        let v5 = if (v4 >= v3) {
            v3
        } else {
            let v5 = v4;
            let v6 = v3 - v4;
            let v7 = calc_daily_release_amount(v1.staked_amount, v1.released_amount, arg0.daily_release_bps);
            let v8 = if (v7 > v6) {
                v6
            } else {
                v7
            };
            if (v8 > 0) {
                assert!(v1.released_amount + v8 <= v1.staked_amount, 5);
                v1.released_amount = v1.released_amount + v8;
                arg0.total_released_amount = arg0.total_released_amount + v8;
                arg0.total_running_staked_amount = arg0.total_running_staked_amount - v8;
                v5 = v4 + v8;
            };
            v5
        };
        assert!(v5 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawSui<T0>(&arg0.vault, v5, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), v0);
        v1.claimed_amount = v1.claimed_amount + v5;
        v1.last_release_time = v2;
        arg0.total_claimed_amount = arg0.total_claimed_amount + v5;
    }

    fun depositSui<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    public fun deposit_sui<T0>(arg0: &mut SuiReleasePool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        depositSui<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun get_pool_stats(arg0: &SuiReleasePool) : PoolStats {
        PoolStats{
            total_staked_amount         : arg0.total_staked_amount,
            total_running_staked_amount : arg0.total_running_staked_amount,
            total_released_amount       : arg0.total_released_amount,
            total_claimed_amount        : arg0.total_claimed_amount,
        }
    }

    public fun get_user_data(arg0: &SuiReleasePool, arg1: address) : UserSuiReleaseDataView {
        if (0x2::table::contains<address, UserSuiReleaseData>(&arg0.users, arg1)) {
            let v1 = *0x2::table::borrow<address, UserSuiReleaseData>(&arg0.users, arg1);
            let v2 = if (v1.released_amount >= v1.claimed_amount) {
                v1.released_amount - v1.claimed_amount
            } else {
                0
            };
            UserSuiReleaseDataView{staked_amount: v1.staked_amount, released_amount: v1.released_amount, claimed_amount: v1.claimed_amount, claimable_amount: v2, last_release_time: v1.last_release_time}
        } else {
            UserSuiReleaseDataView{staked_amount: 0, released_amount: 0, claimed_amount: 0, claimable_amount: 0, last_release_time: 0}
        }
    }

    public fun get_user_data_v2(arg0: &SuiReleasePool, arg1: address, arg2: &0x2::clock::Clock) : UserSuiReleaseDataView {
        if (0x2::table::contains<address, UserSuiReleaseData>(&arg0.users, arg1)) {
            let v1 = *0x2::table::borrow<address, UserSuiReleaseData>(&arg0.users, arg1);
            UserSuiReleaseDataView{staked_amount: v1.staked_amount, released_amount: v1.released_amount, claimed_amount: v1.claimed_amount, claimable_amount: calc_claimable_amount(&v1, arg0.daily_release_bps, arg2), last_release_time: v1.last_release_time}
        } else {
            UserSuiReleaseDataView{staked_amount: 0, released_amount: 0, claimed_amount: 0, claimable_amount: 0, last_release_time: 0}
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v2 = SuiReleasePool{
            id                          : 0x2::object::new(arg0),
            admin                       : 0x2::tx_context::sender(arg0),
            robot                       : 0x2::tx_context::sender(arg0),
            daily_release_bps           : 10,
            users                       : 0x2::table::new<address, UserSuiReleaseData>(arg0),
            total_staked_amount         : 0,
            total_running_staked_amount : 0,
            total_released_amount       : 0,
            total_claimed_amount        : 0,
            vault                       : v1,
            version                     : 1,
        };
        0x2::transfer::share_object<SuiReleasePool>(v2);
    }

    public fun robot_daily_release(arg0: &mut SuiReleasePool, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 8
    }

    public fun set_admin(arg0: &OwnerCap, arg1: &mut SuiReleasePool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
    }

    public fun set_daily_release_bps(arg0: &OwnerCap, arg1: &mut SuiReleasePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 7);
        arg1.daily_release_bps = arg2;
    }

    public fun set_robot(arg0: &OwnerCap, arg1: &mut SuiReleasePool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.robot = arg2;
    }

    public fun upgrade_version(arg0: &OwnerCap, arg1: &mut SuiReleasePool, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1.version < 1) {
            arg1.version = 1;
        };
    }

    public fun viewSui<T0>(arg0: &mut SuiReleasePool, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = &arg0.vault;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v0.sui_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v0.account_cap)) as u64))
    }

    fun withdrawSui<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg8, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap, arg7, arg9), arg9)
    }

    // decompiled from Move bytecode v7
}

