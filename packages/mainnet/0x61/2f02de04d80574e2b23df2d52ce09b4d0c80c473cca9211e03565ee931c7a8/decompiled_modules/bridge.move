module 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::bridge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Bridge has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct BridgeInner has store {
        bridge_version: u64,
        message_version: u8,
        chain_id: u8,
        fee_recipient: address,
        submitters: 0x2::vec_map::VecMap<address, bool>,
        sequence_nums: 0x2::vec_map::VecMap<u8, u64>,
        committee: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee::BridgeCommittee,
        routes: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::BridgeSupportedRoutes,
        treasury: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::BridgeTreasury,
        token_transfer_records: 0x2::linked_table::LinkedTable<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>,
        limiter: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::limiter::TransferLimiter,
        paused: bool,
    }

    struct TokenWithdrawEvent has copy, drop {
        seq_num: u64,
        source_chain: u8,
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        original_amount: u64,
        amount: u64,
        version: u8,
    }

    struct EmergencyOpEvent has copy, drop {
        frozen: bool,
    }

    struct BridgeRecord has drop, store {
        message: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessage,
        verified_signatures: 0x1::option::Option<vector<vector<u8>>>,
        claimed: bool,
    }

    struct AdminCapVersionUpdated has copy, drop {
        operator: address,
        old_version: u64,
        new_version: u64,
    }

    struct BridgeVersionUpdated has copy, drop {
        operator: address,
        old_version: u64,
        new_version: u64,
    }

    struct TokenTransferApproved has copy, drop {
        message_key: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey,
    }

    struct TokenTransferClaimed has copy, drop {
        message_key: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey,
    }

    struct TokenTransferAlreadyApproved has copy, drop {
        message_key: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey,
    }

    struct TokenTransferAlreadyClaimed has copy, drop {
        message_key: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey,
    }

    struct TokenTransferLimitExceed has copy, drop {
        message_key: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey,
    }

    struct UpdateBridgeSubmitter has copy, drop {
        submitter: address,
        active: bool,
    }

    struct UpdateBridgeFeeRecipient has copy, drop {
        fee_recipient: address,
    }

    fun create(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeInner{
            bridge_version         : 2,
            message_version        : 1,
            chain_id               : arg0,
            fee_recipient          : 0x2::tx_context::sender(arg1),
            submitters             : 0x2::vec_map::empty<address, bool>(),
            sequence_nums          : 0x2::vec_map::empty<u8, u64>(),
            committee              : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee::create(),
            routes                 : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::create(),
            treasury               : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::create(arg1),
            token_transfer_records : 0x2::linked_table::new<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(arg1),
            limiter                : 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::limiter::new(),
            paused                 : false,
        };
        let v1 = Bridge{
            id    : 0x2::object::new(arg1),
            inner : 0x2::versioned::create<BridgeInner>(2, v0, arg1),
        };
        0x2::transfer::share_object<Bridge>(v1);
    }

    public fun approve_token_transfer(arg0: &mut Bridge, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessage, arg2: vector<vector<u8>>, arg3: &0x2::tx_context::TxContext) {
        let v0 = load_inner_mut(arg0);
        assert!(!v0.paused, 8);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_map::contains<address, bool>(&v0.submitters, &v1), 21);
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee::verify_signatures(&v0.committee, arg1, arg2);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::message_type(&arg1) == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token(), 17);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::message_version(&arg1) == 1, 12);
        let v2 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_token_bridge_payload(&arg1);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::source_chain(&arg1) == v0.chain_id || 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_target_chain(&v2) == v0.chain_id, 4);
        let v3 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::key(&arg1);
        if (0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::source_chain(&arg1) == v0.chain_id) {
            let v4 = 0x2::linked_table::borrow_mut<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&mut v0.token_transfer_records, v3);
            assert!(v4.message == arg1, 2);
            assert!(!v4.claimed, 10);
            if (0x1::option::is_some<vector<vector<u8>>>(&v4.verified_signatures)) {
                let v5 = TokenTransferAlreadyApproved{message_key: v3};
                0x2::event::emit<TokenTransferAlreadyApproved>(v5);
                return
            };
            v4.verified_signatures = 0x1::option::some<vector<vector<u8>>>(arg2);
        } else {
            if (0x2::linked_table::contains<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v3)) {
                let v6 = TokenTransferAlreadyApproved{message_key: v3};
                0x2::event::emit<TokenTransferAlreadyApproved>(v6);
                return
            };
            let v7 = BridgeRecord{
                message             : arg1,
                verified_signatures : 0x1::option::some<vector<vector<u8>>>(arg2),
                claimed             : false,
            };
            0x2::linked_table::push_back<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&mut v0.token_transfer_records, v3, v7);
        };
        let v8 = TokenTransferApproved{message_key: v3};
        0x2::event::emit<TokenTransferApproved>(v8);
    }

    public fun assert_admin_version(arg0: &AdminCap) {
        assert!(arg0.version == 2, 23);
    }

    public fun claim_and_transfer_token<T0>(arg0: &mut Bridge, arg1: &0x2::clock::Clock, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_token_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v0;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v2), v1);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v2);
        };
    }

    public fun claim_token<T0>(arg0: &mut Bridge, arg1: &0x2::clock::Clock, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = claim_token_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v0;
        assert!(0x2::tx_context::sender(arg4) == v1, 1);
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&v2), 15);
        0x1::option::destroy_some<0x2::coin::Coin<T0>>(v2)
    }

    fun claim_token_internal<T0>(arg0: &mut Bridge, arg1: &0x2::clock::Clock, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, address) {
        let v0 = load_inner_mut(arg0);
        assert!(!v0.paused, 8);
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::create_key(arg2, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token(), arg3);
        assert!(0x2::linked_table::contains<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1), 11);
        let v2 = 0x2::linked_table::borrow_mut<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&mut v0.token_transfer_records, v1);
        let v3 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::message_type(&v2.message);
        let v4 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token();
        assert!(&v3 == &v4, 0);
        assert!(0x1::option::is_some<vector<vector<u8>>>(&v2.verified_signatures), 1);
        let v5 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_token_bridge_payload(&v2.message);
        if (v2.claimed) {
            let v6 = TokenTransferAlreadyClaimed{message_key: v1};
            0x2::event::emit<TokenTransferAlreadyClaimed>(v6);
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0x2::address::from_bytes(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_target_address(&v5)))
        };
        let v7 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_type(&v5);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_target_chain(&v5) == v0.chain_id, 4);
        let v8 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::get_route(&v0.routes, arg2, v7);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::is_valid_token_id<T0>(&v0.treasury, v7), 3);
        let v9 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_amount(&v5);
        if (!0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::limiter::check_and_record_sending_transfer<T0>(&mut v0.limiter, &v0.treasury, arg1, v8, v9)) {
            let v10 = TokenTransferLimitExceed{message_key: v1};
            0x2::event::emit<TokenTransferLimitExceed>(v10);
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0x2::address::from_bytes(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_target_address(&v5)))
        };
        v2.claimed = true;
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::update_bridge_amount(&mut v0.routes, &v8, v9, true);
        let v11 = TokenTransferClaimed{message_key: v1};
        0x2::event::emit<TokenTransferClaimed>(v11);
        (0x1::option::some<0x2::coin::Coin<T0>>(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::mint<T0>(&mut v0.treasury, v9, arg4)), 0x2::address::from_bytes(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_target_address(&v5)))
    }

    public fun committee_registration(arg0: &mut Bridge, arg1: &AdminCap, arg2: vector<vector<u8>>) {
        assert_admin_version(arg1);
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee::register(&mut load_inner_mut(arg0).committee, arg2);
    }

    public fun create_bridge_committee(arg0: &mut Bridge, arg1: &AdminCap, arg2: 0x2::vec_map::VecMap<vector<u8>, u64>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin_version(arg1);
        init_bridge_committee(arg0, arg2, arg3, arg4);
    }

    public fun create_bridge_committee_by_vec(arg0: &mut Bridge, arg1: &AdminCap, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_admin_version(arg1);
        init_bridge_committee_by_vec(arg0, arg2, arg3, arg4, arg5);
    }

    fun execute_add_routes_on_sui(arg0: &mut BridgeInner, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::AddRoutesOnSui) {
        let v0 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::supported_chain_ids(&arg1);
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::supported_token_ids(&arg1);
        let v2 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::fee_percentages(&arg1);
        let v3 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::bridge_amounts(&arg1);
        let v4 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::supporteds(&arg1);
        assert!(0x1::vector::length<u8>(&v1) == 0x1::vector::length<u8>(&v0), 2);
        assert!(0x1::vector::length<u8>(&v1) == 0x1::vector::length<bool>(&v4), 2);
        assert!(0x1::vector::length<u8>(&v1) == 0x1::vector::length<u64>(&v2), 2);
        assert!(0x1::vector::length<u8>(&v1) == 0x1::vector::length<u64>(&v3), 2);
        while (0x1::vector::length<u8>(&v1) > 0) {
            0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::add_new_route(&mut arg0.routes, 0x1::vector::pop_back<u8>(&mut v0), 0x1::vector::pop_back<u8>(&mut v1), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v3), 0x1::vector::pop_back<bool>(&mut v4));
        };
    }

    fun execute_add_tokens_on_sui(arg0: &mut BridgeInner, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::AddTokenOnSui) {
        let v0 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_ids(&arg1);
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_type_names(&arg1);
        let v2 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::token_prices(&arg1);
        assert!(0x1::vector::length<u8>(&v0) == 0x1::vector::length<0x1::ascii::String>(&v1), 2);
        assert!(0x1::vector::length<u8>(&v0) == 0x1::vector::length<u64>(&v2), 2);
        while (0x1::vector::length<u8>(&v0) > 0) {
            0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::add_new_token(&mut arg0.treasury, 0x1::vector::pop_back<0x1::ascii::String>(&mut v1), 0x1::vector::pop_back<u8>(&mut v0), 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::is_native(&arg1), 0x1::vector::pop_back<u64>(&mut v2));
        };
    }

    fun execute_emergency_op(arg0: &mut BridgeInner, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::EmergencyOp) {
        let v0 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::emergency_op_type(&arg1);
        if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::emergency_op_pause()) {
            assert!(!arg0.paused, 13);
            arg0.paused = true;
            let v1 = EmergencyOpEvent{frozen: true};
            0x2::event::emit<EmergencyOpEvent>(v1);
        } else {
            assert!(v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::emergency_op_unpause(), 9);
            assert!(arg0.paused, 14);
            arg0.paused = false;
            let v2 = EmergencyOpEvent{frozen: false};
            0x2::event::emit<EmergencyOpEvent>(v2);
        };
    }

    public fun execute_system_message(arg0: &mut Bridge, arg1: &AdminCap, arg2: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessage) {
        assert_admin_version(arg1);
        let v0 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::message_type(&arg2);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::message_version(&arg2) == 1, 12);
        let v1 = load_inner_mut(arg0);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::source_chain(&arg2) == v1.chain_id, 4);
        let v2 = get_current_seq_num_and_increment(v1, v0);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::seq_num(&arg2) == v2, 6);
        if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::emergency_op()) {
            execute_emergency_op(v1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_emergency_op_payload(&arg2));
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::committee_blocklist()) {
            0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee::execute_blocklist(&mut v1.committee, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_blocklist_payload(&arg2));
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::update_bridge_limit()) {
            execute_update_bridge_limit(v1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_update_bridge_limit(&arg2));
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::update_asset_price()) {
            execute_update_asset_price(v1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_update_asset_price(&arg2));
        } else if (v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::add_tokens_on_sui()) {
            execute_add_tokens_on_sui(v1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_add_tokens_on_sui(&arg2));
        } else {
            assert!(v0 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::add_routes_on_sui(), 0);
            execute_add_routes_on_sui(v1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::extract_add_routes_on_sui(&arg2));
        };
    }

    fun execute_update_asset_price(arg0: &mut BridgeInner, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::UpdateAssetPrice) {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::update_asset_notional_price(&mut arg0.treasury, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::update_asset_price_payload_token_id(&arg1), 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::update_asset_price_payload_new_price(&arg1));
    }

    fun execute_update_bridge_limit(arg0: &mut BridgeInner, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::UpdateBridgeLimit) {
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::update_bridge_limit_payload_sending_chain(&arg1) != arg0.chain_id, 4);
        let v0 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::get_route(&arg0.routes, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::update_bridge_limit_payload_sending_chain(&arg1), 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::update_bridge_limit_payload_sending_token(&arg1));
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::limiter::update_route_limit(&mut arg0.limiter, &v0, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::update_bridge_limit_payload_limit(&arg1));
    }

    public fun get_current_seq_num(arg0: &Bridge, arg1: u8) : u64 {
        let v0 = 0x2::vec_map::try_get<u8, u64>(&load_inner(arg0).sequence_nums, &arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0)
        } else {
            0
        }
    }

    fun get_current_seq_num_and_increment(arg0: &mut BridgeInner, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, u64>(&arg0.sequence_nums, &arg1)) {
            0x2::vec_map::insert<u8, u64>(&mut arg0.sequence_nums, arg1, 1);
            return 0
        };
        let v0 = 0x2::vec_map::get_mut<u8, u64>(&mut arg0.sequence_nums, &arg1);
        let v1 = *v0;
        *v0 = v1 + 1;
        v1
    }

    fun get_parsed_token_transfer_message(arg0: &Bridge, arg1: u8, arg2: u64) : 0x1::option::Option<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::ParsedTokenTransferMessage> {
        let v0 = load_inner(arg0);
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::create_key(arg1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token(), arg2);
        if (!0x2::linked_table::contains<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1)) {
            return 0x1::option::none<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::ParsedTokenTransferMessage>()
        };
        0x1::option::some<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::ParsedTokenTransferMessage>(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::to_parsed_token_transfer_message(&0x2::linked_table::borrow<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1).message))
    }

    fun get_token_transfer_action_signatures(arg0: &Bridge, arg1: u8, arg2: u64) : 0x1::option::Option<vector<vector<u8>>> {
        let v0 = load_inner(arg0);
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::create_key(arg1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token(), arg2);
        if (!0x2::linked_table::contains<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1)) {
            return 0x1::option::none<vector<vector<u8>>>()
        };
        0x2::linked_table::borrow<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1).verified_signatures
    }

    fun get_token_transfer_action_status(arg0: &Bridge, arg1: u8, arg2: u64) : u8 {
        let v0 = load_inner(arg0);
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::create_key(arg1, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token(), arg2);
        if (!0x2::linked_table::contains<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1)) {
            return 3
        };
        let v2 = 0x2::linked_table::borrow<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1);
        if (v2.claimed) {
            return 2
        };
        if (0x1::option::is_some<vector<vector<u8>>>(&v2.verified_signatures)) {
            return 1
        };
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        create(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::chain_id(), arg0);
    }

    fun init_bridge_committee(arg0: &mut Bridge, arg1: 0x2::vec_map::VecMap<vector<u8>, u64>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee::try_create_next_committee(&mut load_inner_mut(arg0).committee, arg1, arg2, arg3);
    }

    fun init_bridge_committee_by_vec(arg0: &mut Bridge, arg1: vector<vector<u8>>, arg2: vector<u64>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg1) == 0x1::vector::length<u64>(&arg2), 22);
        let v0 = 0x2::vec_map::empty<vector<u8>, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            0x2::vec_map::insert<vector<u8>, u64>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1));
            v1 = v1 + 1;
        };
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee::try_create_next_committee(&mut load_inner_mut(arg0).committee, v0, arg3, arg4);
    }

    fun load_inner(arg0: &Bridge) : &BridgeInner {
        let v0 = 0x2::versioned::version(&arg0.inner);
        assert!(v0 == 2, 7);
        let v1 = 0x2::versioned::load_value<BridgeInner>(&arg0.inner);
        assert!(v1.bridge_version == v0, 7);
        v1
    }

    fun load_inner_mut(arg0: &mut Bridge) : &mut BridgeInner {
        let v0 = 0x2::versioned::version(&arg0.inner);
        assert!(v0 == 2, 7);
        let v1 = 0x2::versioned::load_value_mut<BridgeInner>(&mut arg0.inner);
        assert!(v1.bridge_version == v0, 7);
        v1
    }

    public fun migrate_admin_cap_version(arg0: &mut AdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version < 2, 24);
        arg0.version = 2;
        let v0 = AdminCapVersionUpdated{
            operator    : 0x2::tx_context::sender(arg1),
            old_version : arg0.version,
            new_version : 2,
        };
        0x2::event::emit<AdminCapVersionUpdated>(v0);
    }

    public fun migrate_bridge_version(arg0: &mut AdminCap, arg1: &mut Bridge, arg2: &0x2::tx_context::TxContext) {
        assert_admin_version(arg0);
        assert!(0x2::versioned::version(&arg1.inner) < 2, 24);
        let (v0, v1) = 0x2::versioned::remove_value_for_upgrade<BridgeInner>(&mut arg1.inner);
        let v2 = v0;
        v2.bridge_version = 2;
        0x2::versioned::upgrade<BridgeInner>(&mut arg1.inner, 2, v2, v1);
        let v3 = BridgeVersionUpdated{
            operator    : 0x2::tx_context::sender(arg2),
            old_version : v2.bridge_version,
            new_version : 2,
        };
        0x2::event::emit<BridgeVersionUpdated>(v3);
    }

    public fun register_foreign_token<T0>(arg0: &mut Bridge, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>) {
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::register_foreign_token<T0>(&mut load_inner_mut(arg0).treasury, arg1, arg2);
    }

    public fun send_token<T0>(arg0: &mut Bridge, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut(arg0);
        assert!(!v0.paused, 8);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 18);
        assert!(0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::is_valid_token_id<T0>(&v0.treasury, arg2), 20);
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::get_route(&v0.routes, arg1, arg2);
        let v2 = get_current_seq_num_and_increment(v0, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message_types::token());
        let v3 = 0x2::coin::into_balance<T0>(arg4);
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::get_fees(&v0.routes, &v1, v4);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v5), arg5), v0.fee_recipient);
        };
        let v6 = 0x2::balance::value<T0>(&v3);
        assert!(v4 > 0, 19);
        let v7 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::create_token_bridge_message(v0.chain_id, v2, 0x2::address::to_bytes(0x2::tx_context::sender(arg5)), arg1, arg3, arg2, v4);
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::burn<T0>(&mut v0.treasury, 0x2::coin::from_balance<T0>(v3, arg5));
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::chain_ids::update_bridge_amount(&mut v0.routes, &v1, v6, false);
        let v8 = BridgeRecord{
            message             : v7,
            verified_signatures : 0x1::option::none<vector<vector<u8>>>(),
            claimed             : false,
        };
        0x2::linked_table::push_back<0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessageKey, BridgeRecord>(&mut v0.token_transfer_records, 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::key(&v7), v8);
        let v9 = TokenWithdrawEvent{
            seq_num         : v2,
            source_chain    : v0.chain_id,
            sender_address  : 0x2::address::to_bytes(0x2::tx_context::sender(arg5)),
            target_chain    : arg1,
            target_address  : arg3,
            token_type      : arg2,
            original_amount : v4,
            amount          : v6,
            version         : 1,
        };
        0x2::event::emit<TokenWithdrawEvent>(v9);
    }

    public fun update_fee_recipient(arg0: &mut Bridge, arg1: &AdminCap, arg2: address) {
        assert_admin_version(arg1);
        load_inner_mut(arg0).fee_recipient = arg2;
        let v0 = UpdateBridgeFeeRecipient{fee_recipient: arg2};
        0x2::event::emit<UpdateBridgeFeeRecipient>(v0);
    }

    public fun update_submitter(arg0: &mut Bridge, arg1: &AdminCap, arg2: address, arg3: bool) {
        assert_admin_version(arg1);
        let v0 = load_inner_mut(arg0);
        if (0x2::vec_map::contains<address, bool>(&v0.submitters, &arg2)) {
            *0x2::vec_map::get_mut<address, bool>(&mut v0.submitters, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<address, bool>(&mut v0.submitters, arg2, arg3);
        };
        let v1 = UpdateBridgeSubmitter{
            submitter : arg2,
            active    : arg3,
        };
        0x2::event::emit<UpdateBridgeSubmitter>(v1);
    }

    public fun withdraw_treasury<T0>(arg0: &mut Bridge, arg1: &AdminCap, arg2: address) {
        assert_admin_version(arg1);
        0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::treasury::withdraw_treasury<T0>(&mut load_inner_mut(arg0).treasury, arg2);
    }

    // decompiled from Move bytecode v6
}

