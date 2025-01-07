module 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserInfo<phantom T0> has store {
        amount: u64,
        reward_debt: u64,
    }

    struct UserCapability<phantom T0> has store {
        user: address,
        is_object: bool,
    }

    struct User has copy, drop, store {
        address: address,
        is_object: bool,
    }

    struct PoolInfo has store {
        alloc_point: u64,
        last_reward_time: u64,
        acc_mole_per_share: u128,
        is_debt_token_pool: bool,
        staked_balance: u64,
    }

    struct PoolInfoStore has store {
        bonus_addr: address,
        dev_percent: u64,
        mole_per_second: u64,
        max_mole_per_second: u64,
        pools: vector<PoolInfo>,
        total_alloc_point: u64,
        coin_mole: 0x2::balance::Balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>,
        stake_debt_token_allowance: 0x2::table::Table<u64, 0x2::table::Table<User, bool>>,
    }

    struct Pool<phantom T0> has store {
        pid: u64,
        coin_staking: 0x2::balance::Balance<T0>,
        user_info: 0x2::table::Table<User, UserInfo<T0>>,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        pool_infos: PoolInfoStore,
        emergency_status: 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::EmergencyStatus,
        pools: 0x2::bag::Bag,
        mole_admin_cap: 0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::AdminCap,
        package_version: u64,
        mole_reward_bounty: 0x2::balance::Balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        user: address,
        pid: u64,
        amount: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        user: address,
        pid: u64,
        amount: u64,
    }

    struct EmergencyWithdrawEvent<phantom T0> has copy, drop {
        user: address,
        pid: u64,
        amount: u64,
    }

    public entry fun add_pool<T0>(arg0: &AdminCap, arg1: &mut Storage, arg2: u64, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(), 2);
        assert!(!exists_pool<T0>(arg1), 3);
        if (arg4) {
            mass_update_pools(arg1, arg5, arg6);
        };
        let v0 = Pool<T0>{
            pid          : pool_length(arg1),
            coin_staking : 0x2::balance::zero<T0>(),
            user_info    : 0x2::table::new<User, UserInfo<T0>>(arg6),
        };
        0x2::bag::add<0x1::string::String, Pool<T0>>(&mut arg1.pools, get_pool_name<T0>(), v0);
        let v1 = &mut arg1.pool_infos;
        let v2 = PoolInfo{
            alloc_point        : arg2,
            last_reward_time   : now_seconds(arg5),
            acc_mole_per_share : 0,
            is_debt_token_pool : arg3,
            staked_balance     : 0,
        };
        0x1::vector::push_back<PoolInfo>(&mut v1.pools, v2);
        v1.total_alloc_point = v1.total_alloc_point + arg2;
    }

    public fun alloc_point<T0>(arg0: &mut Storage) : u64 {
        checked_package_version(arg0);
        let v0 = get_pid<T0>(arg0);
        0x1::vector::borrow<PoolInfo>(&arg0.pool_infos.pools, v0).alloc_point
    }

    public entry fun approve_stake_debt_token(arg0: &AdminCap, arg1: &mut Storage, arg2: u64, arg3: address, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        let v0 = &mut arg1.pool_infos;
        let v1 = &mut v0.stake_debt_token_allowance;
        assert!(0x1::vector::borrow<PoolInfo>(&v0.pools, arg2).is_debt_token_pool, 7);
        let v2 = User{
            address   : arg3,
            is_object : arg4,
        };
        if (!0x2::table::contains<u64, 0x2::table::Table<User, bool>>(v1, arg2)) {
            let v3 = 0x2::table::new<User, bool>(arg6);
            0x2::table::add<User, bool>(&mut v3, v2, arg5);
            0x2::table::add<u64, 0x2::table::Table<User, bool>>(v1, arg2, v3);
        } else {
            let v4 = 0x2::table::borrow_mut<u64, 0x2::table::Table<User, bool>>(v1, arg2);
            if (0x2::table::contains<User, bool>(v4, v2)) {
                *0x2::table::borrow_mut<User, bool>(v4, v2) = arg5;
            } else {
                0x2::table::add<User, bool>(v4, v2, arg5);
            };
        };
    }

    public entry fun approve_stake_debt_tokens(arg0: &AdminCap, arg1: &mut Storage, arg2: vector<u64>, arg3: vector<address>, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<address>(&arg3), 6);
        let v0 = &mut arg1.pool_infos;
        let v1 = &mut v0.stake_debt_token_allowance;
        let v2 = &v0.pools;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg2)) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
            assert!(0x1::vector::borrow<PoolInfo>(v2, v4).is_debt_token_pool, 7);
            let v5 = User{
                address   : *0x1::vector::borrow<address>(&arg3, v3),
                is_object : arg4,
            };
            if (!0x2::table::contains<u64, 0x2::table::Table<User, bool>>(v1, v4)) {
                let v6 = 0x2::table::new<User, bool>(arg6);
                0x2::table::add<User, bool>(&mut v6, v5, arg5);
                0x2::table::add<u64, 0x2::table::Table<User, bool>>(v1, v4, v6);
            } else {
                let v7 = 0x2::table::borrow_mut<u64, 0x2::table::Table<User, bool>>(v1, v4);
                if (0x2::table::contains<User, bool>(v7, v5)) {
                    *0x2::table::borrow_mut<User, bool>(v7, v5) = arg5;
                } else {
                    0x2::table::add<User, bool>(v7, v5, arg5);
                };
            };
            v3 = v3 + 1;
        };
    }

    fun borrow_mut_pool<T0>(arg0: &mut Storage) : &mut Pool<T0> {
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0>>(&mut arg0.pools, get_pool_name<T0>())
    }

    fun borrow_mut_pool_from_pools<T0>(arg0: &mut 0x2::bag::Bag) : &mut Pool<T0> {
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0>>(arg0, get_pool_name<T0>())
    }

    fun borrow_mut_user_info<T0>(arg0: &mut Pool<T0>, arg1: User) : &mut UserInfo<T0> {
        if (!0x2::table::contains<User, UserInfo<T0>>(&mut arg0.user_info, arg1)) {
            let v0 = UserInfo<T0>{
                amount      : 0,
                reward_debt : 0,
            };
            0x2::table::add<User, UserInfo<T0>>(&mut arg0.user_info, arg1, v0);
        };
        0x2::table::borrow_mut<User, UserInfo<T0>>(&mut arg0.user_info, arg1)
    }

    public fun checked_package_version(arg0: &Storage) {
        assert!(arg0.package_version == 1, 18);
    }

    fun compute_reward_debt(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / (1000000000000 as u128)) as u64)
    }

    public entry fun deposit<T0>(arg0: &mut Storage, arg1: address, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0x2::coin::zero<T0>(arg5);
        0x2::pay::join_vec<T0>(&mut v0, arg2);
        deposit_single<T0>(arg0, arg1, v0, arg3, arg4, arg5);
    }

    public entry fun deposit_single<T0>(arg0: &mut Storage, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0x2::coin::split<T0>(&mut arg2, arg3, arg5);
        if (0x2::coin::value<T0>(&arg2) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        let v1 = UserCapability<T0>{
            user      : 0x2::tx_context::sender(arg5),
            is_object : false,
        };
        let UserCapability {
            user      : _,
            is_object : _,
        } = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>>(deposit_with_cap<T0>(arg0, &v1, arg1, false, v0, arg4, arg5), arg1);
    }

    public fun deposit_with_cap<T0>(arg0: &mut Storage, arg1: &UserCapability<T0>, arg2: address, arg3: bool, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE> {
        checked_package_version(arg0);
        0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::assert_no_emergency(&arg0.emergency_status);
        let v0 = arg1.user;
        let v1 = get_pid<T0>(arg0);
        update_pool(arg0, v1, arg5, arg6);
        let v2 = &mut arg0.pools;
        let v3 = borrow_mut_pool_from_pools<T0>(v2);
        let v4 = &mut arg0.pool_infos;
        let v5 = 0x1::vector::borrow_mut<PoolInfo>(&mut v4.pools, v1);
        let v6 = &v4.stake_debt_token_allowance;
        if (v5.is_debt_token_pool && !is_stake_debt_token_allow_inner(v6, v1, get_user_from_cap<T0>(arg1))) {
            abort 8
        };
        if (!v5.is_debt_token_pool && v0 != arg2) {
            abort 8
        };
        let v7 = User{
            address   : arg2,
            is_object : arg3,
        };
        let v8 = borrow_mut_user_info<T0>(v3, v7);
        v8.amount = v8.amount + 0x2::coin::value<T0>(&arg4);
        v8.reward_debt = compute_reward_debt(v8.amount, v5.acc_mole_per_share);
        0x2::balance::join<T0>(&mut v3.coin_staking, 0x2::coin::into_balance<T0>(arg4));
        v5.staked_balance = 0x2::balance::value<T0>(&v3.coin_staking);
        let v9 = &mut v4.coin_mole;
        let v10 = DepositEvent<T0>{
            user   : v0,
            pid    : v1,
            amount : 0x2::coin::value<T0>(&arg4),
        };
        0x2::event::emit<DepositEvent<T0>>(v10);
        safe_mole_extract(v9, compute_reward_debt(v8.amount, v5.acc_mole_per_share) - v8.reward_debt, arg6)
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::assert_no_emergency(&arg0.emergency_status);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = User{
            address   : v0,
            is_object : false,
        };
        let v2 = get_pid<T0>(arg0);
        let v3 = &mut arg0.pools;
        let v4 = borrow_mut_pool_from_pools<T0>(v3);
        let v5 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_infos.pools, v2);
        if (v5.is_debt_token_pool) {
            abort 8
        };
        let v6 = borrow_mut_user_info<T0>(v4, v1);
        let v7 = v6.amount;
        v6.amount = 0;
        v6.reward_debt = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4.coin_staking, v7), arg1), v0);
        v5.staked_balance = 0x2::balance::value<T0>(&v4.coin_staking);
        let v8 = EmergencyWithdrawEvent<T0>{
            user   : v0,
            pid    : v2,
            amount : v7,
        };
        0x2::event::emit<EmergencyWithdrawEvent<T0>>(v8);
    }

    public fun exists_pool<T0>(arg0: &Storage) : bool {
        checked_package_version(arg0);
        0x2::bag::contains<0x1::string::String>(&arg0.pools, get_pool_name<T0>())
    }

    public fun extract_user_cap<T0>(arg0: &AdminCap, arg1: address, arg2: bool) : UserCapability<T0> {
        UserCapability<T0>{
            user      : arg1,
            is_object : arg2,
        }
    }

    public fun get_pid<T0>(arg0: &mut Storage) : u64 {
        checked_package_version(arg0);
        borrow_mut_pool<T0>(arg0).pid
    }

    public fun get_pool_name<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"p-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    fun get_user_from_cap<T0>(arg0: &UserCapability<T0>) : User {
        User{
            address   : arg0.user,
            is_object : arg0.is_object,
        }
    }

    public entry fun harvest<T0>(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = UserCapability<T0>{
            user      : 0x2::tx_context::sender(arg2),
            is_object : false,
        };
        let v1 = harvest_with_cap<T0>(arg0, &v0, arg1, arg2);
        let UserCapability {
            user      : _,
            is_object : _,
        } = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun harvest_with_cap<T0>(arg0: &mut Storage, arg1: &UserCapability<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE> {
        checked_package_version(arg0);
        0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::assert_no_emergency(&arg0.emergency_status);
        let v0 = get_pid<T0>(arg0);
        update_pool(arg0, v0, arg2, arg3);
        let v1 = &mut arg0.pools;
        let v2 = borrow_mut_pool_from_pools<T0>(v1);
        let v3 = &mut arg0.pool_infos;
        let v4 = borrow_mut_user_info<T0>(v2, get_user_from_cap<T0>(arg1));
        let v5 = compute_reward_debt(v4.amount, 0x1::vector::borrow_mut<PoolInfo>(&mut v3.pools, v0).acc_mole_per_share);
        let v6 = &mut v3.coin_mole;
        v4.reward_debt = v5;
        safe_mole_extract(v6, v5 - v4.reward_debt, arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize(arg0: &AdminCap, arg1: 0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolInfoStore{
            bonus_addr                 : arg5,
            dev_percent                : arg2,
            mole_per_second            : arg3,
            max_mole_per_second        : arg4,
            pools                      : 0x1::vector::empty<PoolInfo>(),
            total_alloc_point          : 0,
            coin_mole                  : 0x2::balance::zero<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(),
            stake_debt_token_allowance : 0x2::table::new<u64, 0x2::table::Table<User, bool>>(arg6),
        };
        let v1 = Storage{
            id                 : 0x2::object::new(arg6),
            pool_infos         : v0,
            emergency_status   : 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::initialize(arg6),
            pools              : 0x2::bag::new(arg6),
            mole_admin_cap     : arg1,
            package_version    : 1,
            mole_reward_bounty : 0x2::balance::zero<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(),
        };
        0x2::transfer::share_object<Storage>(v1);
    }

    public fun is_stake_debt_token_allow(arg0: &Storage, arg1: u64, arg2: address, arg3: bool) : bool {
        checked_package_version(arg0);
        let v0 = User{
            address   : arg2,
            is_object : arg3,
        };
        is_stake_debt_token_allow_inner(&arg0.pool_infos.stake_debt_token_allowance, arg1, v0)
    }

    fun is_stake_debt_token_allow_inner(arg0: &0x2::table::Table<u64, 0x2::table::Table<User, bool>>, arg1: u64, arg2: User) : bool {
        if (0x2::table::contains<u64, 0x2::table::Table<User, bool>>(arg0, arg1)) {
            let v0 = 0x2::table::borrow<u64, 0x2::table::Table<User, bool>>(arg0, arg1);
            if (0x2::table::contains<User, bool>(v0, arg2)) {
                return *0x2::table::borrow<User, bool>(v0, arg2)
            };
        };
        false
    }

    public entry fun manual_mint(arg0: &AdminCap, arg1: &mut Storage, arg2: &mut 0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MoleCoinInfo, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::manual_mint(&mut arg1.mole_admin_cap, arg2, arg3, arg4, arg5);
    }

    public fun mass_update_pools(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolInfo>(&mut arg0.pool_infos.pools)) {
            update_pool(arg0, v0, arg1, arg2);
            v0 = v0 + 1;
        };
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 2000);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun pause(arg0: &0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::EmergencyAdminCap, arg1: &mut Storage) {
        checked_package_version(arg1);
        0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::pause(arg0, &mut arg1.emergency_status);
    }

    public fun pending_mole<T0>(arg0: &mut Storage, arg1: address, arg2: bool, arg3: &0x2::clock::Clock) : u64 {
        checked_package_version(arg0);
        let v0 = &mut arg0.pools;
        let v1 = borrow_mut_pool_from_pools<T0>(v0);
        let v2 = &arg0.pool_infos;
        let v3 = 0x1::vector::borrow<PoolInfo>(&v2.pools, v1.pid);
        let v4 = User{
            address   : arg1,
            is_object : arg2,
        };
        let v5 = borrow_mut_user_info<T0>(v1, v4);
        let v6 = v3.acc_mole_per_share;
        let v7 = v6;
        let v8 = v3.staked_balance;
        let v9 = now_seconds(arg3);
        if (v9 > v3.last_reward_time && v8 != 0) {
            v7 = v6 + mul_to_u128((v9 - v3.last_reward_time) * v2.mole_per_second * v3.alloc_point / v2.total_alloc_point, 1000000000000) / (v8 as u128);
        };
        compute_reward_debt(v5.amount, v7) - v5.reward_debt
    }

    public fun pool_length(arg0: &Storage) : u64 {
        checked_package_version(arg0);
        0x1::vector::length<PoolInfo>(&arg0.pool_infos.pools)
    }

    public entry fun resume(arg0: &0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::EmergencyAdminCap, arg1: &mut Storage) {
        checked_package_version(arg1);
        0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::resume(arg0, &mut arg1.emergency_status);
    }

    fun safe_mole_extract(arg0: &mut 0x2::balance::Balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE> {
        if (arg1 == 0) {
            return 0x2::coin::zero<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(arg2)
        };
        let v0 = 0x2::balance::value<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(arg0);
        if (arg1 > v0) {
            return 0x2::coin::from_balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(0x2::balance::split<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(arg0, v0), arg2)
        };
        0x2::coin::from_balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(0x2::balance::split<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(arg0, arg1), arg2)
    }

    public entry fun set_dev(arg0: &mut Storage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = &mut arg0.pool_infos;
        assert!(v0.bonus_addr == 0x2::tx_context::sender(arg2), 8);
        v0.bonus_addr = arg1;
    }

    public entry fun set_max_mole_per_second(arg0: &AdminCap, arg1: &mut Storage, arg2: u64) {
        checked_package_version(arg1);
        let v0 = &mut arg1.pool_infos;
        assert!(arg2 >= v0.mole_per_second, 4);
        v0.max_mole_per_second = arg2;
    }

    public entry fun set_mole_per_second(arg0: &AdminCap, arg1: &mut Storage, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        if (arg3) {
            mass_update_pools(arg1, arg4, arg5);
        };
        let v0 = &mut arg1.pool_infos;
        assert!(arg2 <= v0.max_mole_per_second, 4);
        v0.mole_per_second = arg2;
    }

    public entry fun set_pool<T0>(arg0: &AdminCap, arg1: &mut Storage, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        if (arg3) {
            mass_update_pools(arg1, arg4, arg5);
        };
        let v0 = borrow_mut_pool<T0>(arg1);
        let v1 = v0.pid;
        let v2 = &mut arg1.pool_infos;
        let v3 = 0x1::vector::borrow_mut<PoolInfo>(&mut v2.pools, v1);
        v2.total_alloc_point = v2.total_alloc_point - v3.alloc_point + arg2;
        v3.alloc_point = arg2;
    }

    public fun total_alloc_point(arg0: &mut Storage) : u64 {
        checked_package_version(arg0);
        arg0.pool_infos.total_alloc_point
    }

    public fun update_pool(arg0: &mut Storage, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = &mut arg0.pool_infos;
        let v1 = 0x1::vector::borrow_mut<PoolInfo>(&mut v0.pools, arg1);
        if (now_seconds(arg2) > v1.last_reward_time) {
            if (v1.staked_balance > 0) {
                let v2 = mul_div((now_seconds(arg2) - v1.last_reward_time) * v0.mole_per_second, v1.alloc_point, v0.total_alloc_point);
                0x2::balance::join<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&mut arg0.mole_reward_bounty, 0x2::coin::into_balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::mint(&mut arg0.mole_admin_cap, mul_div(v2, v0.dev_percent, 10000), arg3)));
                0x2::balance::join<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&mut v0.coin_mole, 0x2::coin::into_balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::mint(&mut arg0.mole_admin_cap, v2, arg3)));
                v1.acc_mole_per_share = v1.acc_mole_per_share + mul_to_u128(v2, 1000000000000) / (v1.staked_balance as u128);
            };
            v1.last_reward_time = now_seconds(arg2);
        };
    }

    entry fun upgrade_mole_coin_version(arg0: &AdminCap, arg1: &mut Storage, arg2: u64) {
        0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::upgrade_package_version(&mut arg1.mole_admin_cap, arg2);
    }

    entry fun upgrade_package_version(arg0: &AdminCap, arg1: &mut Storage, arg2: u64) {
        arg1.package_version = arg2;
    }

    public entry fun withdraw<T0>(arg0: &mut Storage, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        withdraw_inner<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_all<T0>(arg0: &mut Storage, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = borrow_mut_pool<T0>(arg0);
        let v1 = User{
            address   : arg1,
            is_object : false,
        };
        withdraw_inner<T0>(arg0, arg1, borrow_mut_user_info<T0>(v0, v1).amount, arg2, arg3);
    }

    fun withdraw_inner<T0>(arg0: &mut Storage, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = UserCapability<T0>{
            user      : v0,
            is_object : false,
        };
        let (v2, v3) = withdraw_with_cap<T0>(arg0, &v1, arg1, false, arg2, arg3, arg4);
        let UserCapability {
            user      : _,
            is_object : _,
        } = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>>(v3, v0);
    }

    public entry fun withdraw_mole_rewards_bounty<T0, T1, T2>(arg0: &AdminCap, arg1: &mut Storage, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        if (arg2) {
            arg3 = 0x2::balance::value<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&arg1.mole_reward_bounty);
        } else {
            assert!(arg3 <= 0x2::balance::value<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&arg1.mole_reward_bounty), 19);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>>(0x2::coin::from_balance<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(0x2::balance::split<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>(&mut arg1.mole_reward_bounty, arg3), arg4), arg1.pool_infos.bonus_addr);
    }

    public fun withdraw_with_cap<T0>(arg0: &mut Storage, arg1: &UserCapability<T0>, arg2: address, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x81ab0208cd5b4edb97d655fcb8ca456a078ef05a54c18b104a10e223872cb9cc::mole::MOLE>) {
        checked_package_version(arg0);
        0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch_emergency::assert_no_emergency(&arg0.emergency_status);
        let v0 = arg1.user;
        let v1 = get_pid<T0>(arg0);
        update_pool(arg0, v1, arg5, arg6);
        let v2 = &mut arg0.pools;
        let v3 = borrow_mut_pool_from_pools<T0>(v2);
        let v4 = &mut arg0.pool_infos;
        let v5 = 0x1::vector::borrow_mut<PoolInfo>(&mut v4.pools, v1);
        let v6 = &v4.stake_debt_token_allowance;
        if (v5.is_debt_token_pool && !is_stake_debt_token_allow_inner(v6, v1, get_user_from_cap<T0>(arg1))) {
            abort 8
        };
        if (!v5.is_debt_token_pool && v0 != arg2) {
            abort 8
        };
        let v7 = User{
            address   : arg2,
            is_object : arg3,
        };
        let v8 = borrow_mut_user_info<T0>(v3, v7);
        let v9 = v8.reward_debt;
        v8.amount = v8.amount - arg4;
        v8.reward_debt = compute_reward_debt(v8.amount, v5.acc_mole_per_share);
        let v10 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3.coin_staking, arg4), arg6);
        v5.staked_balance = 0x2::balance::value<T0>(&v3.coin_staking);
        let v11 = &mut v4.coin_mole;
        let v12 = WithdrawEvent<T0>{
            user   : v0,
            pid    : v1,
            amount : arg4,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v12);
        (v10, safe_mole_extract(v11, compute_reward_debt(v8.amount, v5.acc_mole_per_share) - v9, arg6))
    }

    // decompiled from Move bytecode v6
}

