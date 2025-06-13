module 0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::invest_platform {
    struct InvestmentPlatform has store, key {
        id: 0x2::object::UID,
        owner: address,
        total_invested: u64,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>,
        is_closed: bool,
        is_buy_enabled: bool,
        amm_initialized: bool,
        investors: vector<InvestorInfo>,
        holders: vector<HolderInfo>,
        fund_holders: vector<FundInfo>,
        reserved_suis: u64,
        reserved_tokens: u64,
        nft_wallet: address,
        lp_wallet: address,
        marketing_wallet: address,
        withdraw_whitelist: address,
        spl_payment_receiver: address,
    }

    struct InvestorInfo has copy, drop, store {
        address: address,
        invested_amount: u64,
        purchased_amount: u64,
    }

    struct HolderInfo has copy, drop, store {
        address: address,
        amount: u64,
    }

    struct FundInfo has copy, drop, store {
        address: address,
        withdraw_amount: u64,
    }

    struct AMMPool has store, key {
        id: 0x2::object::UID,
        owner: address,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>,
    }

    struct Invested has copy, drop {
        buyer: address,
        sui_amount: u64,
    }

    struct SPLUpdated has copy, drop {
        token_holder: address,
        token_amount: u64,
    }

    struct InvestmentClosed has copy, drop {
        total_invested: u64,
        timestamp: u64,
    }

    struct AMMInitialized has copy, drop {
        pool_id: address,
        sui_amount: u64,
        token_amount: u64,
        timestamp: u64,
    }

    struct AMMSwap has copy, drop {
        trader: address,
        sui_amount: u64,
        token_amount: u64,
        is_buy: bool,
    }

    struct SPLPayment has copy, drop {
        trader: address,
        token_amount: u64,
        sui_received: u64,
        recipient: address,
    }

    public entry fun add_fund_holder(arg0: &mut InvestmentPlatform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FundInfo>(&arg0.fund_holders)) {
            if (0x1::vector::borrow<FundInfo>(&arg0.fund_holders, v1).address == arg1) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        if (!v0) {
            let v2 = FundInfo{
                address         : arg1,
                withdraw_amount : 0,
            };
            0x1::vector::push_back<FundInfo>(&mut arg0.fund_holders, v2);
        };
    }

    public entry fun buy_tokens_from_amm(arg0: &mut InvestmentPlatform, arg1: &mut AMMPool, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_closed, 2);
        assert!(arg0.is_buy_enabled, 13);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.amm_initialized, 6);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg2)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 >= arg3, 11);
        if (v2 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v2 - arg3, arg5), v0);
        };
        let v3 = calculate_token_out(arg3, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve), 0x2::balance::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&arg1.token_reserve));
        let v4 = v3 * 50 / 1000;
        let v5 = v3 - v4;
        assert!(v5 >= arg4, 10);
        assert!(0x2::balance::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&arg1.token_reserve) >= v3, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        let v6 = 0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut arg1.token_reserve, v3);
        let v7 = v4 * 20 / 50;
        let v8 = v4 * 10 / 50;
        let v9 = v4 * 10 / 50;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v6, v5), arg5), v0);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v6, v7), arg5), arg0.nft_wallet);
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v6, v8), arg5), arg0.lp_wallet);
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v6, v9), arg5), arg0.marketing_wallet);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(v6, arg5), @0x0);
        let v10 = AMMSwap{
            trader       : v0,
            sui_amount   : arg3,
            token_amount : v5,
            is_buy       : true,
        };
        0x2::event::emit<AMMSwap>(v10);
    }

    fun calculate_token_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 8);
        (((arg2 as u128) * (arg0 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun get_holder_amount(arg0: &InvestmentPlatform, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HolderInfo>(&arg0.holders)) {
            let v1 = 0x1::vector::borrow<HolderInfo>(&arg0.holders, v0);
            if (v1.address == arg1) {
                return v1.amount
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun get_investor_quota(arg0: &InvestmentPlatform, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<InvestorInfo>(&arg0.investors)) {
            let v1 = 0x1::vector::borrow<InvestorInfo>(&arg0.investors, v0);
            if (v1.address == arg1) {
                return v1.invested_amount * 100 / 1000 - v1.purchased_amount
            };
            v0 = v0 + 1;
        };
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        initialize_platform(v0, v0, v0, arg0);
    }

    public entry fun initialize_amm_pool(arg0: &mut InvestmentPlatform, arg1: 0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 0);
        assert!(!arg0.is_closed, 2);
        assert!(!arg0.amm_initialized, 6);
        let v1 = 0x2::coin::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&arg1);
        assert!(v1 >= 10000000, 3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 >= 1000000, 8);
        let v3 = AMMPool{
            id            : 0x2::object::new(arg3),
            owner         : v0,
            sui_reserve   : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve : 0x2::balance::zero<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(),
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v3.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v3.token_reserve, 0x2::coin::into_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(arg1));
        arg0.amm_initialized = true;
        let v4 = AMMInitialized{
            pool_id      : 0x2::object::uid_to_address(&v3.id),
            sui_amount   : v2,
            token_amount : v1,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<AMMInitialized>(v4);
        0x2::transfer::share_object<AMMPool>(v3);
    }

    fun initialize_platform(arg0: address, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = InvestmentPlatform{
            id                   : 0x2::object::new(arg3),
            owner                : 0x2::tx_context::sender(arg3),
            total_invested       : 0,
            sui_reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve        : 0x2::balance::zero<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(),
            is_closed            : false,
            is_buy_enabled       : false,
            amm_initialized      : false,
            investors            : 0x1::vector::empty<InvestorInfo>(),
            holders              : 0x1::vector::empty<HolderInfo>(),
            fund_holders         : 0x1::vector::empty<FundInfo>(),
            reserved_suis        : 0,
            reserved_tokens      : 0,
            nft_wallet           : arg0,
            lp_wallet            : arg1,
            marketing_wallet     : arg2,
            withdraw_whitelist   : 0x2::tx_context::sender(arg3),
            spl_payment_receiver : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::public_share_object<InvestmentPlatform>(v0);
    }

    public entry fun invest(arg0: &mut InvestmentPlatform, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_closed, 1);
        assert!(arg2 > 0, 5);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg1)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg2, 11);
        let v2 = arg0.total_invested + arg2;
        assert!(v2 <= 1000000000000000, 4);
        if (v1 > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1 - arg2, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        arg0.total_invested = v2;
        arg0.reserved_suis = arg0.reserved_suis + arg2 - arg2 * 100 / 1000;
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = false;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<InvestorInfo>(&arg0.investors)) {
            if (0x1::vector::borrow<InvestorInfo>(&arg0.investors, v6).address == v3) {
                v4 = true;
                v5 = v6;
                break
            };
            v6 = v6 + 1;
        };
        if (v4) {
            let v7 = 0x1::vector::borrow_mut<InvestorInfo>(&mut arg0.investors, v5);
            v7.invested_amount = v7.invested_amount + arg2;
        } else {
            let v8 = InvestorInfo{
                address          : v3,
                invested_amount  : arg2,
                purchased_amount : 0,
            };
            0x1::vector::push_back<InvestorInfo>(&mut arg0.investors, v8);
        };
        let v9 = Invested{
            buyer      : v3,
            sui_amount : arg2,
        };
        0x2::event::emit<Invested>(v9);
        if (arg0.total_invested >= 1000000000000000) {
            arg0.is_closed = true;
            let v10 = InvestmentClosed{
                total_invested : arg0.total_invested,
                timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<InvestmentClosed>(v10);
        };
    }

    public entry fun remove_from_fund_holders(arg0: &mut InvestmentPlatform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = false;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<FundInfo>(&arg0.fund_holders)) {
            if (0x1::vector::borrow<FundInfo>(&arg0.fund_holders, v2).address == arg1) {
                v0 = true;
                v1 = v2;
                break
            };
            v2 = v2 + 1;
        };
        if (v0) {
            0x1::vector::swap_remove<FundInfo>(&mut arg0.fund_holders, v1);
        };
    }

    public entry fun sell_tokens_to_amm(arg0: &mut InvestmentPlatform, arg1: &mut AMMPool, arg2: vector<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_closed, 2);
        assert!(arg0.amm_initialized, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&arg2)) {
            0x2::coin::join<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(arg2);
        let v2 = 0x2::coin::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&v1);
        assert!(v2 >= arg3, 11);
        if (v2 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v1, v2 - arg3, arg5), v0);
        };
        let v3 = 0x2::coin::into_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(v1);
        let v4 = arg3 * 50 / 1000;
        let v5 = arg3 - v4;
        let v6 = v4 * 20 / 50;
        let v7 = v4 * 10 / 50;
        let v8 = v4 * 10 / 50;
        let v9 = v4 - v6 - v7 - v8;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v3, v6), arg5), arg0.nft_wallet);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v3, v7), arg5), arg0.lp_wallet);
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v3, v8), arg5), arg0.marketing_wallet);
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v3, v9), arg5), @0x0);
        };
        let v10 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve);
        let v11 = (((v10 as u128) * (v5 as u128) / ((0x2::balance::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&arg1.token_reserve) as u128) + (v5 as u128))) as u64);
        assert!(v11 >= arg4, 9);
        assert!(v10 >= v11, 8);
        0x2::balance::join<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut arg1.token_reserve, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v11), arg5), v0);
        let v12 = AMMSwap{
            trader       : v0,
            sui_amount   : v11,
            token_amount : arg3,
            is_buy       : false,
        };
        0x2::event::emit<AMMSwap>(v12);
    }

    public entry fun spl_payment(arg0: &mut InvestmentPlatform, arg1: &mut AMMPool, arg2: vector<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.amm_initialized, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&arg2)) {
            0x2::coin::join<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(arg2);
        let v2 = 0x2::coin::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&v1);
        assert!(v2 >= arg3, 11);
        if (v2 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v1, v2 - arg3, arg4), v0);
        };
        let v3 = arg3 * 300 / 1000;
        let v4 = arg3 - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v1, v3, arg4), @0x0);
        let v5 = 0x2::coin::into_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(v1);
        let v6 = v4 * 50 / 1000;
        let v7 = v4 - v6;
        let v8 = v6 * 20 / 50;
        let v9 = v6 * 10 / 50;
        let v10 = v6 * 10 / 50;
        let v11 = v6 - v8 - v9 - v10;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v5, v8), arg4), arg0.nft_wallet);
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v5, v9), arg4), arg0.lp_wallet);
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v5, v10), arg4), arg0.marketing_wallet);
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v5, v11), arg4), @0x0);
        };
        let v12 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve);
        let v13 = (((v12 as u128) * (v7 as u128) / ((0x2::balance::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&arg1.token_reserve) as u128) + (v7 as u128))) as u64);
        assert!(v12 >= v13, 8);
        0x2::balance::join<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut arg1.token_reserve, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v13), arg4), v0);
        let v14 = SPLPayment{
            trader       : v0,
            token_amount : arg3,
            sui_received : v13,
            recipient    : arg0.spl_payment_receiver,
        };
        0x2::event::emit<SPLPayment>(v14);
    }

    public entry fun update_core_wallet(arg0: &mut InvestmentPlatform, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        arg0.nft_wallet = arg1;
        arg0.lp_wallet = arg2;
        arg0.marketing_wallet = arg3;
    }

    public entry fun update_investor_info(arg0: &mut InvestmentPlatform, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        let v0 = false;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<InvestorInfo>(&arg0.investors)) {
            if (0x1::vector::borrow<InvestorInfo>(&arg0.investors, v2).address == arg1) {
                v0 = true;
                v1 = v2;
                break
            };
            v2 = v2 + 1;
        };
        if (v0) {
            let v3 = 0x1::vector::borrow_mut<InvestorInfo>(&mut arg0.investors, v1);
            v3.invested_amount = arg2;
            v3.purchased_amount = arg3;
        } else {
            let v4 = InvestorInfo{
                address          : arg1,
                invested_amount  : arg2,
                purchased_amount : arg3,
            };
            0x1::vector::push_back<InvestorInfo>(&mut arg0.investors, v4);
        };
    }

    public entry fun update_platform_buy_flag(arg0: &mut InvestmentPlatform, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.is_buy_enabled = arg1;
    }

    public entry fun update_platform_status(arg0: &mut InvestmentPlatform, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.is_closed = arg1;
    }

    public entry fun update_spl_amount(arg0: &mut InvestmentPlatform, arg1: address, arg2: vector<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_closed, 1);
        assert!(arg3 > 0, 5);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&arg2)) {
            0x2::coin::join<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(arg2);
        let v1 = 0x2::coin::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&v0);
        assert!(v1 >= arg3, 11);
        if (v1 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut v0, v1 - arg3, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::join<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut arg0.token_reserve, 0x2::coin::into_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(v0));
        arg0.reserved_tokens = arg0.reserved_tokens + arg3;
        let v2 = false;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<HolderInfo>(&arg0.holders)) {
            if (0x1::vector::borrow<HolderInfo>(&arg0.holders, v4).address == arg1) {
                v2 = true;
                v3 = v4;
                break
            };
            v4 = v4 + 1;
        };
        if (v2) {
            let v5 = 0x1::vector::borrow_mut<HolderInfo>(&mut arg0.holders, v3);
            v5.amount = v5.amount + arg3;
        } else {
            let v6 = HolderInfo{
                address : arg1,
                amount  : arg3,
            };
            0x1::vector::push_back<HolderInfo>(&mut arg0.holders, v6);
        };
        let v7 = SPLUpdated{
            token_holder : arg1,
            token_amount : arg3,
        };
        0x2::event::emit<SPLUpdated>(v7);
    }

    public entry fun update_spl_payment_receiver(arg0: &mut InvestmentPlatform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.spl_payment_receiver = arg1;
    }

    public entry fun update_withdraw_whitelist(arg0: &mut InvestmentPlatform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.withdraw_whitelist = arg1;
    }

    public entry fun withdraw_all_funds(arg0: &mut InvestmentPlatform, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v1), arg1), v0);
        };
        let v2 = 0x2::balance::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&arg0.token_reserve);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut arg0.token_reserve, v2), arg1), v0);
        };
        arg0.reserved_suis = 0;
        arg0.reserved_tokens = 0;
    }

    public entry fun withdraw_amm_funds(arg0: &mut InvestmentPlatform, arg1: &mut AMMPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 0);
        assert!(arg0.amm_initialized, 6);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve);
        let v2 = 0x2::balance::value<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&arg1.token_reserve);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v1), arg2), v0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut arg1.token_reserve, v2), arg2), v0);
        };
    }

    public entry fun withdraw_fund(arg0: &mut InvestmentPlatform, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<FundInfo>(&arg0.fund_holders)) {
            if (0x1::vector::borrow<FundInfo>(&arg0.fund_holders, v3).address == v0) {
                v1 = true;
                v2 = v3;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v1, 7);
        let v4 = 0x1::vector::borrow_mut<FundInfo>(&mut arg0.fund_holders, v2);
        let v5 = arg0.total_invested * 20 / 1000 - v4.withdraw_amount;
        assert!(v5 >= arg1, 11);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v5, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, arg1), arg2), v0);
        v4.withdraw_amount = v4.withdraw_amount + arg1;
    }

    public entry fun withdraw_spl_token(arg0: &mut InvestmentPlatform, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<HolderInfo>(&arg0.holders)) {
            if (0x1::vector::borrow<HolderInfo>(&arg0.holders, v3).address == v0) {
                v1 = true;
                v2 = v3;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v1, 7);
        let v4 = 0x1::vector::borrow_mut<HolderInfo>(&mut arg0.holders, v2);
        assert!(v4.amount >= arg1, 11);
        v4.amount = v4.amount - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>>(0x2::coin::from_balance<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(0x2::balance::split<0xab0f35cd95238534a8f5183acd6356e3b5e6375049383ca89af6569404a777f5::spl::SPL>(&mut arg0.token_reserve, arg1), arg2), v0);
    }

    public entry fun withdraw_suis(arg0: &mut InvestmentPlatform, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.withdraw_whitelist, 12);
        assert!(arg0.reserved_suis * 750 / 1000 >= arg1, 11);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= arg1, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, arg1), arg2), v0);
        arg0.reserved_suis = arg0.reserved_suis - arg1;
    }

    // decompiled from Move bytecode v6
}

