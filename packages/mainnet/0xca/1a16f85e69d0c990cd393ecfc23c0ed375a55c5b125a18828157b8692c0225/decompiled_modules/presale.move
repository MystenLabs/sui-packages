module 0xca1a16f85e69d0c990cd393ecfc23c0ed375a55c5b125a18828157b8692c0225::presale {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PresaleConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        treasury: address,
        platform_fee_bps: u64,
        creation_fee_mist: u64,
    }

    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        price_per_token_mist: u64,
        min_raise_mist: u64,
        max_raise_mist: u64,
        max_per_wallet_mist: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        token_decimals: u8,
        presale_bps: u64,
        liquidity_bps: u64,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
        presale_tokens: 0x2::coin::Coin<T0>,
        liquidity_tokens: 0x2::coin::Coin<T0>,
        creator_tokens: 0x2::coin::Coin<T0>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        contributions: 0x2::table::Table<address, u64>,
        claims: 0x2::table::Table<address, bool>,
        contributor_count: u64,
        status: u8,
    }

    struct PresaleCreatedEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        creator: address,
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        price_per_token_mist: u64,
        min_raise_mist: u64,
        max_raise_mist: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        presale_bps: u64,
        liquidity_bps: u64,
        total_supply: u64,
        ts: u64,
    }

    struct ContributionEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        contributor: address,
        sui_amount: u64,
        total_raised: u64,
        contributor_count: u64,
        ts: u64,
    }

    struct PresaleFinalizedEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        status: u8,
        total_raised: u64,
        contributor_count: u64,
        ts: u64,
    }

    struct PresaleMigratingEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        ts: u64,
    }

    struct ClaimEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        user: address,
        token_amount: u64,
        ts: u64,
    }

    struct RefundEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        user: address,
        sui_amount: u64,
        ts: u64,
    }

    public entry fun claim<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2 || arg0.status == 4, 10);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, v0), 11);
        assert!(!0x2::table::contains<address, bool>(&arg0.claims, v0), 12);
        let v1 = (((*0x2::table::borrow<address, u64>(&arg0.contributions, v0) as u128) * (0x2::coin::value<T0>(&arg0.presale_tokens) as u128) / (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised) as u128)) as u64);
        assert!(v1 > 0, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.presale_tokens, v1, arg2), v0);
        0x2::table::add<address, bool>(&mut arg0.claims, v0, true);
        let v2 = ClaimEvent{
            presale_id   : 0x2::object::id<Presale<T0>>(arg0),
            user         : v0,
            token_amount : v1,
            ts           : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimEvent>(v2);
    }

    public entry fun contribute<T0>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time_ms, 15);
        assert!(v0 < arg0.end_time_ms, 3);
        assert!(arg0.status == 0 || arg0.status == 1, 7);
        if (arg0.status == 0) {
            arg0.status = 1;
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised);
        let v3 = if (v2 + v1 > arg0.max_raise_mist) {
            arg0.max_raise_mist - v2
        } else {
            v1
        };
        assert!(v3 > 0, 5);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = if (0x2::table::contains<address, u64>(&arg0.contributions, v4)) {
            *0x2::table::borrow<address, u64>(&arg0.contributions, v4)
        } else {
            0
        };
        if (arg0.max_per_wallet_mist > 0) {
            assert!(v5 + v3 <= arg0.max_per_wallet_mist, 6);
        };
        let v6 = if (v3 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v4);
            0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg3)
        } else {
            arg1
        };
        let v7 = v6;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v7, (((v3 as u128) * 200 / (10000 as u128)) as u64), arg3)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(v7));
        if (0x2::table::contains<address, u64>(&arg0.contributions, v4)) {
            let v8 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, v4);
            *v8 = *v8 + v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, v4, v3);
            arg0.contributor_count = arg0.contributor_count + 1;
        };
        let v9 = ContributionEvent{
            presale_id        : 0x2::object::id<Presale<T0>>(arg0),
            contributor       : v4,
            sui_amount        : v3,
            total_raised      : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
            contributor_count : arg0.contributor_count,
            ts                : v0,
        };
        0x2::event::emit<ContributionEvent>(v9);
    }

    public entry fun create_presale<T0>(arg0: &PresaleConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: &0x2::clock::Clock, arg15: 0x1::ascii::String, arg16: 0x1::ascii::String, arg17: 0x1::ascii::String, arg18: 0x1::ascii::String, arg19: 0x1::ascii::String, arg20: 0x1::ascii::String, arg21: 0x1::ascii::String, arg22: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 16);
        assert!(arg4 > 0, 1);
        assert!(arg5 > 0, 1);
        assert!(arg6 > 0, 1);
        assert!(arg7 >= arg6, 1);
        assert!(arg10 > arg9, 1);
        assert!(arg9 >= 0x2::clock::timestamp_ms(arg14), 1);
        assert!(arg11 > 0 && arg11 <= 10000, 1);
        assert!(arg12 <= 10000, 1);
        assert!(arg11 + arg12 <= 10000, 17);
        assert!(0x1::ascii::length(&arg17) <= 300, 1);
        assert!(0x1::ascii::length(&arg18) <= 1000, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.creation_fee_mist, 18);
        let v0 = (((arg4 as u128) * (arg11 as u128) / (10000 as u128)) as u64);
        let v1 = (((arg4 as u128) * (arg12 as u128) / (10000 as u128)) as u64);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.creation_fee_mist, arg22), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg22));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v2 = Presale<T0>{
            id                   : 0x2::object::new(arg22),
            creator              : 0x2::tx_context::sender(arg22),
            name                 : arg15,
            symbol               : arg16,
            uri                  : arg17,
            description          : arg18,
            twitter              : arg19,
            telegram             : arg20,
            website              : arg21,
            token_address        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            price_per_token_mist : arg5,
            min_raise_mist       : arg6,
            max_raise_mist       : arg7,
            max_per_wallet_mist  : arg8,
            start_time_ms        : arg9,
            end_time_ms          : arg10,
            token_decimals       : arg13,
            presale_bps          : arg11,
            liquidity_bps        : arg12,
            sui_raised           : 0x2::balance::zero<0x2::sui::SUI>(),
            presale_tokens       : 0x2::coin::mint<T0>(&mut arg1, v0, arg22),
            liquidity_tokens     : 0x2::coin::mint<T0>(&mut arg1, v1, arg22),
            creator_tokens       : 0x2::coin::mint<T0>(&mut arg1, arg4 - v0 - v1, arg22),
            fee_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            contributions        : 0x2::table::new<address, u64>(arg22),
            claims               : 0x2::table::new<address, bool>(arg22),
            contributor_count    : 0,
            status               : 0,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::CoinMetadata<T0>>(&mut v2.id, b"metadata_token", arg2);
        let v3 = PresaleCreatedEvent{
            presale_id           : 0x2::object::id<Presale<T0>>(&v2),
            creator              : 0x2::tx_context::sender(arg22),
            name                 : v2.name,
            symbol               : v2.symbol,
            uri                  : v2.uri,
            token_address        : v2.token_address,
            price_per_token_mist : arg5,
            min_raise_mist       : arg6,
            max_raise_mist       : arg7,
            start_time_ms        : arg9,
            end_time_ms          : arg10,
            presale_bps          : arg11,
            liquidity_bps        : arg12,
            total_supply         : arg4,
            ts                   : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<PresaleCreatedEvent>(v3);
        0x2::transfer::public_share_object<Presale<T0>>(v2);
    }

    public entry fun finalize<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.end_time_ms, 4);
        assert!(arg0.status == 0 || arg0.status == 1, 7);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised);
        if (v1 >= arg0.min_raise_mist) {
            arg0.status = 2;
        } else {
            arg0.status = 3;
        };
        let v2 = PresaleFinalizedEvent{
            presale_id        : 0x2::object::id<Presale<T0>>(arg0),
            status            : arg0.status,
            total_raised      : v1,
            contributor_count : arg0.contributor_count,
            ts                : v0,
        };
        0x2::event::emit<PresaleFinalizedEvent>(v2);
    }

    public fun get_contribution<T0>(arg0: &Presale<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.contributions, arg1)
        } else {
            0
        }
    }

    public fun get_contributor_count<T0>(arg0: &Presale<T0>) : u64 {
        arg0.contributor_count
    }

    public fun get_status<T0>(arg0: &Presale<T0>) : u8 {
        arg0.status
    }

    public fun get_total_raised<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PresaleConfig{
            id                : 0x2::object::new(arg0),
            version           : 1,
            admin             : 0x2::tx_context::sender(arg0),
            treasury          : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
            platform_fee_bps  : 200,
            creation_fee_mist : 10000000,
        };
        0x2::transfer::public_share_object<PresaleConfig>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun refund<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, v0), 11);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.contributions, v0);
        assert!(v1 > 0, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_raised, v1), arg2), v0);
        arg0.contributor_count = arg0.contributor_count - 1;
        let v2 = RefundEvent{
            presale_id : 0x2::object::id<Presale<T0>>(arg0),
            user       : v0,
            sui_amount : v1,
            ts         : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RefundEvent>(v2);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut PresaleConfig, arg2: u64, arg3: u64) {
        assert!(arg2 <= 1000, 1);
        arg1.platform_fee_bps = arg2;
        arg1.creation_fee_mist = arg3;
    }

    public entry fun withdraw_for_migration<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409, 13);
        assert!(arg0.status == 2, 10);
        let v0 = 0x2::coin::value<T0>(&arg0.liquidity_tokens);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_raised), arg2), @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.liquidity_tokens, v0, arg2), @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409);
        let v1 = 0x2::coin::value<T0>(&arg0.creator_tokens);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.creator_tokens, v1, arg2), arg0.creator);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fee_balance), arg2), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        };
        arg0.status = 4;
        let v2 = PresaleMigratingEvent{
            presale_id    : 0x2::object::id<Presale<T0>>(arg0),
            token_address : arg0.token_address,
            sui_amount    : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
            token_amount  : v0,
            ts            : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PresaleMigratingEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

