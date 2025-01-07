module 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::tocen_event_ido {
    struct PoolDeposit has copy, drop, store {
        timestamp_start: u64,
        timestamp_end: u64,
        user_buy_min: u64,
        user_buy_max: u64,
        total_sale: u64,
        supply: u64,
    }

    struct Deposited has copy, drop, store {
        check_private: u64,
        balance_private: u64,
        check_public: u64,
        balance_public: u64,
    }

    struct TocenIdoData has store, key {
        id: 0x2::object::UID,
        pool_private: PoolDeposit,
        pool_public: PoolDeposit,
        balance_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BuyCoin has copy, drop {
        owner_buy: address,
        balance_sui: u64,
        pool_deposit: 0x1::string::String,
    }

    public entry fun buy_coins_with_private(arg0: &mut TocenIdoData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_private.timestamp_start <= 0x2::clock::timestamp_ms(arg3), 2);
        assert!(arg0.pool_private.timestamp_end >= 0x2::clock::timestamp_ms(arg3), 2);
        assert!(arg0.pool_private.user_buy_max >= arg2, 4);
        assert!(arg0.pool_private.user_buy_min <= arg2, 3);
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg4))) {
            let v0 = Deposited{
                check_private   : 0,
                balance_private : 0,
                check_public    : 0,
                balance_public  : 0,
            };
            0x2::dynamic_field::add<address, Deposited>(&mut arg0.id, 0x2::tx_context::sender(arg4), v0);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<address, Deposited>(&mut arg0.id, 0x2::tx_context::sender(arg4));
        let v2 = &mut v1.check_private;
        let v3 = &mut v1.balance_private;
        assert!(*v2 == 0, 5);
        *v3 = *v3 + arg2;
        let v4 = &mut arg0.balance_deposit;
        transferSui(v4, arg1, arg2, arg4);
        *v2 = 1;
        arg0.pool_private.total_sale = arg0.pool_private.total_sale + arg2;
        let v5 = BuyCoin{
            owner_buy    : 0x2::tx_context::sender(arg4),
            balance_sui  : arg2,
            pool_deposit : 0x1::string::utf8(b"private"),
        };
        0x2::event::emit<BuyCoin>(v5);
    }

    public entry fun buy_coins_with_public(arg0: &mut TocenIdoData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_public.timestamp_start <= 0x2::clock::timestamp_ms(arg3), 2);
        assert!(arg0.pool_public.timestamp_end >= 0x2::clock::timestamp_ms(arg3), 2);
        assert!(arg0.pool_public.user_buy_max >= arg2, 4);
        assert!(arg0.pool_public.user_buy_min <= arg2, 3);
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg4))) {
            let v0 = Deposited{
                check_private   : 0,
                balance_private : 0,
                check_public    : 0,
                balance_public  : 0,
            };
            0x2::dynamic_field::add<address, Deposited>(&mut arg0.id, 0x2::tx_context::sender(arg4), v0);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<address, Deposited>(&mut arg0.id, 0x2::tx_context::sender(arg4));
        let v2 = &mut v1.check_public;
        let v3 = &mut v1.balance_public;
        assert!(*v2 == 0, 5);
        *v3 = *v3 + arg2;
        let v4 = &mut arg0.balance_deposit;
        transferSui(v4, arg1, arg2, arg4);
        *v2 = 1;
        arg0.pool_public.total_sale = arg0.pool_public.total_sale + arg2;
        let v5 = BuyCoin{
            owner_buy    : 0x2::tx_context::sender(arg4),
            balance_sui  : arg2,
            pool_deposit : 0x1::string::utf8(b"public"),
        };
        0x2::event::emit<BuyCoin>(v5);
    }

    public fun get_balance_private_deposit(arg0: &TocenIdoData, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::dynamic_field::borrow<address, Deposited>(&arg0.id, 0x2::tx_context::sender(arg1));
        (v0.check_private, v0.balance_private)
    }

    public fun get_balance_public_deposit(arg0: &TocenIdoData, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::dynamic_field::borrow<address, Deposited>(&arg0.id, 0x2::tx_context::sender(arg1));
        (v0.check_public, v0.balance_public)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        init_ido(arg0);
    }

    public fun init_ido(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolDeposit{
            timestamp_start : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_time_start_private(),
            timestamp_end   : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_time_end_private(),
            user_buy_min    : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_user_buy_min_private(),
            user_buy_max    : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_user_buy_max_private(),
            total_sale      : 0,
            supply          : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_supply_private(),
        };
        let v1 = PoolDeposit{
            timestamp_start : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_time_start_public(),
            timestamp_end   : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_time_end_public(),
            user_buy_min    : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_user_buy_min_public(),
            user_buy_max    : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_user_buy_max_public(),
            total_sale      : 0,
            supply          : 0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::utils::get_supply_public(),
        };
        let v2 = TocenIdoData{
            id              : 0x2::object::new(arg0),
            pool_private    : v0,
            pool_public     : v1,
            balance_deposit : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<TocenIdoData>(v2);
    }

    fun transferSui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 6);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_time_private(arg0: &mut TocenIdoData, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.pool_private.timestamp_start = arg2;
        } else if (arg1 == 2) {
            arg0.pool_private.timestamp_end = arg2;
        };
    }

    public entry fun update_time_public(arg0: &mut TocenIdoData, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::witness::check_owner(arg3), 1);
        if (arg1 == 1) {
            arg0.pool_public.timestamp_start = arg2;
        } else if (arg1 == 2) {
            arg0.pool_public.timestamp_end = arg2;
        };
    }

    public entry fun withraw(arg0: &mut TocenIdoData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2f6caff123c91121d4cc31f23a284d04a01efd19b09ece313fd172d697657228::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_deposit, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

