module 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::prediction_agent {
    struct PredictionAgent has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        plans_of: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Plan has key {
        id: 0x2::object::UID,
        policy: 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::Policy,
        wrapper: 0x2::object::ID,
        allowance_name: 0x1::string::String,
        fees: 0x2::table::Table<FeeKey, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>,
    }

    struct FeeKey has copy, drop, store {
        queue: 0x2::object::ID,
        record: u64,
    }

    struct LabelKey has copy, drop, store {
        owner: address,
        name: 0x1::string::String,
    }

    struct Created has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        agent: address,
        wrapper: 0x2::object::ID,
        max_bet: u64,
        max_week: u64,
        expires_ms: u64,
    }

    struct BetQueued has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        wrapper: 0x2::object::ID,
        market: 0x2::object::ID,
        record: u64,
        total_debit: u64,
        budget: u64,
        order_fee: u64,
        application_fee: u64,
        min_quantity: u64,
    }

    struct Returned has copy, drop {
        plan: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Paused has copy, drop {
        plan: 0x2::object::ID,
        paused: bool,
    }

    struct FeeFinalized has copy, drop {
        plan: 0x2::object::ID,
        queue: 0x2::object::ID,
        record: u64,
        paid: u64,
        returned: u64,
    }

    public fun share(arg0: Plan) {
        0x2::transfer::share_object<Plan>(arg0);
    }

    public fun policy(arg0: &Plan) : &0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::Policy {
        &arg0.policy
    }

    public fun create(arg0: &mut Registry, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (Plan, 0x1::string::String) {
        let v0 = 0x2::object::id<0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry>(arg1);
        assert!(0x2::object::id_to_address(&v0) == @0x8c52c6f5b2374e33f4a726d9c32337b1aee3a71410d41c18faa91d938d66e4bc, 20);
        let v1 = 0x2::object::id<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode>(arg2);
        assert!(0x2::object::id_to_address(&v1) == @0xd61b49f8ea4f47cb97fdaa2b99079b079135e0de068e0b92caa8633423083ec0, 20);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0x2::object::new(arg8);
        let v4 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::new_self_owned(arg1, &mut v3, arg8);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::predict_account::set_builder_code(&mut v4, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth_as_object(&mut v3), arg2, arg8);
        let v5 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::id(&v4);
        let v6 = 0x2::address::to_string(0x2::object::uid_to_address(&v3));
        let v7 = LabelKey{
            owner : v2,
            name  : v6,
        };
        0x2::dynamic_field::add<LabelKey, bool>(&mut arg0.id, v7, true);
        let v8 = Plan{
            id             : v3,
            policy         : 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::create(v2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7)),
            wrapper        : v5,
            allowance_name : v6,
            fees           : 0x2::table::new<FeeKey, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg8),
        };
        let v9 = 0x2::object::id<Plan>(&v8);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.plans_of, v2)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.plans_of, v2), v9);
        } else {
            let v10 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v9);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.plans_of, v2, v10);
        };
        let v11 = Created{
            plan       : v9,
            owner      : v2,
            agent      : arg3,
            wrapper    : v5,
            max_bet    : arg4,
            max_week   : arg5,
            expires_ms : arg6,
        };
        0x2::event::emit<Created>(v11);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::share(v4);
        (v8, v8.allowance_name)
    }

    public fun pause(arg0: &mut Plan, arg1: &0x2::tx_context::TxContext) {
        0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::pause(&mut arg0.policy, 0x2::tx_context::sender(arg1));
        let v0 = Paused{
            plan   : 0x2::object::id<Plan>(arg0),
            paused : true,
        };
        0x2::event::emit<Paused>(v0);
    }

    public fun resume(arg0: &mut Plan, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::resume(&mut arg0.policy, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1));
        let v0 = Paused{
            plan   : 0x2::object::id<Plan>(arg0),
            paused : false,
        };
        0x2::event::emit<Paused>(v0);
    }

    public fun application_fee(arg0: u64) : u64 {
        arg0 / 100
    }

    public fun approve(arg0: &Plan, arg1: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::assert_owner(&arg0.policy, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg1);
        assert!(0x2::allowance::funder(v0) == 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::owner(&arg0.policy), 21);
        let v1 = 0x2::allowance::spender(v0);
        let v2 = 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::agent(&arg0.policy);
        assert!(0x1::option::contains<address>(&v1, &v2), 21);
        assert!(0x2::allowance::name(v0) == &arg0.allowance_name, 21);
        let v3 = 0x2::allowance::lifetime_cap(v0);
        let v4 = if (0x1::option::is_some<u256>(&v3)) {
            if (*0x1::option::borrow<u256>(&v3) > 0) {
                *0x1::option::borrow<u256>(&v3) <= (0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::max_week(&arg0.policy) as u256) * 5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 21);
        let v5 = 0x2::allowance::rate_limit(v0);
        assert!(0x1::option::is_some<0x2::allowance::RateLimit>(&v5) && 0x2::allowance::rate_limit_limit(0x1::option::borrow<0x2::allowance::RateLimit>(&v5)) <= (0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::max_week(&arg0.policy) as u256), 21);
        let v6 = 0x2::allowance::periodic_rate_limit(604800000, (0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::max_week(&arg0.policy) as u256));
        assert!(0x2::allowance::rate_limit_window(0x1::option::borrow<0x2::allowance::RateLimit>(&v5)) == 0x2::allowance::rate_limit_window(&v6), 21);
        let v7 = 0x2::allowance::expiration_timestamp_ms(v0);
        assert!(0x1::option::is_some<u64>(&v7) && *0x1::option::borrow<u64>(&v7) <= 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::expires_ms(&arg0.policy), 21);
        0x2::allowance::issue<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, PredictionAgent>(arg1, 0x2::allowance::settings_permit<PredictionAgent>(0x1::internal::permit<PredictionAgent>()), arg2);
    }

    fun assert_wrapper(arg0: &Plan, arg1: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper) {
        assert!(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::id(arg1) == arg0.wrapper, 20);
        assert!(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg1)) == 0x2::object::uid_to_address(&arg0.id), 20);
    }

    public fun create_approved(arg0: &mut Registry, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::BuilderCode, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Plan {
        let v0 = *0x2::allowance::name(0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg7));
        let v1 = LabelKey{
            owner : 0x2::tx_context::sender(arg9),
            name  : v0,
        };
        assert!(!0x2::dynamic_field::exists<LabelKey>(&arg0.id, v1), 21);
        0x2::dynamic_field::add<LabelKey, bool>(&mut arg0.id, v1, true);
        let (v2, _) = create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v4 = v2;
        v4.allowance_name = v0;
        approve(&v4, arg7, arg9);
        v4
    }

    fun draw(arg0: &mut Plan, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::debit(&mut arg0.policy, 0x2::tx_context::sender(arg5), arg3, 0x2::clock::timestamp_ms(arg4));
        let v0 = 0x2::allowance::allowance_settings<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1);
        assert!(0x2::allowance::funder(v0) == 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::owner(&arg0.policy), 21);
        let v1 = 0x2::allowance::spender(v0);
        let v2 = 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::agent(&arg0.policy);
        assert!(0x1::option::contains<address>(&v1, &v2), 21);
        assert!(0x2::allowance::name(v0) == &arg0.allowance_name, 21);
        let v3 = 0x2::allowance::app_balance_spend<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, PredictionAgent>(arg1, 0x2::allowance::spend_permit<PredictionAgent>(0x1::internal::permit<PredictionAgent>()), arg2, arg4, arg5);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3) == arg3, 22);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, arg5)
    }

    public fun finalize_fee(arg0: &mut Plan, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeKey{
            queue  : 0x2::object::id<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue>(arg1),
            record : arg2,
        };
        if (!0x2::table::contains<FeeKey, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0.fees, v0)) {
            return
        };
        let v1 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::order(arg1, arg2);
        let v2 = 0;
        if (0x1::option::is_some<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v1)) {
            let v3 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::result(0x1::option::borrow<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::OrderView>(&v1));
            if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::finished_at_ms(&v3) == 0) {
                return
            };
            if (0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::reason(&v3) == 0 && 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::result_quantity(&v3) > 0) {
                v2 = application_fee(0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue::result_amount(&v3));
            };
        };
        let v4 = 0x2::table::remove<FeeKey, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.fees, v0);
        assert!(v2 <= 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4), 22);
        if (v2 > 0) {
            0x2::coin::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v4, v2), arg3), @0x99f97251af2d072fc492316ae30de3ab5639beb09073509d54bf49197513b4);
        };
        let v5 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4);
        if (v5 > 0) {
            0x2::coin::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, arg3), 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::owner(&arg0.policy));
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4);
        };
        let v6 = FeeFinalized{
            plan     : 0x2::object::id<Plan>(arg0),
            queue    : 0x2::object::id<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue>(arg1),
            record   : arg2,
            paid     : v2,
            returned : v5,
        };
        0x2::event::emit<FeeFinalized>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg0),
            plans_of : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun place_bet(arg0: &mut Plan, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg3: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg4: &mut 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue, arg5: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg6: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk, arg7: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg8: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg9: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg10: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg11: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::accumulator::AccumulatorRoot, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
        assert_wrapper(arg0, arg3);
        let v0 = 0x2::object::id<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::OrderDesk>(arg6);
        let v1 = if (0x2::object::id_to_address(&v0) == @0x87b0a87262aacf58eaff567eed2fb7cb0f9cbc1f5ce33ef79216cd26d13a1b5b) {
            let v2 = 0x2::object::id<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig>(arg7);
            0x2::object::id_to_address(&v2) == @0x5fa6efbe7691809565a660adde23f0c184ca1d19cefafa4e1c88d655fe279580
        } else {
            false
        };
        assert!(v1, 20);
        let v3 = 0x2::object::id<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry>(arg8);
        let v4 = if (0x2::object::id_to_address(&v3) == @0x5d62c0d9be43efa769a708ade53fbe5bea98c15c865b64ca7c498c87b045a698) {
            let v5 = 0x2::object::id<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed>(arg9);
            0x2::object::id_to_address(&v5) == @0x4c5d2b4c8238f04b7687c3a8df915b69c50d5f4d291fc49aea44bdb6b52e1a20
        } else {
            false
        };
        assert!(v4, 20);
        let v6 = 0x2::object::id<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore>(arg10);
        let v7 = if (0x2::object::id_to_address(&v6) == @0xe83f843b15ae63045b2cea445fb8ea7ad85c5fc2a05f66db122a511e1f2c67bc) {
            let v8 = 0x2::object::id<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore>(arg11);
            0x2::object::id_to_address(&v8) == @0xfdd447be39d847747caf18ecf3355031bb33979c472581f1a5481375d3748bfb
        } else {
            false
        };
        assert!(v7, 20);
        assert!(arg14 >= 1000000, 23);
        assert!(arg15 > 0, 24);
        let v9 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::desk::policy(arg6);
        let v10 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::order_fee(&v9);
        let v11 = application_fee(arg14);
        let v12 = arg14 + v10 + v11;
        let v13 = draw(arg0, arg1, arg2, v12, arg17, arg18);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth_as_object(&mut arg0.id), v13, arg16, arg17);
        let v14 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::enqueue_exact_cost(arg4, arg5, arg3, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth_as_object(&mut arg0.id), arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v15 = FeeKey{
            queue  : 0x2::object::id<0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::queue::MarketQueue>(arg4),
            record : v14,
        };
        0x2::table::add<FeeKey, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.fees, v15, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v13, v11, arg18)));
        let v16 = BetQueued{
            plan            : 0x2::object::id<Plan>(arg0),
            owner           : 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::owner(&arg0.policy),
            wrapper         : arg0.wrapper,
            market          : 0x2::object::id<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket>(arg5),
            record          : v14,
            total_debit     : v12,
            budget          : arg14,
            order_fee       : v10,
            application_fee : v11,
            min_quantity    : arg15,
        };
        0x2::event::emit<BetQueued>(v16);
        v14
    }

    public fun plans_of(arg0: &Registry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.plans_of, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.plans_of, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun return_funds(arg0: &mut Plan, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_wrapper(arg0, arg1);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg1), arg2, arg3);
        if (v0 == 0) {
            return
        };
        let v1 = 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission::owner(&arg0.policy);
        0x2::coin::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth_as_object(&mut arg0.id), v0, arg2, arg3, arg4), v1);
        let v2 = Returned{
            plan   : 0x2::object::id<Plan>(arg0),
            owner  : v1,
            amount : v0,
        };
        0x2::event::emit<Returned>(v2);
    }

    public fun wrapper(arg0: &Plan) : 0x2::object::ID {
        arg0.wrapper
    }

    // decompiled from Move bytecode v7
}

