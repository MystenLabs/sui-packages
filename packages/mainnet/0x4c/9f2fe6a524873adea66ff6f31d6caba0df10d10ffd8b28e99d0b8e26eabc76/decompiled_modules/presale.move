module 0x4c9f2fe6a524873adea66ff6f31d6caba0df10d10ffd8b28e99d0b8e26eabc76::presale {
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
        team_bps: u64,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
        presale_tokens: 0x2::coin::Coin<T0>,
        liquidity_tokens: 0x2::coin::Coin<T0>,
        creator_tokens: 0x2::coin::Coin<T0>,
        team_tokens: 0x2::coin::Coin<T0>,
        contributions: 0x2::table::Table<address, u64>,
        claims: 0x2::table::Table<address, bool>,
        contributor_count: u64,
        status: u8,
        team_wallet: address,
        team_cliff_ms: u64,
        team_vesting_end_ms: u64,
        creator_cliff_ms: u64,
        creator_vesting_end_ms: u64,
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
        team_bps: u64,
        total_supply: u64,
        team_wallet: address,
        team_cliff_ms: u64,
        team_vesting_end_ms: u64,
        creator_cliff_ms: u64,
        creator_vesting_end_ms: u64,
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
        team_amount: u64,
        team_wallet: address,
        team_cliff_ms: u64,
        team_vesting_end_ms: u64,
        creator_amount: u64,
        creator_cliff_ms: u64,
        creator_vesting_end_ms: u64,
        ts: u64,
    }

    struct TeamTokensReleasedEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        team_wallet: address,
        amount: u64,
        ts: u64,
    }

    struct CreatorTokensReleasedEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        creator: address,
        amount: u64,
        ts: u64,
    }

    struct PresaleCancelledEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        cancelled_by: address,
        total_raised: u64,
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

    struct TokensBurnedEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        total_burned: u64,
        ts: u64,
    }

    public entry fun burn_failed_tokens<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3 || arg0.status == 5, 19);
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x2::coin::value<T0>(&arg0.presale_tokens);
        if (v2 > 0) {
            v1 = v0 + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.presale_tokens, v2, arg2), @0x0);
        };
        let v3 = 0x2::coin::value<T0>(&arg0.liquidity_tokens);
        if (v3 > 0) {
            v1 = v1 + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.liquidity_tokens, v3, arg2), @0x0);
        };
        let v4 = 0x2::coin::value<T0>(&arg0.team_tokens);
        if (v4 > 0) {
            v1 = v1 + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.team_tokens, v4, arg2), @0x0);
        };
        let v5 = 0x2::coin::value<T0>(&arg0.creator_tokens);
        if (v5 > 0) {
            v1 = v1 + v5;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.creator_tokens, v5, arg2), @0x0);
        };
        let v6 = TokensBurnedEvent{
            presale_id   : 0x2::object::id<Presale<T0>>(arg0),
            total_burned : v1,
            ts           : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokensBurnedEvent>(v6);
    }

    public entry fun cancel_presale<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409, 13);
        assert!(arg0.status == 0 || arg0.status == 1, 23);
        arg0.status = 5;
        let v0 = PresaleCancelledEvent{
            presale_id   : 0x2::object::id<Presale<T0>>(arg0),
            cancelled_by : 0x2::tx_context::sender(arg2),
            total_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
            ts           : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PresaleCancelledEvent>(v0);
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
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(v6));
        if (0x2::table::contains<address, u64>(&arg0.contributions, v4)) {
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, v4);
            *v7 = *v7 + v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, v4, v3);
            arg0.contributor_count = arg0.contributor_count + 1;
        };
        let v8 = ContributionEvent{
            presale_id        : 0x2::object::id<Presale<T0>>(arg0),
            contributor       : v4,
            sui_amount        : v3,
            total_raised      : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
            contributor_count : arg0.contributor_count,
            ts                : v0,
        };
        0x2::event::emit<ContributionEvent>(v8);
    }

    public entry fun create_presale<T0>(arg0: &PresaleConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u8, arg20: &0x2::clock::Clock, arg21: 0x1::ascii::String, arg22: 0x1::ascii::String, arg23: 0x1::ascii::String, arg24: 0x1::ascii::String, arg25: 0x1::ascii::String, arg26: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 16);
        assert!(arg4 > 0, 1);
        assert!(arg5 > 0, 1);
        assert!(arg6 > 0, 1);
        assert!(arg7 >= arg6, 1);
        assert!(arg10 > arg9, 1);
        assert!(arg9 >= 0x2::clock::timestamp_ms(arg20), 1);
        assert!(arg11 > 0 && arg11 <= 10000, 1);
        assert!(arg12 <= 10000, 1);
        assert!(arg13 <= 10000, 1);
        assert!(arg11 + arg12 + arg13 <= 10000, 17);
        assert!(0x1::ascii::length(&arg23) <= 300, 1);
        assert!(0x1::ascii::length(&arg24) <= 1000, 1);
        assert!(0x2::tx_context::sender(arg26) == @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409 || 0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.creation_fee_mist, 18);
        if (arg13 > 0 && arg15 > 0) {
            assert!(arg15 > 0x2::clock::timestamp_ms(arg20), 1);
        };
        if (arg16 > 0) {
            assert!(arg16 > arg15, 1);
        };
        if (arg17 > 0) {
            assert!(arg17 > 0x2::clock::timestamp_ms(arg20), 1);
        };
        if (arg18 > 0) {
            assert!(arg18 > arg17, 1);
        };
        let v0 = (((arg4 as u128) * (arg11 as u128) / (10000 as u128)) as u64);
        let v1 = (((arg4 as u128) * (arg12 as u128) / (10000 as u128)) as u64);
        let v2 = (((arg4 as u128) * (arg13 as u128) / (10000 as u128)) as u64);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        if (0x2::tx_context::sender(arg26) != @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409 && 0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.creation_fee_mist) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.creation_fee_mist, arg26), arg0.treasury);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg26));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v3 = Presale<T0>{
            id                     : 0x2::object::new(arg26),
            creator                : 0x2::tx_context::sender(arg26),
            name                   : arg21,
            symbol                 : arg22,
            uri                    : arg23,
            description            : arg24,
            twitter                : arg25,
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            price_per_token_mist   : arg5,
            min_raise_mist         : arg6,
            max_raise_mist         : arg7,
            max_per_wallet_mist    : arg8,
            start_time_ms          : arg9,
            end_time_ms            : arg10,
            token_decimals         : arg19,
            presale_bps            : arg11,
            liquidity_bps          : arg12,
            team_bps               : arg13,
            sui_raised             : 0x2::balance::zero<0x2::sui::SUI>(),
            presale_tokens         : 0x2::coin::mint<T0>(&mut arg1, v0, arg26),
            liquidity_tokens       : 0x2::coin::mint<T0>(&mut arg1, v1, arg26),
            creator_tokens         : 0x2::coin::mint<T0>(&mut arg1, arg4 - v0 - v1 - v2, arg26),
            team_tokens            : 0x2::coin::mint<T0>(&mut arg1, v2, arg26),
            contributions          : 0x2::table::new<address, u64>(arg26),
            claims                 : 0x2::table::new<address, bool>(arg26),
            contributor_count      : 0,
            status                 : 0,
            team_wallet            : arg14,
            team_cliff_ms          : arg15,
            team_vesting_end_ms    : arg16,
            creator_cliff_ms       : arg17,
            creator_vesting_end_ms : arg18,
        };
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T0>>(arg2, 0x2::tx_context::sender(arg26));
        let v4 = PresaleCreatedEvent{
            presale_id             : 0x2::object::id<Presale<T0>>(&v3),
            creator                : 0x2::tx_context::sender(arg26),
            name                   : v3.name,
            symbol                 : v3.symbol,
            uri                    : v3.uri,
            token_address          : v3.token_address,
            price_per_token_mist   : arg5,
            min_raise_mist         : arg6,
            max_raise_mist         : arg7,
            start_time_ms          : arg9,
            end_time_ms            : arg10,
            presale_bps            : arg11,
            liquidity_bps          : arg12,
            team_bps               : arg13,
            total_supply           : arg4,
            team_wallet            : arg14,
            team_cliff_ms          : arg15,
            team_vesting_end_ms    : arg16,
            creator_cliff_ms       : arg17,
            creator_vesting_end_ms : arg18,
            ts                     : 0x2::clock::timestamp_ms(arg20),
        };
        0x2::event::emit<PresaleCreatedEvent>(v4);
        0x2::transfer::public_share_object<Presale<T0>>(v3);
    }

    public entry fun finalize<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms || v0 >= arg0.max_raise_mist, 4);
        assert!(arg0.status == 0 || arg0.status == 1, 7);
        if (v0 >= arg0.min_raise_mist) {
            arg0.status = 2;
        } else {
            arg0.status = 3;
        };
        let v1 = PresaleFinalizedEvent{
            presale_id        : 0x2::object::id<Presale<T0>>(arg0),
            status            : arg0.status,
            total_raised      : v0,
            contributor_count : arg0.contributor_count,
            ts                : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PresaleFinalizedEvent>(v1);
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

    public fun get_creator_vesting<T0>(arg0: &Presale<T0>) : (u64, u64) {
        (arg0.creator_cliff_ms, arg0.creator_vesting_end_ms)
    }

    public fun get_status<T0>(arg0: &Presale<T0>) : u8 {
        arg0.status
    }

    public fun get_team_vesting<T0>(arg0: &Presale<T0>) : (address, u64, u64) {
        (arg0.team_wallet, arg0.team_cliff_ms, arg0.team_vesting_end_ms)
    }

    public fun get_total_raised<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PresaleConfig{
            id                : 0x2::object::new(arg0),
            version           : 4,
            admin             : 0x2::tx_context::sender(arg0),
            treasury          : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
            platform_fee_bps  : 200,
            creation_fee_mist : 20000000000,
        };
        0x2::transfer::public_share_object<PresaleConfig>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun refund<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3 || arg0.status == 5, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, v0), 11);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.contributions, v0);
        assert!(v1 > 0, 11);
        0x2::table::remove<address, u64>(&mut arg0.contributions, v0);
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

    public entry fun release_creator_tokens<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 4, 8);
        assert!(arg0.creator_cliff_ms > 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.creator_cliff_ms, 24);
        let v1 = 0x2::coin::value<T0>(&arg0.creator_tokens);
        assert!(v1 > 0, 25);
        let v2 = if (arg0.creator_vesting_end_ms == 0 || v0 >= arg0.creator_vesting_end_ms) {
            v1
        } else {
            let v3 = (((v1 as u128) * ((v0 - arg0.creator_cliff_ms) as u128) / ((arg0.creator_vesting_end_ms - arg0.creator_cliff_ms) as u128)) as u64);
            if (v3 == 0) {
                0
            } else {
                v3
            }
        };
        assert!(v2 > 0, 25);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.creator_tokens, v2, arg2), arg0.creator);
        let v4 = CreatorTokensReleasedEvent{
            presale_id : 0x2::object::id<Presale<T0>>(arg0),
            creator    : arg0.creator,
            amount     : v2,
            ts         : v0,
        };
        0x2::event::emit<CreatorTokensReleasedEvent>(v4);
    }

    public entry fun release_team_tokens<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 4, 8);
        assert!(arg0.team_cliff_ms > 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.team_cliff_ms, 21);
        let v1 = 0x2::coin::value<T0>(&arg0.team_tokens);
        assert!(v1 > 0, 22);
        let v2 = if (arg0.team_vesting_end_ms == 0 || v0 >= arg0.team_vesting_end_ms) {
            v1
        } else {
            let v3 = (((v1 as u128) * ((v0 - arg0.team_cliff_ms) as u128) / ((arg0.team_vesting_end_ms - arg0.team_cliff_ms) as u128)) as u64);
            if (v3 == 0) {
                0
            } else {
                v3
            }
        };
        assert!(v2 > 0, 22);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.team_tokens, v2, arg2), arg0.team_wallet);
        let v4 = TeamTokensReleasedEvent{
            presale_id  : 0x2::object::id<Presale<T0>>(arg0),
            team_wallet : arg0.team_wallet,
            amount      : v2,
            ts          : v0,
        };
        0x2::event::emit<TeamTokensReleasedEvent>(v4);
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
        let v1 = 0x2::coin::value<T0>(&arg0.team_tokens);
        let v2 = 0x2::coin::value<T0>(&arg0.creator_tokens);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_raised), arg2), @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.liquidity_tokens, v0, arg2), @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409);
        if (v1 > 0 && arg0.team_cliff_ms == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.team_tokens, v1, arg2), arg0.team_wallet);
        };
        if (v2 > 0 && arg0.creator_cliff_ms == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.creator_tokens, v2, arg2), arg0.creator);
        };
        arg0.status = 4;
        let v3 = if (v1 > 0 && arg0.team_cliff_ms > 0) {
            v1
        } else {
            0
        };
        let v4 = if (v2 > 0 && arg0.creator_cliff_ms > 0) {
            v2
        } else {
            0
        };
        let v5 = PresaleMigratingEvent{
            presale_id             : 0x2::object::id<Presale<T0>>(arg0),
            token_address          : arg0.token_address,
            sui_amount             : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
            token_amount           : v0,
            team_amount            : v3,
            team_wallet            : arg0.team_wallet,
            team_cliff_ms          : arg0.team_cliff_ms,
            team_vesting_end_ms    : arg0.team_vesting_end_ms,
            creator_amount         : v4,
            creator_cliff_ms       : arg0.creator_cliff_ms,
            creator_vesting_end_ms : arg0.creator_vesting_end_ms,
            ts                     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PresaleMigratingEvent>(v5);
    }

    // decompiled from Move bytecode v7
}

