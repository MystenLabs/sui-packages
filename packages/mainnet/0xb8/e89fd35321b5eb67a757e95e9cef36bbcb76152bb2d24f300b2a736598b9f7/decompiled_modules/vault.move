module 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
        is_paused: bool,
        performance_fee: u64,
    }

    struct Pools has key {
        id: 0x2::object::UID,
        quantity: u64,
    }

    struct PoolInfo<phantom T0> has key {
        id: 0x2::object::UID,
        pool_account: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        total_users: u64,
        total_reward_token: 0x2::balance::Balance<T0>,
        price_per_full_share: u64,
        users: 0x2::object_table::ObjectTable<address, UserRegistry<T0>>,
        metadata: 0x2::url::Url,
    }

    struct ListedPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u64,
        logo_url: 0x2::url::Url,
    }

    struct UserRegistry<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        stake_amount: u64,
        shares: u64,
    }

    struct CreatePoolEvent has copy, drop {
        stake_token_info: 0x1::string::String,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct HarvestEvent has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    fun balance<T0>(arg0: &PoolInfo<T0>) : u64 {
        available<T0>(arg0) + balanceOfPool<T0>(arg0)
    }

    fun available<T0>(arg0: &PoolInfo<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_reward_token)
    }

    fun balanceOfPool<T0>(arg0: &PoolInfo<T0>) : u64 {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.pool_account)
    }

    public entry fun create_pool<T0>(arg0: &GlobalConfig, arg1: &mut Pools, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 0);
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, v0), 4);
        let v1 = 0x2::object::new(arg8);
        let v2 = PoolInfo<T0>{
            id                   : v1,
            pool_account         : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, arg7, arg8),
            total_users          : 0,
            total_reward_token   : 0x2::balance::zero<T0>(),
            price_per_full_share : 0,
            users                : 0x2::object_table::new<address, UserRegistry<T0>>(arg8),
            metadata             : 0x2::url::new_unsafe_from_bytes(arg5),
        };
        0x2::transfer::share_object<PoolInfo<T0>>(v2);
        let v3 = ListedPool<T0>{
            id        : 0x2::object::new(arg8),
            pool_id   : 0x2::object::uid_to_inner(&v1),
            coin_type : v0,
            symbol    : 0x1::string::utf8(arg3),
            decimals  : arg6,
            logo_url  : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        0x2::dynamic_object_field::add<0x1::string::String, ListedPool<T0>>(&mut arg1.id, v0, v3);
        arg1.quantity = arg1.quantity + 1;
        let v4 = CreatePoolEvent{
            stake_token_info : v0,
            timestamp        : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<CreatePoolEvent>(v4);
    }

    public entry fun deposit<T0>(arg0: &GlobalConfig, arg1: &mut PoolInfo<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &mut 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUICONTROLLER<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg7);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, &mut arg1.pool_account, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg4, arg5, arg7, arg8, arg9), arg8, arg9);
        let v1 = 0x2::tx_context::sender(arg9);
        if (!0x2::object_table::contains<address, UserRegistry<T0>>(&arg1.users, v1)) {
            let v2 = UserRegistry<T0>{
                id           : 0x2::object::new(arg9),
                user         : v1,
                stake_amount : 0,
                shares       : 0,
            };
            0x2::object_table::add<address, UserRegistry<T0>>(&mut arg1.users, v1, v2);
            arg1.total_users = arg1.total_users + 1;
        };
        harvest<T0>(arg0, arg1, arg3, arg2, arg6, arg4, arg5, arg8, arg9);
        let v3 = balance<T0>(arg1);
        let v4 = if (0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::total_supply(arg3) == 0) {
            balance<T0>(arg1) - v3
        } else {
            0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::math::mul_div(balance<T0>(arg1) - v3, 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::total_supply(arg3), v3)
        };
        0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::mint(arg3, v4, v1, arg9);
        let v5 = 0x2::object_table::borrow_mut<address, UserRegistry<T0>>(&mut arg1.users, v1);
        v5.stake_amount = v5.stake_amount + v0;
        v5.shares = v5.shares + v4;
        arg1.price_per_full_share = get_price_per_full_share<T0>(arg1, arg3);
        let v6 = DepositEvent{
            user      : v1,
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<DepositEvent>(v6);
    }

    fun earn<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, arg1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg4, arg5, arg6), arg5, arg6);
    }

    fun get_price_per_full_share<T0>(arg0: &PoolInfo<T0>, arg1: &0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUICONTROLLER<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>) : u64 {
        if (0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::total_supply(arg1) == 0) {
            return 1000000000
        };
        0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::math::mul_div(balance<T0>(arg0), 1000000000, 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::total_supply(arg1))
    }

    public entry fun harvest<T0>(arg0: &GlobalConfig, arg1: &mut PoolInfo<T0>, arg2: &mut 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUICONTROLLER<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        let v0 = 0x2::coin::take<T0>(&mut arg1.total_reward_token, 0x2::balance::value<T0>(&arg1.total_reward_token), arg8);
        0x2::coin::join<T0>(&mut v0, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg3, arg4, &mut arg1.pool_account, arg7, arg8));
        let v1 = 0x2::coin::value<T0>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::math::mul_div(v1, arg0.performance_fee, 100), arg8), arg0.admin);
        let v2 = &mut arg1.pool_account;
        earn<T0>(arg3, v2, arg5, arg6, v0, arg7, arg8);
        arg1.price_per_full_share = get_price_per_full_share<T0>(arg1, arg2);
        let v3 = HarvestEvent{
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<HarvestEvent>(v3);
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VAULT>(arg0, arg1);
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg1),
            admin           : @0x27026d1a84ca1e30f9999449fb416abc4f7a9c77f93fcffcfd4626c67e74c4a1,
            is_paused       : false,
            performance_fee : 10,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v1 = Pools{
            id       : 0x2::object::new(arg1),
            quantity : 0,
        };
        0x2::transfer::share_object<Pools>(v1);
    }

    public entry fun panic<T0>(arg0: &mut GlobalConfig, arg1: &mut PoolInfo<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 0);
        arg0.is_paused = true;
        0x2::balance::join<T0>(&mut arg1.total_reward_token, 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, &mut arg1.pool_account, balanceOfPool<T0>(arg1), arg5, arg6), arg5, arg6)));
    }

    public entry fun pause(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_paused = true;
    }

    public entry fun unpause(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_paused = false;
    }

    public entry fun update_fee(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.performance_fee = arg1;
    }

    public entry fun update_pool_info<T0>(arg0: &mut GlobalConfig, arg1: &mut PoolInfo<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg1.metadata = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public entry fun withdraw<T0>(arg0: &GlobalConfig, arg1: &mut PoolInfo<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &mut 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUICONTROLLER<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg7: vector<0x2::coin::Coin<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::object_table::contains<address, UserRegistry<T0>>(&arg1.users, v0), 3);
        harvest<T0>(arg0, arg1, arg3, arg2, arg6, arg4, arg5, arg9, arg10);
        let v1 = 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::math::mul_div(balance<T0>(arg1), arg8, 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::total_supply(arg3));
        let v2 = v1;
        assert!(v1 > 0, 6);
        let v3 = 0x1::vector::pop_back<0x2::coin::Coin<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>>(&mut arg7);
        0x2::pay::join_vec<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>(&mut v3, arg7);
        assert!(0x2::coin::value<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>(&v3) >= arg8, 5);
        0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::burn(arg3, 0x2::coin::split<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>(&mut v3, arg8, arg10));
        let v4 = available<T0>(arg1);
        if (v4 < v1) {
            let v5 = v1 - v4;
            0x2::balance::join<T0>(&mut arg1.total_reward_token, 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg4, arg5, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, &mut arg1.pool_account, v5, arg9, arg10), arg9, arg10)));
            let v6 = available<T0>(arg1) - v4;
            if (v6 < v5) {
                v2 = v4 + v6;
            };
        };
        let v7 = 0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::math::mul_div(v2, arg0.performance_fee, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.total_reward_token, v7, arg10), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.total_reward_token, v2 - v7, arg10), v0);
        let v8 = 0x2::object_table::borrow_mut<address, UserRegistry<T0>>(&mut arg1.users, v0);
        let v9 = if (v8.shares > arg8) {
            v8.shares - arg8
        } else {
            0
        };
        v8.shares = v9;
        if (0x2::coin::value<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>>(v3, v0);
        } else {
            0x2::coin::destroy_zero<0xb8e89fd35321b5eb67a757e95e9cef36bbcb76152bb2d24f300b2a736598b9f7::psui::PSUI>(v3);
        };
        let v10 = WithdrawEvent{
            user      : v0,
            amount    : v2,
            timestamp : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<WithdrawEvent>(v10);
    }

    // decompiled from Move bytecode v6
}

