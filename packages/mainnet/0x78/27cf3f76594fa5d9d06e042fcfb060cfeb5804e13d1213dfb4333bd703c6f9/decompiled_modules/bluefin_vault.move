module 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::bluefin_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        perpetual: 0x1::string::String,
        operator: address,
        deposit_paused: bool,
        withdraw_paused: bool,
        depositors: 0x2::table::Table<address, u64>,
        version: u64,
    }

    struct Queue<phantom T0> has key {
        id: 0x2::object::UID,
        requests: 0x2::table::Table<u128, Request>,
        claimable_funds: 0x2::table::Table<address, u64>,
        pointer: u128,
        size: u128,
        coin_balance: 0x2::balance::Balance<T0>,
        version: u64,
    }

    struct Request has drop, store {
        vault_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        amount: u64,
        type: u8,
    }

    entry fun claim_withdrawn_funds<T0>(arg0: &mut Queue<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        assert!(0x2::table::contains<address, u64>(&arg0.claimable_funds, arg1) == true, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::insufficient_funds());
        let v0 = *0x2::table::borrow<address, u64>(&arg0.claimable_funds, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, v0, arg2), arg1);
        0x2::table::remove<address, u64>(&mut arg0.claimable_funds, arg1);
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events::emit_funds_claimed_event(0x2::tx_context::sender(arg2), arg1, v0);
    }

    entry fun create_queue<T0>(arg0: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::AdminCap, arg1: &mut 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::Safe, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::is_queue_created(arg1), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::queue_alread_created());
        let v0 = Queue<T0>{
            id              : 0x2::object::new(arg2),
            requests        : 0x2::table::new<u128, Request>(arg2),
            claimable_funds : 0x2::table::new<address, u64>(arg2),
            pointer         : 0,
            size            : 0,
            coin_balance    : 0x2::balance::zero<T0>(),
            version         : 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(),
        };
        0x2::transfer::share_object<Queue<T0>>(v0);
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::queue_is_created(arg1);
    }

    entry fun create_vault(arg0: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::AdminCap, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = Vault{
            id              : v0,
            perpetual       : v1,
            operator        : arg2,
            deposit_paused  : false,
            withdraw_paused : false,
            depositors      : 0x2::table::new<address, u64>(arg3),
            version         : 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(),
        };
        0x2::transfer::share_object<Vault>(v2);
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events::emit_created_vault_event(0x2::object::uid_to_inner(&v0), v1, arg2);
    }

    entry fun pause_vault(arg0: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::AdminCap, arg1: &mut Vault, arg2: bool, arg3: bool) {
        assert!(arg1.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        arg1.deposit_paused = arg2;
        arg1.withdraw_paused = arg3;
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events::emit_vault_pause_update_event(0x2::object::uid_to_inner(&arg1.id), arg2, arg3);
    }

    entry fun process_queue<T0>(arg0: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::QueueProcessorCap, arg1: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::Safe, arg2: &mut Queue<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::check_safe_version(arg1);
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::check_queue_processor(arg1, arg0);
        let v0 = arg2.size;
        if (arg4 > 0) {
            let v1 = arg2.pointer + arg4;
            let v2 = if (v1 > arg2.size) {
                arg2.size
            } else {
                v1
            };
            v0 = v2;
        };
        let v3 = 0x2::table::new<0x2::object::ID, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::Number>(arg5);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (arg2.pointer < v0) {
            let v5 = 0x2::table::borrow<u128, Request>(&arg2.requests, arg2.pointer);
            if (!0x2::table::contains<0x2::object::ID, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::Number>(&v3, v5.vault_id)) {
                0x2::table::add<0x2::object::ID, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::Number>(&mut v3, v5.vault_id, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::new());
                0x1::vector::push_back<0x2::object::ID>(&mut v4, v5.vault_id);
            };
            let v6 = 0x2::table::borrow_mut<0x2::object::ID, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::Number>(&mut v3, v5.vault_id);
            if (v5.type == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::deposit_type()) {
                *v6 = 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::add_uint(*v6, v5.amount);
            } else if (v5.type == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::withdraw_type()) {
                *v6 = 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::sub_uint(*v6, v5.amount);
                if (!0x2::table::contains<address, u64>(&arg2.claimable_funds, v5.receiver)) {
                    0x2::table::add<address, u64>(&mut arg2.claimable_funds, v5.receiver, 0);
                };
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg2.claimable_funds, v5.receiver);
                *v7 = *v7 + v5.amount;
            };
            arg2.pointer = arg2.pointer + 1;
            0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events::emit_event_processed_event(v5.vault_id, v5.sender, v5.receiver, v5.amount, arg2.pointer, v5.type);
            0x2::table::remove<u128, Request>(&mut arg2.requests, arg2.pointer - 1);
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            let v9 = *0x2::table::borrow<0x2::object::ID, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::Number>(&v3, *0x1::vector::borrow<0x2::object::ID>(&v4, v8));
            if (0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::gt_uint(v9, 0)) {
            };
            v8 = v8 + 1;
        };
        0x2::table::drop<0x2::object::ID, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::signed_number::Number>(v3);
    }

    entry fun request_deposit_to_vault<T0>(arg0: &mut Queue<T0>, arg1: &mut Vault, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        assert!(arg0.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        assert!(!arg1.deposit_paused, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::deposit_paused());
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg3 <= 0x2::coin::value<T0>(arg2), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::insufficient_funds());
        0x2::coin::put<T0>(&mut arg0.coin_balance, 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg2), arg3, arg5));
        let v1 = 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::deposit_type();
        let v2 = 0x2::object::uid_to_inner(&arg1.id);
        let v3 = Request{
            vault_id : v2,
            sender   : v0,
            receiver : arg4,
            amount   : arg3,
            type     : v1,
        };
        0x2::table::add<u128, Request>(&mut arg0.requests, arg0.size, v3);
        arg0.size = arg0.size + 1;
        let v4 = &mut arg1.depositors;
        if (!0x2::table::contains<address, u64>(v4, arg4)) {
            0x2::table::add<address, u64>(v4, arg4, 0);
        };
        let v5 = 0x2::table::borrow_mut<address, u64>(v4, arg4);
        *v5 = *v5 + arg3;
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events::emit_request_queued_event(v2, v0, arg4, arg3, *v5, arg0.pointer, arg0.size, v1);
    }

    entry fun request_withdraw_from_vault<T0>(arg0: &mut Queue<T0>, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        assert!(arg0.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        assert!(!arg1.withdraw_paused, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::withdraw_paused());
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut arg1.depositors;
        assert!(0x2::table::contains<address, u64>(v1, v0) == true, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::insufficient_funds());
        let v2 = 0x2::table::borrow_mut<address, u64>(v1, v0);
        assert!(arg2 <= *v2, 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::insufficient_funds());
        *v2 = *v2 - arg2;
        let v3 = 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::withdraw_type();
        let v4 = 0x2::object::uid_to_inner(&arg1.id);
        let v5 = Request{
            vault_id : v4,
            sender   : v0,
            receiver : arg3,
            amount   : arg2,
            type     : v3,
        };
        0x2::table::add<u128, Request>(&mut arg0.requests, arg0.size, v5);
        arg0.size = arg0.size + 1;
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events::emit_request_queued_event(v4, v0, arg3, arg2, *v2, arg0.pointer, arg0.size, v3);
    }

    entry fun update_vault_operator(arg0: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::AdminCap, arg1: &mut Vault, arg2: address) {
        assert!(arg1.version == 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::constants::get_version(), 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::errors::version_mismatch());
        arg1.operator = arg2;
        0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events::emit_vault_operator_update_event(0x2::object::uid_to_inner(&arg1.id), arg2);
    }

    entry fun update_version_for_queue<T0>(arg0: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::AdminCap, arg1: &mut Queue<T0>) {
        arg1.version = arg1.version + 1;
    }

    entry fun update_version_for_vault(arg0: &0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::roles::AdminCap, arg1: &mut Vault) {
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

