module 0x18cd2226591d77ddca2c8d411e966fd4a2b215a83cddd39b58b5ddb2f616833e::ai_inference {
    struct UserDeposit<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PendingRequest has copy, drop, store {
        request_hash: vector<u8>,
        estimated_amount: u64,
        created_at: u64,
    }

    struct AIInferenceStorage<phantom T0> has key {
        id: 0x2::object::UID,
        pending_requests: 0x2::table::Table<address, vector<PendingRequest>>,
        fee_balance: 0x2::balance::Balance<T0>,
        min_deposit_amount: u64,
        estimated_settlement_gas_fee: u64,
        estimated_nesa_gas_fee: u64,
        estimated_ai_inference_fee: u64,
    }

    public entry fun add_deposit<T0>(arg0: &mut AIInferenceStorage<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::dynamic_object_field::exists_<address>(&arg0.id, v0)) {
            0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<address, UserDeposit<T0>>(&mut arg0.id, v0).balance, 0x2::coin::into_balance<T0>(arg1));
        } else {
            let v1 = UserDeposit<T0>{
                id      : 0x2::object::new(arg2),
                user    : v0,
                balance : 0x2::coin::into_balance<T0>(arg1),
            };
            0x2::dynamic_object_field::add<address, UserDeposit<T0>>(&mut arg0.id, v0, v1);
        };
    }

    public entry fun batch_settle_off_chain_requests<T0>(arg0: &mut AIInferenceStorage<T0>, arg1: address, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, UserDeposit<T0>>(&mut arg0.id, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(0x2::balance::value<T0>(&v0.balance) >= v2, 3);
            0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::balance::split<T0>(&mut v0.balance, v2));
            v1 = v1 + 1;
        };
        if (0x2::table::contains<address, vector<PendingRequest>>(&arg0.pending_requests, arg1)) {
            let v3 = 0x2::table::borrow_mut<address, vector<PendingRequest>>(&mut arg0.pending_requests, arg1);
            let v4 = 0x1::vector::empty<PendingRequest>();
            let v5 = 0;
            while (v5 < 0x1::vector::length<PendingRequest>(v3)) {
                let v6 = *0x1::vector::borrow<PendingRequest>(v3, v5);
                let v7 = false;
                let v8 = 0;
                while (v8 < 0x1::vector::length<vector<u8>>(&arg2)) {
                    if (v6.request_hash == *0x1::vector::borrow<vector<u8>>(&arg2, v8)) {
                        v7 = true;
                        break
                    };
                    v8 = v8 + 1;
                };
                if (!v7) {
                    0x1::vector::push_back<PendingRequest>(&mut v4, v6);
                };
                v5 = v5 + 1;
            };
            if (0x1::vector::length<PendingRequest>(&v4) == 0) {
                0x2::table::remove<address, vector<PendingRequest>>(&mut arg0.pending_requests, arg1);
            } else {
                *v3 = v4;
            };
        };
    }

    public fun get_available_refund_amount<T0>(arg0: &AIInferenceStorage<T0>, arg1: address) : u64 {
        get_available_refund_amount_internal<T0>(arg0, arg1)
    }

    fun get_available_refund_amount_internal<T0>(arg0: &AIInferenceStorage<T0>, arg1: address) : u64 {
        if (!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1)) {
            return 0
        };
        let v0 = 0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<address, UserDeposit<T0>>(&arg0.id, arg1).balance);
        let v1 = if (0x2::table::contains<address, vector<PendingRequest>>(&arg0.pending_requests, arg1)) {
            let v2 = 0x2::table::borrow<address, vector<PendingRequest>>(&arg0.pending_requests, arg1);
            let v3 = 0;
            let v4 = 0;
            while (v4 < 0x1::vector::length<PendingRequest>(v2)) {
                v3 = v3 + 0x1::vector::borrow<PendingRequest>(v2, v4).estimated_amount;
                v4 = v4 + 1;
            };
            v3
        } else {
            0
        };
        let v5 = if (v1 > 0) {
            1000000
        } else {
            0
        };
        if (v0 > v5) {
            v0 - v5
        } else {
            0
        }
    }

    public fun get_user_deposit<T0>(arg0: &AIInferenceStorage<T0>, arg1: address) : u64 {
        if (!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<address, UserDeposit<T0>>(&arg0.id, arg1).balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun init_storage<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AIInferenceStorage<T0>{
            id                           : 0x2::object::new(arg0),
            pending_requests             : 0x2::table::new<address, vector<PendingRequest>>(arg0),
            fee_balance                  : 0x2::balance::zero<T0>(),
            min_deposit_amount           : 1000000,
            estimated_settlement_gas_fee : 100000,
            estimated_nesa_gas_fee       : 200000,
            estimated_ai_inference_fee   : 700000,
        };
        0x2::transfer::share_object<AIInferenceStorage<T0>>(v0);
    }

    public entry fun record_off_chain_request<T0>(arg0: &mut AIInferenceStorage<T0>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg2), 2);
        assert!(0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<address, UserDeposit<T0>>(&arg0.id, arg2).balance) >= arg0.min_deposit_amount, 0);
        let v0 = PendingRequest{
            request_hash     : arg1,
            estimated_amount : arg3,
            created_at       : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        if (0x2::table::contains<address, vector<PendingRequest>>(&arg0.pending_requests, arg2)) {
            0x1::vector::push_back<PendingRequest>(0x2::table::borrow_mut<address, vector<PendingRequest>>(&mut arg0.pending_requests, arg2), v0);
        } else {
            let v1 = 0x1::vector::empty<PendingRequest>();
            0x1::vector::push_back<PendingRequest>(&mut v1, v0);
            0x2::table::add<address, vector<PendingRequest>>(&mut arg0.pending_requests, arg2, v1);
        };
    }

    public entry fun refund_deposit<T0>(arg0: &mut AIInferenceStorage<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 2);
        let v1 = get_available_refund_amount_internal<T0>(arg0, v0);
        let v2 = 0x2::dynamic_object_field::borrow_mut<address, UserDeposit<T0>>(&mut arg0.id, v0);
        assert!(v1 > 0, 0);
        let v3 = if (arg1 == 0) {
            v1
        } else {
            assert!(arg1 <= v1, 0);
            arg1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, v3), arg2), v0);
        if (0x2::balance::value<T0>(&v2.balance) == 0) {
            let UserDeposit {
                id      : v4,
                user    : _,
                balance : v6,
            } = 0x2::dynamic_object_field::remove<address, UserDeposit<T0>>(&mut arg0.id, v0);
            0x2::balance::join<T0>(&mut arg0.fee_balance, v6);
            0x2::object::delete(v4);
        };
    }

    // decompiled from Move bytecode v7
}

