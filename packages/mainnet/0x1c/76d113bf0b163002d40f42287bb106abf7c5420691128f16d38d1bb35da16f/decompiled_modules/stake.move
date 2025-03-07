module 0x1c76d113bf0b163002d40f42287bb106abf7c5420691128f16d38d1bb35da16f::stake {
    struct StakingPool has store {
        sui_staked: u64,
        navx_staked: u64,
        usdc_staked: u64,
        sui_redeemed: u64,
        navx_redeemed: u64,
        usdc_redeemed: u64,
    }

    struct StakingOrder has copy, drop, store {
        id: u64,
        token: vector<u8>,
        amount: u64,
        timestamp: u64,
        status: u8,
        interest: u64,
    }

    struct YubiBao has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, vector<StakingOrder>>,
        order_count: u64,
        staking_pool: StakingPool,
        vault: Vault,
        admin: address,
    }

    struct Vault has store {
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        sui_index: u8,
        usdc_index: u8,
    }

    public fun balanceToken<T0>(arg0: &YubiBao, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = &arg0.vault;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v0.sui_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v0.account_cap)) as u64))
    }

    fun calculate_redemption_amount(arg0: &StakingOrder) : u64 {
        arg0.amount + arg0.interest
    }

    fun depositToken<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    fun find_and_update_order(arg0: &mut vector<StakingOrder>, arg1: u64, arg2: &0x2::clock::Clock) : &mut StakingOrder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StakingOrder>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<StakingOrder>(arg0, v0);
            if (v1.id == arg1) {
                assert!(v1.status == 0, 1);
                let v2 = (0x2::clock::timestamp_ms(arg2) - v1.timestamp) / 3600000;
                v1.status = 1;
                v1.interest = v1.amount * get_daily_interest_rate(v2) * v2 / 10000;
                return v1
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    fun get_daily_interest_rate(arg0: u64) : u64 {
        if (arg0 <= 10) {
            return 10
        };
        if (arg0 <= 20) {
            return 11
        };
        if (arg0 <= 30) {
            return 12
        };
        if (arg0 <= 40) {
            return 13
        };
        if (arg0 <= 50) {
            return 14
        };
        if (arg0 <= 60) {
            return 15
        };
        if (arg0 <= 70) {
            return 16
        };
        if (arg0 <= 80) {
            return 17
        };
        if (arg0 <= 90) {
            return 18
        };
        if (arg0 <= 100) {
            return 19
        };
        if (arg0 <= 110) {
            return 20
        };
        if (arg0 <= 120) {
            return 21
        };
        if (arg0 <= 130) {
            return 22
        };
        if (arg0 <= 140) {
            return 23
        };
        24
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
            sui_index   : 0,
            usdc_index  : 1,
        };
        let v1 = StakingPool{
            sui_staked    : 0,
            navx_staked   : 0,
            usdc_staked   : 0,
            sui_redeemed  : 0,
            navx_redeemed : 0,
            usdc_redeemed : 0,
        };
        let v2 = YubiBao{
            id           : 0x2::object::new(arg0),
            users        : 0x2::table::new<address, vector<StakingOrder>>(arg0),
            order_count  : 1,
            staking_pool : v1,
            vault        : v0,
            admin        : @0x58d7aaea1d2abc94a65e2d7c50bffcc0b428c29d4e88c483aa6ece3623cf1aff,
        };
        0x2::transfer::share_object<YubiBao>(v2);
    }

    public fun orderList(arg0: &YubiBao, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<StakingOrder> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &arg0.users;
        if (!0x2::table::contains<address, vector<StakingOrder>>(v1, v0)) {
            return 0x1::vector::empty<StakingOrder>()
        };
        let v2 = 0x2::table::borrow<address, vector<StakingOrder>>(v1, v0);
        let v3 = 0x1::vector::empty<StakingOrder>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<StakingOrder>(v2)) {
            let v5 = 0x1::vector::borrow<StakingOrder>(v2, v4);
            let v6 = (0x2::clock::timestamp_ms(arg1) - v5.timestamp) / 3600000;
            let v7 = if (v5.status == 1) {
                v5.interest
            } else {
                v5.amount * get_daily_interest_rate(v6) * v6 / 10000
            };
            let v8 = StakingOrder{
                id        : v5.id,
                token     : v5.token,
                amount    : v5.amount,
                timestamp : v5.timestamp,
                status    : v5.status,
                interest  : v7,
            };
            0x1::vector::push_back<StakingOrder>(&mut v3, v8);
            v4 = v4 + 1;
        };
        v3
    }

    public entry fun redemptionSUI<T0>(arg0: u64, arg1: &mut YubiBao, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::table::borrow_mut<address, vector<StakingOrder>>(&mut arg1.users, v0);
        let v2 = calculate_redemption_amount(find_and_update_order(v1, arg0, arg7));
        arg1.staking_pool.usdc_redeemed = arg1.staking_pool.usdc_redeemed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawToken<T0>(&arg1.vault, v2, arg2, arg3, arg4, arg5, arg7, arg6, arg8), v0);
    }

    public fun setAdmin(arg0: &mut YubiBao, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x58d7aaea1d2abc94a65e2d7c50bffcc0b428c29d4e88c483aa6ece3623cf1aff == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    public entry fun stakeSUI<T0>(arg0: &mut YubiBao, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = &mut arg0.users;
        let v3 = &mut arg0.staking_pool;
        let v4 = StakingOrder{
            id        : arg0.order_count,
            token     : b"SUI",
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg6),
            status    : 0,
            interest  : 0,
        };
        arg0.order_count = arg0.order_count + 1;
        if (!0x2::table::contains<address, vector<StakingOrder>>(v2, v0)) {
            0x2::table::add<address, vector<StakingOrder>>(v2, v0, 0x1::vector::empty<StakingOrder>());
        };
        v3.usdc_staked = v3.usdc_staked + v1;
        0x1::vector::push_back<StakingOrder>(0x2::table::borrow_mut<address, vector<StakingOrder>>(v2, v0), v4);
        depositToken<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdrawSUI<T0>(arg0: u64, arg1: address, arg2: &YubiBao, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.admin == 0x2::tx_context::sender(arg9), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawToken<T0>(&arg2.vault, arg0, arg3, arg4, arg5, arg6, arg8, arg7, arg9), arg1);
    }

    fun withdrawToken<T0>(arg0: &Vault, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg6, arg7, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap), arg8)
    }

    // decompiled from Move bytecode v6
}

