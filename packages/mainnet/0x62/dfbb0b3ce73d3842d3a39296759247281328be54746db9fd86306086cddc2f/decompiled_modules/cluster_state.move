module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state {
    struct ValidatorSetAdded has copy, drop {
        validators: vector<vector<u8>>,
        threshold: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        connection_id: 0x1::string::String,
    }

    struct ReceiptKey has copy, drop, store {
        conn_sn: u128,
        nid: 0x1::string::String,
    }

    struct State has store {
        message_fee: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        response_fee: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        receipts: 0x2::vec_map::VecMap<ReceiptKey, bool>,
        conn_sn: u128,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        validators: vector<vector<u8>>,
        validators_threshold: u64,
    }

    public(friend) fun check_save_receipt(arg0: &mut State, arg1: 0x1::string::String, arg2: u128) {
        let v0 = ReceiptKey{
            conn_sn : arg2,
            nid     : arg1,
        };
        assert!(!0x2::vec_map::contains<ReceiptKey, bool>(&arg0.receipts, &v0), 100);
        0x2::vec_map::insert<ReceiptKey, bool>(&mut arg0.receipts, v0, true);
    }

    public(friend) fun claim_fees(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun create() : State {
        State{
            message_fee          : 0x2::vec_map::empty<0x1::string::String, u64>(),
            response_fee         : 0x2::vec_map::empty<0x1::string::String, u64>(),
            receipts             : 0x2::vec_map::empty<ReceiptKey, bool>(),
            conn_sn              : 0,
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            validators           : 0x1::vector::empty<vector<u8>>(),
            validators_threshold : 0,
        }
    }

    public(friend) fun create_admin_cap(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id            : 0x2::object::new(arg1),
            connection_id : arg0,
        }
    }

    public(friend) fun deposit(arg0: &mut State, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun get_fee(arg0: &State, arg1: &0x1::string::String, arg2: bool) : u64 {
        if (arg2 == true) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::get_or_default<0x1::string::String, u64>(&arg0.message_fee, arg1, 0) + 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::get_or_default<0x1::string::String, u64>(&arg0.response_fee, arg1, 0)
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::get_or_default<0x1::string::String, u64>(&arg0.message_fee, arg1, 0)
        }
    }

    public(friend) fun get_next_conn_sn(arg0: &mut State) : u128 {
        let v0 = arg0.conn_sn + 1;
        arg0.conn_sn = v0;
        v0
    }

    public(friend) fun get_receipt(arg0: &State, arg1: 0x1::string::String, arg2: u128) : bool {
        let v0 = ReceiptKey{
            conn_sn : arg2,
            nid     : arg1,
        };
        0x2::vec_map::contains<ReceiptKey, bool>(&arg0.receipts, &v0)
    }

    public fun get_state(arg0: &0x2::bag::Bag, arg1: 0x1::string::String) : &State {
        0x2::bag::borrow<0x1::string::String, State>(arg0, arg1)
    }

    public(friend) fun get_state_mut(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String) : &mut State {
        0x2::bag::borrow_mut<0x1::string::String, State>(arg0, arg1)
    }

    public(friend) fun get_validator_threshold(arg0: &State) : u64 {
        arg0.validators_threshold
    }

    public(friend) fun get_validators(arg0: &State) : vector<vector<u8>> {
        arg0.validators
    }

    public(friend) fun set_fee(arg0: &mut State, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: address) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.message_fee, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg0.message_fee, &arg1);
        };
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.response_fee, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg0.response_fee, &arg1);
        };
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.message_fee, arg1, arg2);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.response_fee, arg1, arg3);
    }

    public(friend) fun set_validator_threshold(arg0: &mut State, arg1: u64) {
        assert!(arg1 <= 0x1::vector::length<vector<u8>>(&arg0.validators), 102);
        arg0.validators_threshold = arg1;
    }

    public(friend) fun set_validators(arg0: &mut State, arg1: vector<vector<u8>>, arg2: u64) {
        arg0.validators = 0x1::vector::empty<vector<u8>>();
        while (0x1::vector::length<vector<u8>>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<vector<u8>>(&mut arg1);
            if (0x1::vector::contains<vector<u8>>(&arg0.validators, &v0)) {
                continue
            };
            0x1::vector::push_back<vector<u8>>(&mut arg0.validators, v0);
        };
        assert!(0x1::vector::length<vector<u8>>(&arg0.validators) >= arg2, 105);
        arg0.validators_threshold = arg2;
        let v1 = ValidatorSetAdded{
            validators : arg0.validators,
            threshold  : arg2,
        };
        0x2::event::emit<ValidatorSetAdded>(v1);
    }

    public(friend) fun validate_admin_cap(arg0: &AdminCap, arg1: 0x1::string::String) {
        assert!(arg0.connection_id == arg1, 106);
    }

    public(friend) fun verify_signatures(arg0: &State, arg1: 0x1::string::String, arg2: u128, arg3: vector<u8>, arg4: 0x1::string::String, arg5: vector<vector<u8>>) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::get_message_hash(arg1, arg2, arg3, arg4);
        let v1 = get_validator_threshold(arg0);
        let v2 = get_validators(arg0);
        assert!(0x1::vector::length<vector<u8>>(&arg5) >= v1, 101);
        let v3 = 0;
        let v4 = 0x1::vector::empty<vector<u8>>();
        while (v3 < 0x1::vector::length<vector<u8>>(&arg5)) {
            let v5 = *0x1::vector::borrow<vector<u8>>(&arg5, v3);
            let v6 = 0x1::vector::pop_back<u8>(&mut v5);
            let v7 = v6;
            let v8 = 27;
            if (v6 >= v8) {
                v7 = v6 - v8;
            };
            0x1::vector::push_back<u8>(&mut v5, v7);
            let v9 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v5, &v0, 0);
            let v10 = 0x2::ecdsa_k1::decompress_pubkey(&v9);
            if (0x1::vector::contains<vector<u8>>(&v2, &v10)) {
                if (!0x1::vector::contains<vector<u8>>(&v4, &v10)) {
                    0x1::vector::push_back<vector<u8>>(&mut v4, v10);
                };
                if (0x1::vector::length<vector<u8>>(&v4) >= v1) {
                    return
                };
            };
            v3 = v3 + 1;
        };
        assert!(0x1::vector::length<vector<u8>>(&v4) >= v1, 104);
    }

    // decompiled from Move bytecode v6
}

