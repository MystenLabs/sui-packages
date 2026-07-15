module 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::bridge {
    struct Bridge has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct BridgeInner has store {
        bridge_version: u64,
        chain_id: u8,
        sequence_nums: 0x2::vec_map::VecMap<u8, u64>,
        committee: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::committee::BridgeCommittee,
        treasury: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury::BridgeTreasury,
        bridge_records: 0x2::linked_table::LinkedTable<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>,
        frozen: bool,
    }

    struct TokenBridgeEvent has copy, drop {
        message_type: u8,
        seq_num: u64,
        source_chain: u8,
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        amount: u64,
    }

    struct BridgeRecord has drop, store {
        message: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessage,
        verified_signatures: 0x1::option::Option<vector<vector<u8>>>,
        claimed: bool,
    }

    struct TokenTransferApproved has copy, drop {
        message_key: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey,
    }

    struct TokenTransferClaimed has copy, drop {
        message_key: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey,
    }

    struct TokenTransferAlreadyApproved has copy, drop {
        message_key: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey,
    }

    struct TokenTransferAlreadyClaimed has copy, drop {
        message_key: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey,
    }

    public fun add_treasury_cap<T0>(arg0: &mut Bridge, arg1: 0x2::coin::TreasuryCap<T0>) {
        0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury::add_treasury_cap<T0>(&mut load_inner_mut(arg0).treasury, arg1);
    }

    public fun approve_bridge_message(arg0: &mut Bridge, arg1: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessage, arg2: vector<vector<u8>>) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::key(&arg1);
        if (0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::message_type(&arg1) == 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::token() && 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::source_chain(&arg1) == v0.chain_id) {
            let v2 = 0x2::linked_table::remove<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&mut v0.bridge_records, v1);
            assert!(v2.message == arg1, 2);
            assert!(!v2.claimed, 13);
            if (0x1::option::is_some<vector<vector<u8>>>(&v2.verified_signatures)) {
                let v3 = TokenTransferAlreadyApproved{message_key: v1};
                0x2::event::emit<TokenTransferAlreadyApproved>(v3);
                0x2::linked_table::push_back<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&mut v0.bridge_records, v1, v2);
                return
            };
        };
        if (0x2::linked_table::contains<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&v0.bridge_records, v1)) {
            let v4 = TokenTransferAlreadyApproved{message_key: v1};
            0x2::event::emit<TokenTransferAlreadyApproved>(v4);
            return
        };
        0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::committee::verify_signatures(&v0.committee, arg1, arg2);
        let v5 = BridgeRecord{
            message             : arg1,
            verified_signatures : 0x1::option::some<vector<vector<u8>>>(arg2),
            claimed             : false,
        };
        0x2::linked_table::push_back<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&mut v0.bridge_records, v1, v5);
        let v6 = TokenTransferApproved{message_key: v1};
        0x2::event::emit<TokenTransferApproved>(v6);
    }

    public fun claim_and_transfer_token<T0>(arg0: &mut Bridge, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_token_internal<T0>(arg0, arg1, arg2, arg3);
        let v2 = v0;
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&v2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v2);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v2), v1);
    }

    public fun claim_token<T0>(arg0: &mut Bridge, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let (v0, v1) = claim_token_internal<T0>(arg0, arg1, arg2, arg3);
        assert!(0x2::tx_context::sender(arg3) == v1, 1);
        v0
    }

    fun claim_token_internal<T0>(arg0: &mut Bridge, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, address) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::create_key(arg1, 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::token(), arg2);
        if (!0x2::linked_table::contains<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&v0.bridge_records, v1)) {
            abort 14
        };
        let BridgeRecord {
            message             : v2,
            verified_signatures : v3,
            claimed             : v4,
        } = 0x2::linked_table::remove<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&mut v0.bridge_records, v1);
        let v5 = v3;
        let v6 = v2;
        assert!(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::message_type(&v6) == 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::token(), 0);
        assert!(0x1::option::is_some<vector<vector<u8>>>(&v5), 1);
        let v7 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::extract_token_bridge_payload(&v6);
        if (v4) {
            let v8 = TokenTransferAlreadyClaimed{message_key: v1};
            0x2::event::emit<TokenTransferAlreadyClaimed>(v8);
            let v9 = BridgeRecord{
                message             : v6,
                verified_signatures : v5,
                claimed             : true,
            };
            0x2::linked_table::push_back<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&mut v0.bridge_records, v1, v9);
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0x2::address::from_bytes(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::token_target_address(&v7)))
        };
        let v10 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::token_target_chain(&v7);
        assert!(v10 == v0.chain_id, 4);
        assert!(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::chain_ids::is_valid_route(arg1, v10), 12);
        assert!(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury::token_id<T0>() == 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::token_type(&v7), 3);
        let v11 = BridgeRecord{
            message             : v6,
            verified_signatures : v5,
            claimed             : true,
        };
        0x2::linked_table::push_back<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&mut v0.bridge_records, v1, v11);
        let v12 = TokenTransferClaimed{message_key: v1};
        0x2::event::emit<TokenTransferClaimed>(v12);
        (0x1::option::some<0x2::coin::Coin<T0>>(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury::mint<T0>(&mut v0.treasury, 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::token_amount(&v7), arg3)), 0x2::address::from_bytes(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::token_target_address(&v7)))
    }

    public fun execute_emergency_op(arg0: &mut Bridge, arg1: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessage, arg2: vector<vector<u8>>) {
        assert!(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::message_type(&arg1) == 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::emergency_op(), 0);
        let v0 = load_inner_mut(arg0);
        let v1 = next_seq_num(v0, 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::emergency_op());
        assert!(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::seq_num(&arg1) == v1, 6);
        0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::committee::verify_signatures(&v0.committee, arg1, arg2);
        let v2 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::extract_emergency_op_payload(&arg1);
        if (0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::emergency_op_type(&v2) == 0) {
        } else {
            assert!(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::emergency_op_type(&v2) == 1, 11);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeInner{
            bridge_version : 1,
            chain_id       : 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::chain_ids::sui_local_test(),
            sequence_nums  : 0x2::vec_map::empty<u8, u64>(),
            committee      : 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::committee::create(arg0),
            treasury       : 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury::create(arg0),
            bridge_records : 0x2::linked_table::new<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(arg0),
            frozen         : false,
        };
        let v1 = Bridge{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<BridgeInner>(1, v0, arg0),
        };
        0x2::transfer::share_object<Bridge>(v1);
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

    fun next_seq_num(arg0: &mut BridgeInner, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, u64>(&arg0.sequence_nums, &arg1)) {
            0x2::vec_map::insert<u8, u64>(&mut arg0.sequence_nums, arg1, 1);
            return 0
        };
        let (v0, v1) = 0x2::vec_map::remove<u8, u64>(&mut arg0.sequence_nums, &arg1);
        0x2::vec_map::insert<u8, u64>(&mut arg0.sequence_nums, v0, v1 + 1);
        v1
    }

    public fun send_token<T0>(arg0: &mut Bridge, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut(arg0);
        assert!(0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::chain_ids::is_valid_route(v0.chain_id, arg1), 12);
        assert!(!v0.frozen, 10);
        let v1 = next_seq_num(v0, 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::token());
        let v2 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury::token_id<T0>();
        let v3 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg3));
        let v4 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::create_token_bridge_message(v0.chain_id, v1, 0x2::address::to_bytes(0x2::tx_context::sender(arg4)), arg1, arg2, v2, v3);
        0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury::burn<T0>(&mut v0.treasury, arg3, arg4);
        let v5 = BridgeRecord{
            message             : v4,
            verified_signatures : 0x1::option::none<vector<vector<u8>>>(),
            claimed             : false,
        };
        0x2::linked_table::push_back<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessageKey, BridgeRecord>(&mut v0.bridge_records, 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::key(&v4), v5);
        let v6 = TokenBridgeEvent{
            message_type   : 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::token(),
            seq_num        : v1,
            source_chain   : v0.chain_id,
            sender_address : 0x2::address::to_bytes(0x2::tx_context::sender(arg4)),
            target_chain   : arg1,
            target_address : arg2,
            token_type     : v2,
            amount         : v3,
        };
        0x2::event::emit<TokenBridgeEvent>(v6);
    }

    // decompiled from Move bytecode v7
}

