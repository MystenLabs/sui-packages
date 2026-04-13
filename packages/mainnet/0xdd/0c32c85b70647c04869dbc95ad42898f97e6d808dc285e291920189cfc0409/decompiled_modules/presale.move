module 0xdd0c32c85b70647c04869dbc95ad42898f97e6d808dc285e291920189cfc0409::presale {
    struct PresaleCreatedEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        creator: address,
    }

    struct ContributionEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        contributor: address,
        amount: u64,
    }

    struct PresaleFinalizedEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        total_raised: u64,
    }

    struct ClaimEvent has copy, drop, store {
        presale_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        uri: 0x1::string::String,
        description: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        token_address: 0x1::string::String,
        raised: u64,
        presale_tokens: 0x2::coin::Coin<T0>,
        liquidity_tokens: 0x2::coin::Coin<T0>,
        team_tokens: 0x2::coin::Coin<T0>,
        creator_tokens: 0x2::coin::Coin<T0>,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
        contributions: 0x2::table::Table<address, u64>,
        end_time_ms: u64,
        team_wallet: address,
        team_cliff_ms: u64,
        tokens_burned: bool,
        min_contribution: u64,
        max_contribution: u64,
        creation_fee: u64,
        fee_balance: u64,
    }

    public entry fun burn_failed_tokens<T0: drop + store + key>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.tokens_burned, 0);
        arg0.tokens_burned = true;
        let v0 = 0x2::coin::value<T0>(&arg0.creator_tokens);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.creator_tokens, v0, arg2), @0x0);
        };
    }

    public entry fun claim<T0: drop + store + key>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, v0), 0);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.contributions, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.presale_tokens, v1, arg1), v0);
        let v2 = ClaimEvent{
            presale_id : 0x2::object::uid_to_inner(&arg0.id),
            claimer    : v0,
            amount     : v1,
        };
        0x2::event::emit<ClaimEvent>(v2);
    }

    public entry fun contribute<T0: drop + store + key>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time_ms, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.min_contribution, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (0x2::table::contains<address, u64>(&arg0.contributions, 0x2::tx_context::sender(arg3))) {
            0x2::table::remove<address, u64>(&mut arg0.contributions, 0x2::tx_context::sender(arg3));
            0x2::table::add<address, u64>(&mut arg0.contributions, 0x2::tx_context::sender(arg3), *0x2::table::borrow<address, u64>(&arg0.contributions, 0x2::tx_context::sender(arg3)) + v0);
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, 0x2::tx_context::sender(arg3), v0);
        };
        let v1 = ContributionEvent{
            presale_id  : 0x2::object::uid_to_inner(&arg0.id),
            contributor : 0x2::tx_context::sender(arg3),
            amount      : v0,
        };
        0x2::event::emit<ContributionEvent>(v1);
        arg0.raised = arg0.raised + v0;
    }

    public entry fun create<T0: drop + store + key>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: address, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg21);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::CoinMetadata<T0>>(&mut v0, b"metadata_token", arg1);
        let v1 = Presale<T0>{
            id               : v0,
            creator          : 0x2::tx_context::sender(arg21),
            name             : arg2,
            symbol           : arg3,
            uri              : arg4,
            description      : arg5,
            twitter          : arg6,
            telegram         : arg7,
            website          : arg8,
            token_address    : arg9,
            raised           : 0,
            presale_tokens   : 0x2::coin::mint<T0>(arg0, arg10, arg21),
            liquidity_tokens : 0x2::coin::mint<T0>(arg0, arg11, arg21),
            team_tokens      : 0x2::coin::mint<T0>(arg0, arg12, arg21),
            creator_tokens   : 0x2::coin::mint<T0>(arg0, arg13, arg21),
            sui_raised       : 0x2::balance::zero<0x2::sui::SUI>(),
            contributions    : 0x2::table::new<address, u64>(arg21),
            end_time_ms      : arg14,
            team_wallet      : arg15,
            team_cliff_ms    : arg16,
            tokens_burned    : false,
            min_contribution : arg17,
            max_contribution : arg18,
            creation_fee     : arg19,
            fee_balance      : 0,
        };
        let v2 = PresaleCreatedEvent{
            presale_id : 0x2::object::uid_to_inner(&v1.id),
            creator    : 0x2::tx_context::sender(arg21),
        };
        0x2::event::emit<PresaleCreatedEvent>(v2);
        0x2::transfer::public_share_object<Presale<T0>>(v1);
    }

    public entry fun finalize<T0: drop + store + key>(arg0: &mut Presale<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time_ms, 0);
        arg0.fee_balance = arg0.raised * arg0.creation_fee / 1000000;
        let v0 = PresaleFinalizedEvent{
            presale_id   : 0x2::object::uid_to_inner(&arg0.id),
            total_raised : arg0.raised,
        };
        0x2::event::emit<PresaleFinalizedEvent>(v0);
        let v1 = 0x2::coin::value<T0>(&arg0.liquidity_tokens);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.liquidity_tokens, v1, arg3), arg0.team_wallet);
        };
    }

    public fun get_token_address<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v7
}

