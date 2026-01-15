module 0xb::bridge {
    struct Bridge has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct BridgeInner has store {
        bridge_version: u64,
        message_version: u8,
        chain_id: u8,
        sequence_nums: 0x2::vec_map::VecMap<u8, u64>,
        committee: 0xb::committee::BridgeCommittee,
        treasury: 0xb::treasury::BridgeTreasury,
        token_transfer_records: 0x2::linked_table::LinkedTable<0xb::message::BridgeMessageKey, BridgeRecord>,
        limiter: 0xb::limiter::TransferLimiter,
        paused: bool,
    }

    struct TokenDepositedEvent has copy, drop {
        seq_num: u64,
        source_chain: u8,
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        amount: u64,
    }

    struct TokenDepositedEventV2 has copy, drop {
        seq_num: u64,
        source_chain: u8,
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        amount: u64,
        timestamp_ms: u64,
    }

    struct EmergencyOpEvent has copy, drop {
        frozen: bool,
    }

    struct BridgeRecord has drop, store {
        message: 0xb::message::BridgeMessage,
        verified_signatures: 0x1::option::Option<vector<vector<u8>>>,
        claimed: bool,
    }

    struct TokenTransferApproved has copy, drop {
        message_key: 0xb::message::BridgeMessageKey,
    }

    struct TokenTransferClaimed has copy, drop {
        message_key: 0xb::message::BridgeMessageKey,
    }

    struct TokenTransferAlreadyApproved has copy, drop {
        message_key: 0xb::message::BridgeMessageKey,
    }

    struct TokenTransferAlreadyClaimed has copy, drop {
        message_key: 0xb::message::BridgeMessageKey,
    }

    struct TokenTransferLimitExceed has copy, drop {
        message_key: 0xb::message::BridgeMessageKey,
    }

    fun create(arg0: 0x2::object::UID, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 5);
        let v0 = BridgeInner{
            bridge_version         : 1,
            message_version        : 1,
            chain_id               : arg1,
            sequence_nums          : 0x2::vec_map::empty<u8, u64>(),
            committee              : 0xb::committee::create(arg2),
            treasury               : 0xb::treasury::create(arg2),
            token_transfer_records : 0x2::linked_table::new<0xb::message::BridgeMessageKey, BridgeRecord>(arg2),
            limiter                : 0xb::limiter::new(),
            paused                 : false,
        };
        let v1 = Bridge{
            id    : arg0,
            inner : 0x2::versioned::create<BridgeInner>(1, v0, arg2),
        };
        0x2::transfer::share_object<Bridge>(v1);
    }

    public fun approve_token_transfer(arg0: &mut Bridge, arg1: 0xb::message::BridgeMessage, arg2: vector<vector<u8>>) {
        let v0 = load_inner_mut(arg0);
        assert!(!v0.paused, 8);
        0xb::committee::verify_signatures(&v0.committee, arg1, arg2);
        assert!(0xb::message::message_type(&arg1) == 0xb::message_types::token(), 17);
        assert!(0xb::message::message_version(&arg1) <= 0xb::message::token_transfer_message_version(), 12);
        let v1 = if (0xb::message::message_version(&arg1) == 2) {
            let v2 = 0xb::message::extract_token_bridge_payload_v2(&arg1);
            0xb::message::to_token_payload_v1(&v2)
        } else {
            0xb::message::extract_token_bridge_payload(&arg1)
        };
        let v3 = v1;
        assert!(0xb::message::source_chain(&arg1) == v0.chain_id || 0xb::message::token_target_chain(&v3) == v0.chain_id, 4);
        let v4 = 0xb::message::key(&arg1);
        if (0xb::message::source_chain(&arg1) == v0.chain_id) {
            let v5 = 0x2::linked_table::borrow_mut<0xb::message::BridgeMessageKey, BridgeRecord>(&mut v0.token_transfer_records, v4);
            assert!(v5.message == arg1, 2);
            assert!(!v5.claimed, 10);
            if (0x1::option::is_some<vector<vector<u8>>>(&v5.verified_signatures)) {
                let v6 = TokenTransferAlreadyApproved{message_key: v4};
                0x2::event::emit<TokenTransferAlreadyApproved>(v6);
                return
            };
            v5.verified_signatures = 0x1::option::some<vector<vector<u8>>>(arg2);
        } else {
            if (0x2::linked_table::contains<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v4)) {
                let v7 = TokenTransferAlreadyApproved{message_key: v4};
                0x2::event::emit<TokenTransferAlreadyApproved>(v7);
                return
            };
            let v8 = BridgeRecord{
                message             : arg1,
                verified_signatures : 0x1::option::some<vector<vector<u8>>>(arg2),
                claimed             : false,
            };
            0x2::linked_table::push_back<0xb::message::BridgeMessageKey, BridgeRecord>(&mut v0.token_transfer_records, v4, v8);
        };
        let v9 = TokenTransferApproved{message_key: v4};
        0x2::event::emit<TokenTransferApproved>(v9);
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
        let v1 = 0xb::message::create_key(arg2, 0xb::message_types::token(), arg3);
        assert!(0x2::linked_table::contains<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1), 11);
        let v2 = 0x2::linked_table::borrow_mut<0xb::message::BridgeMessageKey, BridgeRecord>(&mut v0.token_transfer_records, v1);
        let v3 = 0xb::message::message_type(&v2.message);
        let v4 = 0xb::message_types::token();
        assert!(&v3 == &v4, 0);
        assert!(0x1::option::is_some<vector<vector<u8>>>(&v2.verified_signatures), 1);
        let v5 = false;
        let v6 = if (0xb::message::message_version(&v2.message) == 2) {
            let v7 = 0xb::message::extract_token_bridge_payload_v2(&v2.message);
            v5 = 0x2::clock::timestamp_ms(arg1) > 0xb::message::timestamp_ms(&v7) + 172800000;
            0xb::message::to_token_payload_v1(&v7)
        } else {
            0xb::message::extract_token_bridge_payload(&v2.message)
        };
        if (v2.claimed) {
            let v8 = TokenTransferAlreadyClaimed{message_key: v1};
            0x2::event::emit<TokenTransferAlreadyClaimed>(v8);
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0x2::address::from_bytes(0xb::message::token_target_address(&v6)))
        };
        let v9 = 0xb::message::token_target_chain(&v6);
        assert!(v9 == v0.chain_id, 4);
        assert!(0xb::treasury::token_id<T0>(&v0.treasury) == 0xb::message::token_type(&v6), 3);
        let v10 = 0xb::message::token_amount(&v6);
        if (!v5 && !0xb::limiter::check_and_record_sending_transfer<T0>(&mut v0.limiter, &v0.treasury, arg1, 0xb::chain_ids::get_route(arg2, v9), v10)) {
            let v11 = TokenTransferLimitExceed{message_key: v1};
            0x2::event::emit<TokenTransferLimitExceed>(v11);
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0x2::address::from_bytes(0xb::message::token_target_address(&v6)))
        };
        v2.claimed = true;
        let v12 = TokenTransferClaimed{message_key: v1};
        0x2::event::emit<TokenTransferClaimed>(v12);
        (0x1::option::some<0x2::coin::Coin<T0>>(0xb::treasury::mint<T0>(&mut v0.treasury, v10, arg4)), 0x2::address::from_bytes(0xb::message::token_target_address(&v6)))
    }

    public fun committee_registration(arg0: &mut Bridge, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xb::committee::register(&mut load_inner_mut(arg0).committee, arg1, arg2, arg3, arg4);
    }

    fun execute_add_tokens_on_sui(arg0: &mut BridgeInner, arg1: 0xb::message::AddTokenOnSui) {
        let v0 = 0xb::message::token_ids(&arg1);
        let v1 = 0xb::message::token_type_names(&arg1);
        let v2 = 0xb::message::token_prices(&arg1);
        assert!(0x1::vector::length<u8>(&v0) == 0x1::vector::length<0x1::ascii::String>(&v1), 2);
        assert!(0x1::vector::length<u8>(&v0) == 0x1::vector::length<u64>(&v2), 2);
        while (0x1::vector::length<u8>(&v0) > 0) {
            0xb::treasury::add_new_token(&mut arg0.treasury, 0x1::vector::pop_back<0x1::ascii::String>(&mut v1), 0x1::vector::pop_back<u8>(&mut v0), 0xb::message::is_native(&arg1), 0x1::vector::pop_back<u64>(&mut v2));
        };
    }

    fun execute_emergency_op(arg0: &mut BridgeInner, arg1: 0xb::message::EmergencyOp) {
        let v0 = 0xb::message::emergency_op_type(&arg1);
        if (v0 == 0xb::message::emergency_op_pause()) {
            assert!(!arg0.paused, 13);
            arg0.paused = true;
            let v1 = EmergencyOpEvent{frozen: true};
            0x2::event::emit<EmergencyOpEvent>(v1);
        } else {
            assert!(v0 == 0xb::message::emergency_op_unpause(), 9);
            assert!(arg0.paused, 14);
            arg0.paused = false;
            let v2 = EmergencyOpEvent{frozen: false};
            0x2::event::emit<EmergencyOpEvent>(v2);
        };
    }

    public fun execute_system_message(arg0: &mut Bridge, arg1: 0xb::message::BridgeMessage, arg2: vector<vector<u8>>) {
        let v0 = 0xb::message::message_type(&arg1);
        assert!(0xb::message::message_version(&arg1) == 1, 12);
        let v1 = load_inner_mut(arg0);
        assert!(0xb::message::source_chain(&arg1) == v1.chain_id, 4);
        let v2 = get_current_seq_num_and_increment(v1, v0);
        assert!(0xb::message::seq_num(&arg1) == v2, 6);
        0xb::committee::verify_signatures(&v1.committee, arg1, arg2);
        if (v0 == 0xb::message_types::emergency_op()) {
            execute_emergency_op(v1, 0xb::message::extract_emergency_op_payload(&arg1));
        } else if (v0 == 0xb::message_types::committee_blocklist()) {
            0xb::committee::execute_blocklist(&mut v1.committee, 0xb::message::extract_blocklist_payload(&arg1));
        } else if (v0 == 0xb::message_types::update_bridge_limit()) {
            execute_update_bridge_limit(v1, 0xb::message::extract_update_bridge_limit(&arg1));
        } else if (v0 == 0xb::message_types::update_asset_price()) {
            execute_update_asset_price(v1, 0xb::message::extract_update_asset_price(&arg1));
        } else {
            assert!(v0 == 0xb::message_types::add_tokens_on_sui(), 0);
            execute_add_tokens_on_sui(v1, 0xb::message::extract_add_tokens_on_sui(&arg1));
        };
    }

    fun execute_update_asset_price(arg0: &mut BridgeInner, arg1: 0xb::message::UpdateAssetPrice) {
        0xb::treasury::update_asset_notional_price(&mut arg0.treasury, 0xb::message::update_asset_price_payload_token_id(&arg1), 0xb::message::update_asset_price_payload_new_price(&arg1));
    }

    fun execute_update_bridge_limit(arg0: &mut BridgeInner, arg1: 0xb::message::UpdateBridgeLimit) {
        let v0 = 0xb::message::update_bridge_limit_payload_receiving_chain(&arg1);
        assert!(v0 == arg0.chain_id, 4);
        let v1 = 0xb::chain_ids::get_route(0xb::message::update_bridge_limit_payload_sending_chain(&arg1), v0);
        0xb::limiter::update_route_limit(&mut arg0.limiter, &v1, 0xb::message::update_bridge_limit_payload_limit(&arg1));
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

    fun get_parsed_token_transfer_message(arg0: &Bridge, arg1: u8, arg2: u64) : 0x1::option::Option<0xb::message::ParsedTokenTransferMessage> {
        let v0 = load_inner(arg0);
        let v1 = 0xb::message::create_key(arg1, 0xb::message_types::token(), arg2);
        if (!0x2::linked_table::contains<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1)) {
            return 0x1::option::none<0xb::message::ParsedTokenTransferMessage>()
        };
        0x1::option::some<0xb::message::ParsedTokenTransferMessage>(0xb::message::to_parsed_token_transfer_message(&0x2::linked_table::borrow<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1).message))
    }

    fun get_token_transfer_action_signatures(arg0: &Bridge, arg1: u8, arg2: u64) : 0x1::option::Option<vector<vector<u8>>> {
        let v0 = load_inner(arg0);
        let v1 = 0xb::message::create_key(arg1, 0xb::message_types::token(), arg2);
        if (!0x2::linked_table::contains<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1)) {
            return 0x1::option::none<vector<vector<u8>>>()
        };
        0x2::linked_table::borrow<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1).verified_signatures
    }

    fun get_token_transfer_action_status(arg0: &Bridge, arg1: u8, arg2: u64) : u8 {
        let v0 = load_inner(arg0);
        let v1 = 0xb::message::create_key(arg1, 0xb::message_types::token(), arg2);
        if (!0x2::linked_table::contains<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1)) {
            return 3
        };
        let v2 = 0x2::linked_table::borrow<0xb::message::BridgeMessageKey, BridgeRecord>(&v0.token_transfer_records, v1);
        if (v2.claimed) {
            return 2
        };
        if (0x1::option::is_some<vector<vector<u8>>>(&v2.verified_signatures)) {
            return 1
        };
        0
    }

    fun init_bridge_committee(arg0: &mut Bridge, arg1: 0x2::vec_map::VecMap<address, u64>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x0, 5);
        let v0 = load_inner_mut(arg0);
        if (0x2::vec_map::is_empty<vector<u8>, 0xb::committee::CommitteeMember>(0xb::committee::committee_members(&v0.committee))) {
            0xb::committee::try_create_next_committee(&mut v0.committee, arg1, arg2, arg3);
        };
    }

    fun load_inner(arg0: &Bridge) : &BridgeInner {
        let v0 = 0x2::versioned::version(&arg0.inner);
        assert!(v0 == 1, 7);
        let v1 = 0x2::versioned::load_value<BridgeInner>(&arg0.inner);
        assert!(v1.bridge_version == v0, 7);
        v1
    }

    fun load_inner_mut(arg0: &mut Bridge) : &mut BridgeInner {
        let v0 = 0x2::versioned::version(&arg0.inner);
        assert!(v0 == 1, 7);
        let v1 = 0x2::versioned::load_value_mut<BridgeInner>(&mut arg0.inner);
        assert!(v1.bridge_version == v0, 7);
        v1
    }

    public fun register_foreign_token<T0>(arg0: &mut Bridge, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::package::UpgradeCap, arg3: &0x2::coin::CoinMetadata<T0>) {
        0xb::treasury::register_foreign_token<T0>(&mut load_inner_mut(arg0).treasury, arg1, arg2, arg3);
    }

    public fun send_token<T0>(arg0: &mut Bridge, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut(arg0);
        let v1 = get_current_seq_num_and_increment(v0, 0xb::message_types::token());
        let v2 = 0xb::treasury::token_id<T0>(&v0.treasury);
        let v3 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg3));
        assert!(0x1::vector::length<u8>(&arg2) == 20, 18);
        assert!(v3 > 0, 19);
        let v4 = 0xb::message::create_token_bridge_message(v0.chain_id, v1, 0x2::address::to_bytes(0x2::tx_context::sender(arg4)), arg1, arg2, v2, v3);
        send_token_internal<T0>(v0, arg1, arg3, v4);
        let v5 = TokenDepositedEvent{
            seq_num        : v1,
            source_chain   : v0.chain_id,
            sender_address : 0x2::address::to_bytes(0x2::tx_context::sender(arg4)),
            target_chain   : arg1,
            target_address : arg2,
            token_type     : v2,
            amount         : v3,
        };
        0x2::event::emit<TokenDepositedEvent>(v5);
    }

    fun send_token_internal<T0>(arg0: &mut BridgeInner, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0xb::message::BridgeMessage) {
        assert!(!arg0.paused, 8);
        assert!(0xb::chain_ids::is_valid_route(arg0.chain_id, arg1), 16);
        0xb::treasury::burn<T0>(&mut arg0.treasury, arg2);
        let v0 = BridgeRecord{
            message             : arg3,
            verified_signatures : 0x1::option::none<vector<vector<u8>>>(),
            claimed             : false,
        };
        0x2::linked_table::push_back<0xb::message::BridgeMessageKey, BridgeRecord>(&mut arg0.token_transfer_records, 0xb::message::key(&arg3), v0);
    }

    public fun send_token_v2<T0>(arg0: &mut Bridge, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut(arg0);
        let v1 = get_current_seq_num_and_increment(v0, 0xb::message_types::token());
        let v2 = 0xb::treasury::token_id<T0>(&v0.treasury);
        let v3 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg3));
        assert!(0x1::vector::length<u8>(&arg2) == 20, 18);
        assert!(v3 > 0, 19);
        let v4 = 0xb::message::create_token_bridge_message_v2(v0.chain_id, v1, 0x2::address::to_bytes(0x2::tx_context::sender(arg5)), arg1, arg2, v2, v3, 0x2::clock::timestamp_ms(arg4));
        send_token_internal<T0>(v0, arg1, arg3, v4);
        let v5 = TokenDepositedEventV2{
            seq_num        : v1,
            source_chain   : v0.chain_id,
            sender_address : 0x2::address::to_bytes(0x2::tx_context::sender(arg5)),
            target_chain   : arg1,
            target_address : arg2,
            token_type     : v2,
            amount         : v3,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TokenDepositedEventV2>(v5);
    }

    public fun update_node_url(arg0: &mut Bridge, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0xb::committee::update_node_url(&mut load_inner_mut(arg0).committee, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

