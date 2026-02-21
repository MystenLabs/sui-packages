module 0x1b98333f77559c82db465285a522966c236f7305dbe2b261f8547f34374f1c49::creator_market {
    struct PlatformConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
    }

    struct CreatorProfile has store, key {
        id: 0x2::object::UID,
        creator: address,
        username: 0x1::string::String,
        market_id: 0x1::option::Option<0x2::object::ID>,
        metadata_uri: 0x1::string::String,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct CreatorMarket has store, key {
        id: 0x2::object::UID,
        creator: address,
        admin: address,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        supply: u64,
        v_sui: u64,
        v_tok: u64,
        min_buy_mist: u64,
        creator_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    struct CreatorToken has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        balance: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        creator: address,
        admin: address,
        v_sui: u64,
        v_tok: u64,
        min_buy_mist: u64,
        timestamp_ms: u64,
    }

    struct TradeEvent has copy, drop {
        market_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_in_mist: u64,
        tokens_out: u64,
        tokens_in: u64,
        payout_gross_mist: u64,
        payout_net_mist: u64,
        creator_fee_mist: u64,
        admin_fee_mist: u64,
        market_fee_mist: u64,
        reserve_after_mist: u64,
        supply_after: u64,
        price_after_fp: u64,
        is_creator_trade: bool,
        timestamp_ms: u64,
    }

    struct FeesClaimed has copy, drop {
        market_id: 0x2::object::ID,
        claimer: address,
        is_creator: bool,
        amount_mist: u64,
        to_address: address,
        creator_vault_after: u64,
        admin_vault_after: u64,
        timestamp_ms: u64,
    }

    struct ProfileUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        creator: address,
        timestamp_ms: u64,
    }

    public entry fun buy(arg0: &mut CreatorMarket, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.min_buy_mist, 3);
        let v1 = fee_amount(v0, 100);
        let v2 = fee_amount(v0, 100);
        let v3 = fee_amount(v0, 100);
        let v4 = calc_tokens_out(arg0, v0 - v1 - v2 - v3);
        assert!(v4 >= arg2, 4);
        assert!(v4 > 0, 6);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, v5);
        arg0.supply = arg0.supply + v4;
        let v6 = 0x2::tx_context::sender(arg4);
        let v7 = TradeEvent{
            market_id          : 0x2::object::id<CreatorMarket>(arg0),
            trader             : v6,
            is_buy             : true,
            sui_in_mist        : v0,
            tokens_out         : v4,
            tokens_in          : 0,
            payout_gross_mist  : 0,
            payout_net_mist    : 0,
            creator_fee_mist   : v1,
            admin_fee_mist     : v2,
            market_fee_mist    : v3,
            reserve_after_mist : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            supply_after       : arg0.supply,
            price_after_fp     : price_fp(arg0),
            is_creator_trade   : v6 == arg0.creator,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradeEvent>(v7);
        let v8 = CreatorToken{
            id        : 0x2::object::new(arg4),
            market_id : 0x2::object::id<CreatorMarket>(arg0),
            balance   : v4,
        };
        0x2::transfer::transfer<CreatorToken>(v8, v6);
    }

    fun calc_sui_out(arg0: &CreatorMarket, arg1: u64) : u64 {
        let (v0, v1) = effective_reserves(arg0);
        assert!(v1 > (arg1 as u128), 7);
        ((v0 - v0 * v1 / (v1 - (arg1 as u128))) as u64)
    }

    fun calc_tokens_out(arg0: &CreatorMarket, arg1: u64) : u64 {
        let (v0, v1) = effective_reserves(arg0);
        ((v1 - v0 * v1 / (v0 + (arg1 as u128))) as u64)
    }

    public entry fun claim_admin_fees(arg0: &mut CreatorMarket, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.admin, 2);
        assert!(arg1 > 0, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fee_vault) >= arg1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.admin_fee_vault, arg1), arg4), arg2);
        let v1 = FeesClaimed{
            market_id           : 0x2::object::id<CreatorMarket>(arg0),
            claimer             : v0,
            is_creator          : false,
            amount_mist         : arg1,
            to_address          : arg2,
            creator_vault_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_vault),
            admin_vault_after   : 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fee_vault),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesClaimed>(v1);
    }

    public entry fun claim_creator_fees(arg0: &mut CreatorMarket, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.creator, 1);
        assert!(arg1 > 0, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_vault) >= arg1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.creator_fee_vault, arg1), arg4), arg2);
        let v1 = FeesClaimed{
            market_id           : 0x2::object::id<CreatorMarket>(arg0),
            claimer             : v0,
            is_creator          : true,
            amount_mist         : arg1,
            to_address          : arg2,
            creator_vault_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_vault),
            admin_vault_after   : 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fee_vault),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesClaimed>(v1);
    }

    public entry fun create_market(arg0: &mut CreatorProfile, arg1: &PlatformConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.market_id), 10);
        internal_create_market(arg0, arg1.admin, 200000000000, 2000000000000000, 1000000000, arg2, arg3);
    }

    public entry fun create_market_custom(arg0: &mut CreatorProfile, arg1: &PlatformConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg6), 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.market_id), 10);
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        internal_create_market(arg0, arg1.admin, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun create_profile(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = 0x1::string::length(&v0);
        assert!(v1 > 0, 9);
        assert!(v1 <= 32, 9);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = CreatorProfile{
            id            : 0x2::object::new(arg3),
            creator       : v2,
            username      : v0,
            market_id     : 0x1::option::none<0x2::object::ID>(),
            metadata_uri  : 0x1::string::utf8(arg1),
            created_at_ms : v3,
            updated_at_ms : v3,
        };
        0x2::transfer::transfer<CreatorProfile>(v4, v2);
    }

    fun effective_reserves(arg0: &CreatorMarket) : (u128, u128) {
        ((arg0.v_sui as u128) + (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) as u128), (arg0.v_tok as u128) + (arg0.supply as u128))
    }

    fun fee_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun get_market_stats(arg0: &CreatorMarket) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.supply, price_fp(arg0), 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_vault), 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fee_vault))
    }

    public fun get_price(arg0: &CreatorMarket) : u64 {
        price_fp(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformConfig{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            version : 1,
        };
        0x2::transfer::share_object<PlatformConfig>(v0);
    }

    fun internal_create_market(arg0: &mut CreatorProfile, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = CreatorMarket{
            id                : 0x2::object::new(arg6),
            creator           : v0,
            admin             : arg1,
            sui_reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            supply            : 0,
            v_sui             : arg2,
            v_tok             : arg3,
            min_buy_mist      : arg4,
            creator_fee_vault : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_fee_vault   : 0x2::balance::zero<0x2::sui::SUI>(),
            version           : 1,
        };
        let v2 = 0x2::object::id<CreatorMarket>(&v1);
        arg0.market_id = 0x1::option::some<0x2::object::ID>(v2);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v3 = MarketCreated{
            market_id    : v2,
            profile_id   : 0x2::object::id<CreatorProfile>(arg0),
            creator      : v0,
            admin        : arg1,
            v_sui        : arg2,
            v_tok        : arg3,
            min_buy_mist : arg4,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<MarketCreated>(v3);
        0x2::transfer::share_object<CreatorMarket>(v1);
    }

    public fun market_admin(arg0: &CreatorMarket) : address {
        arg0.admin
    }

    public fun market_creator(arg0: &CreatorMarket) : address {
        arg0.creator
    }

    public fun market_min_buy(arg0: &CreatorMarket) : u64 {
        arg0.min_buy_mist
    }

    public fun market_reserve(arg0: &CreatorMarket) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun market_supply(arg0: &CreatorMarket) : u64 {
        arg0.supply
    }

    public fun market_v_sui(arg0: &CreatorMarket) : u64 {
        arg0.v_sui
    }

    public fun market_v_tok(arg0: &CreatorMarket) : u64 {
        arg0.v_tok
    }

    public entry fun merge_tokens(arg0: &mut CreatorToken, arg1: CreatorToken, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.market_id == arg1.market_id, 8);
        let CreatorToken {
            id        : v0,
            market_id : _,
            balance   : v2,
        } = arg1;
        0x2::object::delete(v0);
        arg0.balance = arg0.balance + v2;
    }

    public fun platform_admin(arg0: &PlatformConfig) : address {
        arg0.admin
    }

    fun price_fp(arg0: &CreatorMarket) : u64 {
        let (v0, v1) = effective_reserves(arg0);
        ((v0 * 1000000000 / v1) as u64)
    }

    public fun profile_creator(arg0: &CreatorProfile) : address {
        arg0.creator
    }

    public fun profile_market_id(arg0: &CreatorProfile) : &0x1::option::Option<0x2::object::ID> {
        &arg0.market_id
    }

    public fun profile_metadata_uri(arg0: &CreatorProfile) : &0x1::string::String {
        &arg0.metadata_uri
    }

    public fun profile_username(arg0: &CreatorProfile) : &0x1::string::String {
        &arg0.username
    }

    public fun quote_buy(arg0: &CreatorMarket, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = fee_amount(arg1, 100);
        let v1 = fee_amount(arg1, 100);
        let v2 = fee_amount(arg1, 100);
        let v3 = arg1 - v0 - v1 - v2;
        (calc_tokens_out(arg0, v3), v0, v1, v2, v3)
    }

    public fun quote_sell(arg0: &CreatorMarket, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = calc_sui_out(arg0, arg1);
        let v1 = fee_amount(v0, 100);
        let v2 = fee_amount(v0, 100);
        let v3 = fee_amount(v0, 100);
        (v0 - v1 - v2 - v3, v1, v2, v3, v0)
    }

    public entry fun sell(arg0: &mut CreatorMarket, arg1: CreatorToken, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.market_id == 0x2::object::id<CreatorMarket>(arg0), 8);
        assert!(arg2 > 0, 6);
        assert!(arg1.balance >= arg2, 7);
        let v0 = calc_sui_out(arg0, arg2);
        assert!(v0 > 0, 6);
        let v1 = fee_amount(v0, 100);
        let v2 = fee_amount(v0, 100);
        let v3 = fee_amount(v0, 100);
        let v4 = v0 - v1 - v2 - v3;
        let v5 = v4 + v1 + v2;
        assert!(v4 >= arg3, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v5, 5);
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v2));
        arg0.supply = arg0.supply - arg2;
        arg1.balance = arg1.balance - arg2;
        let v7 = 0x2::tx_context::sender(arg5);
        let v8 = TradeEvent{
            market_id          : 0x2::object::id<CreatorMarket>(arg0),
            trader             : v7,
            is_buy             : false,
            sui_in_mist        : 0,
            tokens_out         : 0,
            tokens_in          : arg2,
            payout_gross_mist  : v0,
            payout_net_mist    : v4,
            creator_fee_mist   : v1,
            admin_fee_mist     : v2,
            market_fee_mist    : v3,
            reserve_after_mist : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            supply_after       : arg0.supply,
            price_after_fp     : price_fp(arg0),
            is_creator_trade   : v7 == arg0.creator,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TradeEvent>(v8);
        if (arg1.balance == 0) {
            let CreatorToken {
                id        : v9,
                market_id : _,
                balance   : _,
            } = arg1;
            0x2::object::delete(v9);
        } else {
            0x2::transfer::transfer<CreatorToken>(arg1, v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), v7);
    }

    public fun token_balance(arg0: &CreatorToken) : u64 {
        arg0.balance
    }

    public fun token_market_id(arg0: &CreatorToken) : 0x2::object::ID {
        arg0.market_id
    }

    public entry fun update_username(arg0: &mut CreatorProfile, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::length(&v0);
        assert!(v1 > 0, 9);
        assert!(v1 <= 32, 9);
        arg0.username = v0;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v2 = ProfileUpdated{
            profile_id   : 0x2::object::id<CreatorProfile>(arg0),
            creator      : arg0.creator,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<ProfileUpdated>(v2);
    }

    // decompiled from Move bytecode v6
}

