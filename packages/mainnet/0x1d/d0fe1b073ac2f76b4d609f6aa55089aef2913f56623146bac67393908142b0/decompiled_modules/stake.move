module 0xb89c30af3ad1fb6723a194994aed2ff01116bb44d7b63e875032b3ac3c742181::stake {
    struct StakingPool has store {
        sui_staked: u64,
        navx_staked: u64,
        usdc_staked: u64,
        sui_redeemed: u64,
        navx_redeemed: u64,
        usdc_redeemed: u64,
        sui_withdraw: u64,
        usdc_withdraw: u64,
        navx_withdraw: u64,
    }

    struct StakingOrder has copy, drop, store {
        id: u64,
        token: vector<u8>,
        asset: u8,
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
    }

    public fun balanceToken<T0>(arg0: &YubiBao, arg1: u8, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.vault.account_cap)) as u64))
    }

    fun calculate_redemption_amount(arg0: &StakingOrder) : u64 {
        arg0.amount + arg0.interest
    }

    fun depositToken<T0>(arg0: &Vault, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg3, arg4, arg1, arg2, arg5, arg6, &arg0.account_cap);
    }

    fun find_and_syn_update_order(arg0: &mut vector<StakingOrder>, arg1: &StakingOrder) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StakingOrder>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<StakingOrder>(arg0, v0);
            if (v1.id == arg1.id) {
                v1.status = arg1.status;
                v1.token = arg1.token;
                v1.asset = arg1.asset;
                v1.amount = arg1.amount;
                v1.timestamp = arg1.timestamp;
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun find_and_update_order(arg0: &mut vector<StakingOrder>, arg1: u64, arg2: &0x2::clock::Clock) : &mut StakingOrder {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StakingOrder>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<StakingOrder>(arg0, v0);
            if (v1.id == arg1) {
                assert!(v1.status == 0, 1);
                let v2 = (0x2::clock::timestamp_ms(arg2) - v1.timestamp) / 86400000;
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
        let v0 = Vault{account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)};
        let v1 = StakingPool{
            sui_staked    : 0,
            navx_staked   : 0,
            usdc_staked   : 0,
            sui_redeemed  : 0,
            navx_redeemed : 0,
            usdc_redeemed : 0,
            sui_withdraw  : 0,
            usdc_withdraw : 0,
            navx_withdraw : 0,
        };
        let v2 = YubiBao{
            id           : 0x2::object::new(arg0),
            users        : 0x2::table::new<address, vector<StakingOrder>>(arg0),
            order_count  : 1,
            staking_pool : v1,
            vault        : v0,
            admin        : @0xd2e6348bb97e8d1ae03535d2415550b3c0b603384ca9e2abcd0e6122df6b6452,
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
            let v6 = (0x2::clock::timestamp_ms(arg1) - v5.timestamp) / 86400000;
            let v7 = if (v5.status == 1) {
                v5.interest
            } else {
                v5.amount * get_daily_interest_rate(v6) * v6 / 10000
            };
            let v8 = StakingOrder{
                id        : v5.id,
                token     : v5.token,
                asset     : v5.asset,
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

    public entry fun redemption<T0>(arg0: u64, arg1: &mut YubiBao, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::table::borrow_mut<address, vector<StakingOrder>>(&mut arg1.users, v0);
        let v2 = find_and_update_order(v1, arg0, arg7);
        let v3 = calculate_redemption_amount(v2);
        if (v2.asset == 0) {
            arg1.staking_pool.sui_redeemed = arg1.staking_pool.sui_redeemed + v3;
        } else if (v2.asset == 10) {
            arg1.staking_pool.usdc_redeemed = arg1.staking_pool.usdc_redeemed + v3;
        } else if (v2.asset == 7) {
            arg1.staking_pool.navx_redeemed = arg1.staking_pool.navx_redeemed + v3;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawToken<T0>(&arg1.vault, v2.asset, v3, arg2, arg3, arg4, arg5, arg7, arg6, arg8), v0);
    }

    public fun setAdmin(arg0: &mut YubiBao, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xfec2432232f6a7a9dd1fdbdab5d44ec0ecf6ca104cdee0e7f0adc66c3bff2e61 == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    public entry fun stakeSysToken<T0>(arg0: &mut YubiBao, arg1: address, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg7), 10);
        let v0 = &mut arg0.users;
        let v1 = &mut arg0.staking_pool;
        let v2 = if (arg3 == 0) {
            v1.sui_staked = v1.sui_staked + arg4;
            b"SUI"
        } else if (arg3 == 10) {
            v1.usdc_staked = v1.usdc_staked + arg4;
            b"USDC"
        } else {
            assert!(arg3 == 7, 10);
            v1.navx_staked = v1.navx_staked + arg4;
            b"NAVX"
        };
        let v3 = StakingOrder{
            id        : arg2,
            token     : v2,
            asset     : arg3,
            amount    : arg4,
            timestamp : arg5,
            status    : arg6,
            interest  : 0,
        };
        arg0.order_count = arg0.order_count + 1;
        if (!0x2::table::contains<address, vector<StakingOrder>>(v0, arg1)) {
            0x2::table::add<address, vector<StakingOrder>>(v0, arg1, 0x1::vector::empty<StakingOrder>());
        };
        let v4 = 0x2::table::borrow_mut<address, vector<StakingOrder>>(&mut arg0.users, arg1);
        let v5 = find_and_syn_update_order(v4, &v3);
        if (!v5) {
            0x1::vector::push_back<StakingOrder>(v4, v3);
        };
    }

    public entry fun stakeToken<T0>(arg0: &mut YubiBao, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = &mut arg0.users;
        let v3 = &mut arg0.staking_pool;
        let v4 = &arg0.vault;
        let v5 = if (arg1 == 0) {
            v3.sui_staked = v3.sui_staked + v1;
            b"SUI"
        } else if (arg1 == 10) {
            v3.usdc_staked = v3.usdc_staked + v1;
            b"USDC"
        } else {
            assert!(arg1 == 7, 10);
            v3.navx_staked = v3.navx_staked + v1;
            b"NAVX"
        };
        let v6 = StakingOrder{
            id        : arg0.order_count,
            token     : v5,
            asset     : arg1,
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg7),
            status    : 0,
            interest  : 0,
        };
        arg0.order_count = arg0.order_count + 1;
        if (!0x2::table::contains<address, vector<StakingOrder>>(v2, v0)) {
            0x2::table::add<address, vector<StakingOrder>>(v2, v0, 0x1::vector::empty<StakingOrder>());
        };
        0x1::vector::push_back<StakingOrder>(0x2::table::borrow_mut<address, vector<StakingOrder>>(v2, v0), v6);
        depositToken<T0>(v4, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun withdraw<T0>(arg0: u64, arg1: address, arg2: u8, arg3: &mut YubiBao, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.admin == 0x2::tx_context::sender(arg10), 1);
        let v0 = &mut arg3.staking_pool;
        if (arg2 == 0) {
            v0.sui_withdraw = v0.sui_withdraw + arg0;
        } else if (arg2 == 10) {
            v0.usdc_withdraw = v0.usdc_withdraw + arg0;
        } else if (arg2 == 7) {
            v0.navx_withdraw = v0.navx_withdraw + arg0;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdrawToken<T0>(&arg3.vault, arg2, arg0, arg4, arg5, arg6, arg7, arg9, arg8, arg10), arg1);
    }

    fun withdrawToken<T0>(arg0: &Vault, arg1: u8, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg8, arg3, arg4, arg1, arg2, arg5, arg6, &arg0.account_cap), arg9)
    }

    // decompiled from Move bytecode v6
}

