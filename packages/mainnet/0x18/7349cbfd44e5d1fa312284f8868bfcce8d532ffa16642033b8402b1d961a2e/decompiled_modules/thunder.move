module 0xecd7cec9058d82b6c7fbae3cbc0a0c2cf58fe4be2e87679ff9667ee7a0309e0f::thunder {
    struct Signaled has copy, drop {
        name_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct Questfi has copy, drop {
        name_hash: vector<u8>,
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
    }

    struct PrivateSignaled has copy, drop {
        name_hash: vector<u8>,
        timestamp_ms: u64,
        suiami_verified: bool,
    }

    struct FeePaid has copy, drop {
        amount: u64,
        treasury: address,
    }

    struct Storm has key {
        id: 0x2::object::UID,
        signal_fee_mist: u64,
        fee_treasury: address,
        admin: address,
    }

    struct Signal has copy, drop, store {
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
        timestamp_ms: u64,
    }

    struct Thunderstorm has store {
        signals: vector<Signal>,
        last_activity_ms: u64,
    }

    struct SignalV2 has store, key {
        id: 0x2::object::UID,
        recipient: address,
        name_hash: vector<u8>,
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
        timestamp_ms: u64,
    }

    struct SignalV3 has store, key {
        id: 0x2::object::UID,
        recipient: address,
        name_hash: vector<u8>,
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
        entropy: vector<u8>,
        timestamp_ms: u64,
    }

    struct RecipientKey has copy, drop, store {
        recipient: address,
        idx: u64,
    }

    struct RecipientCounter has drop, store {
        count: u64,
    }

    struct SignaledV2 has copy, drop {
        recipient: address,
        name_hash: vector<u8>,
        signal_id: address,
        idx: u64,
        timestamp_ms: u64,
    }

    struct ClaimedV2 has copy, drop {
        recipient: address,
        name_hash: vector<u8>,
        signal_id: address,
        timestamp_ms: u64,
    }

    struct RecipientKeyV3 has copy, drop, store {
        recipient: address,
        idx: u64,
    }

    entry fun claim_v2(arg0: &mut Storm, arg1: address, arg2: u64, arg3: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg3);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        let v2 = RecipientKey{
            recipient : arg1,
            idx       : arg2,
        };
        let v3 = 0x2::dynamic_object_field::remove<RecipientKey, SignalV2>(&mut arg0.id, v2);
        assert!(v3.name_hash == 0x2::hash::keccak256(&v1), 0);
        let v4 = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg3);
        let v5 = 0x2::object::id_to_bytes(&v4);
        let v6 = 0x2::object::id<SignalV2>(&v3);
        let v7 = Questfi{
            name_hash : v3.name_hash,
            payload   : v3.payload,
            aes_key   : xor_bytes(v3.aes_key, 0x2::hash::keccak256(&v5)),
            aes_nonce : v3.aes_nonce,
        };
        0x2::event::emit<Questfi>(v7);
        let v8 = ClaimedV2{
            recipient    : arg1,
            name_hash    : v3.name_hash,
            signal_id    : 0x2::object::id_to_address(&v6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimedV2>(v8);
        let SignalV2 {
            id           : v9,
            recipient    : _,
            name_hash    : _,
            payload      : _,
            aes_key      : _,
            aes_nonce    : _,
            timestamp_ms : _,
        } = v3;
        0x2::object::delete(v9);
    }

    entry fun claim_v2_relay(arg0: &mut Storm, arg1: address, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 4);
        let v0 = RecipientKey{
            recipient : arg1,
            idx       : arg2,
        };
        let v1 = 0x2::dynamic_object_field::remove<RecipientKey, SignalV2>(&mut arg0.id, v0);
        let v2 = 0x2::address::to_bytes(arg3);
        let v3 = 0x2::object::id<SignalV2>(&v1);
        let v4 = Questfi{
            name_hash : v1.name_hash,
            payload   : v1.payload,
            aes_key   : xor_bytes(v1.aes_key, 0x2::hash::keccak256(&v2)),
            aes_nonce : v1.aes_nonce,
        };
        0x2::event::emit<Questfi>(v4);
        let v5 = ClaimedV2{
            recipient    : arg1,
            name_hash    : v1.name_hash,
            signal_id    : 0x2::object::id_to_address(&v3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimedV2>(v5);
        let SignalV2 {
            id           : v6,
            recipient    : _,
            name_hash    : _,
            payload      : _,
            aes_key      : _,
            aes_nonce    : _,
            timestamp_ms : _,
        } = v1;
        0x2::object::delete(v6);
    }

    entry fun claim_v3(arg0: &mut Storm, arg1: address, arg2: u64, arg3: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg3);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        let v2 = RecipientKeyV3{
            recipient : arg1,
            idx       : arg2,
        };
        let v3 = 0x2::dynamic_object_field::remove<RecipientKeyV3, SignalV3>(&mut arg0.id, v2);
        assert!(v3.name_hash == 0x2::hash::keccak256(&v1), 0);
        let v4 = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg3);
        let v5 = 0x2::object::id_to_bytes(&v4);
        xor_bytes(v3.entropy, 0x2::hash::keccak256(&v3.name_hash));
        let v6 = Questfi{
            name_hash : v3.name_hash,
            payload   : v3.payload,
            aes_key   : xor_bytes(v3.aes_key, 0x2::hash::keccak256(&v5)),
            aes_nonce : v3.aes_nonce,
        };
        0x2::event::emit<Questfi>(v6);
        let v7 = 0x2::object::id<SignalV3>(&v3);
        let v8 = ClaimedV2{
            recipient    : arg1,
            name_hash    : v3.name_hash,
            signal_id    : 0x2::object::id_to_address(&v7),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimedV2>(v8);
        let SignalV3 {
            id           : v9,
            recipient    : _,
            name_hash    : _,
            payload      : _,
            aes_key      : _,
            aes_nonce    : _,
            entropy      : _,
            timestamp_ms : _,
        } = v3;
        0x2::object::delete(v9);
    }

    entry fun claim_v3_relay(arg0: &mut Storm, arg1: address, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 4);
        let v0 = RecipientKeyV3{
            recipient : arg1,
            idx       : arg2,
        };
        let v1 = 0x2::dynamic_object_field::remove<RecipientKeyV3, SignalV3>(&mut arg0.id, v0);
        let v2 = 0x2::address::to_bytes(arg3);
        let v3 = Questfi{
            name_hash : v1.name_hash,
            payload   : v1.payload,
            aes_key   : xor_bytes(v1.aes_key, 0x2::hash::keccak256(&v2)),
            aes_nonce : v1.aes_nonce,
        };
        0x2::event::emit<Questfi>(v3);
        let v4 = 0x2::object::id<SignalV3>(&v1);
        let v5 = ClaimedV2{
            recipient    : arg1,
            name_hash    : v1.name_hash,
            signal_id    : 0x2::object::id_to_address(&v4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClaimedV2>(v5);
        let SignalV3 {
            id           : v6,
            recipient    : _,
            name_hash    : _,
            payload      : _,
            aes_key      : _,
            aes_nonce    : _,
            entropy      : _,
            timestamp_ms : _,
        } = v1;
        0x2::object::delete(v6);
    }

    public fun count(arg0: &Storm, arg1: vector<u8>) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            return 0
        };
        0x1::vector::length<Signal>(&0x2::dynamic_field::borrow<vector<u8>, Thunderstorm>(&arg0.id, arg1).signals)
    }

    public fun count_v2(arg0: &Storm, arg1: address) : u64 {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            return 0
        };
        0x2::dynamic_field::borrow<address, RecipientCounter>(&arg0.id, arg1).count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storm{
            id              : 0x2::object::new(arg0),
            signal_fee_mist : 3000000,
            fee_treasury    : 0x2::tx_context::sender(arg0),
            admin           : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Storm>(v0);
    }

    entry fun quest(arg0: &Storm, arg1: vector<u8>, arg2: u64, arg3: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg3);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        assert!(0x2::hash::keccak256(&v1) == arg1, 0);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, Thunderstorm>(&arg0.id, arg1);
        assert!(!0x1::vector::is_empty<Signal>(&v2.signals), 1);
        let v3 = 0x1::vector::borrow<Signal>(&v2.signals, arg2);
        let v4 = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg3);
        let v5 = 0x2::object::id_to_bytes(&v4);
        let v6 = Questfi{
            name_hash : arg1,
            payload   : v3.payload,
            aes_key   : xor_bytes(v3.aes_key, 0x2::hash::keccak256(&v5)),
            aes_nonce : v3.aes_nonce,
        };
        0x2::event::emit<Questfi>(v6);
    }

    entry fun set_admin(arg0: &mut Storm, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.admin = arg1;
    }

    entry fun set_fee_treasury(arg0: &mut Storm, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.fee_treasury = arg1;
    }

    entry fun set_signal_fee(arg0: &mut Storm, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.signal_fee_mist = arg1;
    }

    entry fun signal(arg0: &mut Storm, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg0.signal_fee_mist, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.fee_treasury);
        let v0 = FeePaid{
            amount   : 0x2::coin::value<0x2::sui::SUI>(&arg5),
            treasury : arg0.fee_treasury,
        };
        0x2::event::emit<FeePaid>(v0);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = Signal{
            payload      : arg2,
            aes_key      : arg3,
            aes_nonce    : arg4,
            timestamp_ms : v1,
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
            0x1::vector::push_back<Signal>(&mut v3.signals, v2);
            v3.last_activity_ms = v1;
        } else {
            let v4 = 0x1::vector::empty<Signal>();
            0x1::vector::push_back<Signal>(&mut v4, v2);
            let v5 = Thunderstorm{
                signals          : v4,
                last_activity_ms : v1,
            };
            0x2::dynamic_field::add<vector<u8>, Thunderstorm>(&mut arg0.id, arg1, v5);
        };
        let v6 = Signaled{
            name_hash    : arg1,
            timestamp_ms : v1,
        };
        0x2::event::emit<Signaled>(v6);
    }

    public fun signal_fee(arg0: &Storm) : u64 {
        arg0.signal_fee_mist
    }

    entry fun signal_private(arg0: &mut Storm, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg7, &arg5), 5);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = Signal{
            payload      : arg2,
            aes_key      : arg3,
            aes_nonce    : arg4,
            timestamp_ms : v0,
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
            0x1::vector::push_back<Signal>(&mut v2.signals, v1);
            v2.last_activity_ms = v0;
        } else {
            let v3 = 0x1::vector::empty<Signal>();
            0x1::vector::push_back<Signal>(&mut v3, v1);
            let v4 = Thunderstorm{
                signals          : v3,
                last_activity_ms : v0,
            };
            0x2::dynamic_field::add<vector<u8>, Thunderstorm>(&mut arg0.id, arg1, v4);
        };
        let v5 = PrivateSignaled{
            name_hash       : arg1,
            timestamp_ms    : v0,
            suiami_verified : true,
        };
        0x2::event::emit<PrivateSignaled>(v5);
    }

    entry fun signal_v2(arg0: &mut Storm, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg0.signal_fee_mist, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.fee_treasury);
        let v0 = FeePaid{
            amount   : 0x2::coin::value<0x2::sui::SUI>(&arg6),
            treasury : arg0.fee_treasury,
        };
        0x2::event::emit<FeePaid>(v0);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<address, RecipientCounter>(&mut arg0.id, arg1);
            let v4 = v3.count;
            v3.count = v4 + 1;
            v4
        } else {
            let v5 = RecipientCounter{count: 1};
            0x2::dynamic_field::add<address, RecipientCounter>(&mut arg0.id, arg1, v5);
            0
        };
        let v6 = SignalV2{
            id           : 0x2::object::new(arg8),
            recipient    : arg1,
            name_hash    : arg2,
            payload      : arg3,
            aes_key      : arg4,
            aes_nonce    : arg5,
            timestamp_ms : v1,
        };
        let v7 = 0x2::object::id<SignalV2>(&v6);
        let v8 = RecipientKey{
            recipient : arg1,
            idx       : v2,
        };
        0x2::dynamic_object_field::add<RecipientKey, SignalV2>(&mut arg0.id, v8, v6);
        let v9 = SignaledV2{
            recipient    : arg1,
            name_hash    : arg2,
            signal_id    : 0x2::object::id_to_address(&v7),
            idx          : v2,
            timestamp_ms : v1,
        };
        0x2::event::emit<SignaledV2>(v9);
    }

    entry fun signal_v2_private(arg0: &mut Storm, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg8, &arg6), 5);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<address, RecipientCounter>(&mut arg0.id, arg1);
            let v3 = v2.count;
            v2.count = v3 + 1;
            v3
        } else {
            let v4 = RecipientCounter{count: 1};
            0x2::dynamic_field::add<address, RecipientCounter>(&mut arg0.id, arg1, v4);
            0
        };
        let v5 = SignalV2{
            id           : 0x2::object::new(arg10),
            recipient    : arg1,
            name_hash    : arg2,
            payload      : arg3,
            aes_key      : arg4,
            aes_nonce    : arg5,
            timestamp_ms : v0,
        };
        let v6 = 0x2::object::id<SignalV2>(&v5);
        let v7 = RecipientKey{
            recipient : arg1,
            idx       : v1,
        };
        0x2::dynamic_object_field::add<RecipientKey, SignalV2>(&mut arg0.id, v7, v5);
        let v8 = SignaledV2{
            recipient    : arg1,
            name_hash    : arg2,
            signal_id    : 0x2::object::id_to_address(&v6),
            idx          : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<SignaledV2>(v8);
    }

    entry fun signal_v3(arg0: &mut Storm, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg0.signal_fee_mist, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.fee_treasury);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x2::random::new_generator(arg7, arg9);
        let v2 = if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<address, RecipientCounter>(&mut arg0.id, arg1);
            let v4 = v3.count;
            v3.count = v4 + 1;
            v4
        } else {
            let v5 = RecipientCounter{count: 1};
            0x2::dynamic_field::add<address, RecipientCounter>(&mut arg0.id, arg1, v5);
            0
        };
        let v6 = SignalV3{
            id           : 0x2::object::new(arg9),
            recipient    : arg1,
            name_hash    : arg2,
            payload      : arg3,
            aes_key      : arg4,
            aes_nonce    : arg5,
            entropy      : xor_bytes(0x2::random::generate_bytes(&mut v1, 32), 0x2::hash::keccak256(&arg2)),
            timestamp_ms : v0,
        };
        let v7 = 0x2::object::id<SignalV3>(&v6);
        let v8 = RecipientKeyV3{
            recipient : arg1,
            idx       : v2,
        };
        0x2::dynamic_object_field::add<RecipientKeyV3, SignalV3>(&mut arg0.id, v8, v6);
        let v9 = SignaledV2{
            recipient    : arg1,
            name_hash    : arg2,
            signal_id    : 0x2::object::id_to_address(&v7),
            idx          : v2,
            timestamp_ms : v0,
        };
        0x2::event::emit<SignaledV2>(v9);
    }

    entry fun signal_v3_private(arg0: &mut Storm, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg8, &arg6), 5);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = 0x2::random::new_generator(arg9, arg11);
        let v2 = if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<address, RecipientCounter>(&mut arg0.id, arg1);
            let v4 = v3.count;
            v3.count = v4 + 1;
            v4
        } else {
            let v5 = RecipientCounter{count: 1};
            0x2::dynamic_field::add<address, RecipientCounter>(&mut arg0.id, arg1, v5);
            0
        };
        let v6 = SignalV3{
            id           : 0x2::object::new(arg11),
            recipient    : arg1,
            name_hash    : arg2,
            payload      : arg3,
            aes_key      : arg4,
            aes_nonce    : arg5,
            entropy      : xor_bytes(0x2::random::generate_bytes(&mut v1, 32), 0x2::hash::keccak256(&arg2)),
            timestamp_ms : v0,
        };
        let v7 = 0x2::object::id<SignalV3>(&v6);
        let v8 = RecipientKeyV3{
            recipient : arg1,
            idx       : v2,
        };
        0x2::dynamic_object_field::add<RecipientKeyV3, SignalV3>(&mut arg0.id, v8, v6);
        let v9 = SignaledV2{
            recipient    : arg1,
            name_hash    : arg2,
            signal_id    : 0x2::object::id_to_address(&v7),
            idx          : v2,
            timestamp_ms : v0,
        };
        0x2::event::emit<SignaledV2>(v9);
    }

    entry fun strike(arg0: &mut Storm, arg1: vector<u8>, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v1 = 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0));
        assert!(0x2::hash::keccak256(&v1) == arg1, 0);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
        assert!(!0x1::vector::is_empty<Signal>(&v2.signals), 1);
        let v3 = 0x1::vector::remove<Signal>(&mut v2.signals, 0);
        v2.last_activity_ms = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg2);
        let v5 = 0x2::object::id_to_bytes(&v4);
        let v6 = Questfi{
            name_hash : arg1,
            payload   : v3.payload,
            aes_key   : xor_bytes(v3.aes_key, 0x2::hash::keccak256(&v5)),
            aes_nonce : v3.aes_nonce,
        };
        0x2::event::emit<Questfi>(v6);
    }

    entry fun strike_relay(arg0: &mut Storm, arg1: vector<u8>, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 4);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
        assert!(!0x1::vector::is_empty<Signal>(&v0.signals), 1);
        let v1 = 0x1::vector::remove<Signal>(&mut v0.signals, 0);
        v0.last_activity_ms = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::address::to_bytes(arg2);
        let v3 = Questfi{
            name_hash : arg1,
            payload   : v1.payload,
            aes_key   : xor_bytes(v1.aes_key, 0x2::hash::keccak256(&v2)),
            aes_nonce : v1.aes_nonce,
        };
        0x2::event::emit<Questfi>(v3);
    }

    entry fun sweep(arg0: &mut Storm, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, Thunderstorm>(&arg0.id, arg1);
        assert!(0x1::vector::is_empty<Signal>(&v0.signals), 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.last_activity_ms + 604800000, 2);
        let Thunderstorm {
            signals          : _,
            last_activity_ms : _,
        } = 0x2::dynamic_field::remove<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
    }

    fun xor_bytes(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1) ^ *0x1::vector::borrow<u8>(&arg1, v1 % 0x1::vector::length<u8>(&arg1)));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

