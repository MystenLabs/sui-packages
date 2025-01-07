module 0x73c675be3a4ed34e5194b24de4d48920de50353171ef433883d71d26bf78bba7::multisig {
    struct MultisigAccount has store, key {
        id: 0x2::object::UID,
        admin: 0x2::object::ID,
        version: u64,
        name: 0x1::string::String,
        signers: 0x2::vec_map::VecMap<address, 0x1::string::String>,
        threshold: u64,
        creator: address,
        tokens: 0x2::object_bag::ObjectBag,
        txs: 0x2::object_table::ObjectTable<0x1::string::String, Transaction>,
        create_time: u64,
    }

    struct Transaction has store, key {
        id: 0x2::object::UID,
        type: u8,
        status: u8,
        balance: u64,
        from_type: u8,
        to_type: u8,
        from_address: address,
        to_address: address,
        from_multisig_id: 0x2::object::ID,
        to_multisig_id: 0x2::object::ID,
        locked_before: u64,
        approvers: vector<Signature>,
        rejectors: vector<Signature>,
        creator: address,
        create_time: u64,
        approver: address,
        approve_time: u64,
        rejector: address,
        reject_time: u64,
        executor: address,
        execute_time: u64,
        transaction_name: 0x1::string::String,
        token_name: 0x1::string::String,
        multisig_id: 0x2::object::ID,
    }

    struct Signature has copy, drop, store {
        signer: address,
        time: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ApproveCap has key {
        id: 0x2::object::UID,
        multisig_account_id: 0x2::object::ID,
    }

    struct CreateMultisigEvent has copy, drop {
        account_id: 0x2::object::ID,
        creator: address,
    }

    struct DepositEvent has copy, drop {
        account_id: 0x2::object::ID,
        transaction_id: 0x2::object::ID,
    }

    struct CreateTransactionEvent has copy, drop {
        account_id: 0x2::object::ID,
        transaction_id: 0x2::object::ID,
    }

    struct ApproveEvent has copy, drop {
        account_id: 0x2::object::ID,
        transaction_id: 0x2::object::ID,
        approver: address,
        operate: u8,
    }

    struct RejectEvent has copy, drop {
        account_id: 0x2::object::ID,
        transaction_id: 0x2::object::ID,
        rejector: address,
        operate: u8,
    }

    struct ExecuteTransactionEvent has copy, drop {
        account_id: 0x2::object::ID,
        transaction_id: 0x2::object::ID,
    }

    public entry fun approve_transaction(arg0: &mut MultisigAccount, arg1: vector<u8>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 111);
        check_signer(arg0, arg4);
        check_operate(arg2);
        let v0 = 0x2::object_table::borrow_mut<0x1::string::String, Transaction>(&mut arg0.txs, 0x1::string::utf8(arg1));
        assert!(v0.type == 2, 23);
        assert!(v0.status == 1, 19);
        if (v0.locked_before > 0) {
            assert!(v0.locked_before > 0x2::clock::timestamp_ms(arg3), 9);
        };
        let v1 = 0x2::tx_context::sender(arg4);
        if (arg2 == 1) {
            assert!(!is_approver(v0.approvers, v1), 13);
            assert!(!is_rejector(v0.rejectors, v1), 18);
            let v2 = Signature{
                signer : v1,
                time   : 0x2::clock::timestamp_ms(arg3),
            };
            0x1::vector::push_back<Signature>(&mut v0.approvers, v2);
            if (0x1::vector::length<Signature>(&v0.approvers) >= arg0.threshold) {
                v0.status = 2;
            };
            v0.approver = v1;
            v0.approve_time = 0x2::clock::timestamp_ms(arg3);
            let v3 = ApproveEvent{
                account_id     : 0x2::object::id<MultisigAccount>(arg0),
                transaction_id : 0x2::object::id<Transaction>(v0),
                approver       : v1,
                operate        : arg2,
            };
            0x2::event::emit<ApproveEvent>(v3);
        } else {
            assert!(!is_rejector(v0.rejectors, v1), 18);
            assert!(!is_approver(v0.approvers, v1), 13);
            let v4 = Signature{
                signer : v1,
                time   : 0x2::clock::timestamp_ms(arg3),
            };
            0x1::vector::push_back<Signature>(&mut v0.rejectors, v4);
            if (0x1::vector::length<Signature>(&v0.rejectors) >= 0x2::vec_map::size<address, 0x1::string::String>(&arg0.signers) - arg0.threshold + 1) {
                v0.status = 3;
            };
            v0.rejector = v1;
            v0.reject_time = 0x2::clock::timestamp_ms(arg3);
            let v5 = RejectEvent{
                account_id     : 0x2::object::id<MultisigAccount>(arg0),
                transaction_id : 0x2::object::id<Transaction>(v0),
                rejector       : v1,
                operate        : arg2,
            };
            0x2::event::emit<RejectEvent>(v5);
        };
    }

    fun borrow_signer(arg0: &Signature) : &address {
        &arg0.signer
    }

    fun build_signers(arg0: vector<address>, arg1: vector<vector<u8>>) : 0x2::vec_map::VecMap<address, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<address, 0x1::string::String>();
        let v1 = 0x1::vector::length<address>(&arg0);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg1), 15);
        let v2 = 0;
        while (v2 < v1) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut v0, *0x1::vector::borrow<address>(&arg0, v2), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun cap_account_id(arg0: &ApproveCap) : 0x2::object::ID {
        arg0.multisig_account_id
    }

    fun check_balance(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 20);
        if (arg1 > 0) {
            assert!(arg0 == arg1, 20);
        };
    }

    fun check_locked_before(arg0: u64, arg1: &0x2::clock::Clock) {
        if (arg0 != 0) {
            assert!(arg0 >= 0x2::clock::timestamp_ms(arg1), 10);
        };
    }

    fun check_operate(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 15);
    }

    fun check_partner_type(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 24);
    }

    fun check_signer(arg0: &MultisigAccount, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_map::contains<address, 0x1::string::String>(&arg0.signers, &v0), 4);
    }

    public entry fun create_multisig_account(arg0: u64, arg1: vector<u8>, arg2: vector<address>, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x1::vector::length<address>(&arg2);
        assert!(arg0 >= v3 / 2 + v3 % 2 && arg0 <= v3, 1);
        let v4 = build_signers(arg2, arg3);
        assert!(0x2::vec_map::get_idx<address, 0x1::string::String>(&v4, &v2) == 0, 16);
        assert!(0x2::vec_map::size<address, 0x1::string::String>(&v4) >= 2 && 0x2::vec_map::size<address, 0x1::string::String>(&v4) <= 10, 4);
        let v5 = AdminCap{id: 0x2::object::new(arg5)};
        let v6 = MultisigAccount{
            id          : v0,
            admin       : 0x2::object::id<AdminCap>(&v5),
            version     : 1,
            name        : 0x1::string::utf8(arg1),
            signers     : v4,
            threshold   : arg0,
            creator     : v2,
            tokens      : 0x2::object_bag::new(arg5),
            txs         : 0x2::object_table::new<0x1::string::String, Transaction>(arg5),
            create_time : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::share_object<MultisigAccount>(v6);
        0x2::transfer::transfer<AdminCap>(v5, 0x2::tx_context::sender(arg5));
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&arg2)) {
            transfer_admin_cap(*0x1::vector::borrow<address>(&arg2, v7), arg5);
            transfer_approve_cap(v1, *0x1::vector::borrow<address>(&arg2, v7), arg5);
            v7 = v7 + 1;
        };
        let v8 = CreateMultisigEvent{
            account_id : v1,
            creator    : v2,
        };
        0x2::event::emit<CreateMultisigEvent>(v8);
    }

    public entry fun create_transaction(arg0: &mut MultisigAccount, arg1: u64, arg2: u8, arg3: address, arg4: &mut MultisigAccount, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 111);
        assert!(arg4.version == 1, 111);
        check_signer(arg0, arg9);
        check_partner_type(arg2);
        check_balance(arg1, 0);
        check_locked_before(arg7, arg8);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::new(arg9);
        let v2 = 0x1::string::utf8(arg5);
        assert!(!0x1::string::is_empty(&v2), 22);
        let v3 = 0x1::string::utf8(arg6);
        assert!(!0x1::string::is_empty(&v3), 21);
        let v4 = Signature{
            signer : v0,
            time   : 0x2::clock::timestamp_ms(arg8),
        };
        let v5 = 0x1::vector::empty<Signature>();
        0x1::vector::push_back<Signature>(&mut v5, v4);
        let v6 = Transaction{
            id               : v1,
            type             : 2,
            status           : 1,
            balance          : arg1,
            from_type        : 2,
            to_type          : arg2,
            from_address     : v0,
            to_address       : arg3,
            from_multisig_id : 0x2::object::id<MultisigAccount>(arg0),
            to_multisig_id   : 0x2::object::id<MultisigAccount>(arg4),
            locked_before    : arg7,
            approvers        : v5,
            rejectors        : 0x1::vector::empty<Signature>(),
            creator          : v0,
            create_time      : 0x2::clock::timestamp_ms(arg8),
            approver         : v0,
            approve_time     : 0x2::clock::timestamp_ms(arg8),
            rejector         : v0,
            reject_time      : 0,
            executor         : v0,
            execute_time     : 0,
            transaction_name : v2,
            token_name       : v3,
            multisig_id      : 0x2::object::id<MultisigAccount>(arg0),
        };
        assert!(!0x2::object_table::contains<0x1::string::String, Transaction>(&arg0.txs, v2), 14);
        if (0x1::vector::length<Signature>(&v6.approvers) >= arg0.threshold) {
            v6.status = 2;
        };
        0x2::object_table::add<0x1::string::String, Transaction>(&mut arg0.txs, v2, v6);
        let v7 = CreateTransactionEvent{
            account_id     : 0x2::object::id<MultisigAccount>(arg0),
            transaction_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::event::emit<CreateTransactionEvent>(v7);
    }

    public entry fun deposit<T0>(arg0: &mut MultisigAccount, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 111);
        check_signer(arg0, arg6);
        check_balance(arg1, 0x2::coin::value<T0>(&arg4));
        let v0 = 0x1::string::utf8(arg3);
        assert!(!0x1::string::is_empty(&v0), 21);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::object::new(arg6);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x1::string::utf8(arg2);
        assert!(!0x1::string::is_empty(&v4), 22);
        let v5 = Transaction{
            id               : v2,
            type             : 1,
            status           : 4,
            balance          : arg1,
            from_type        : 1,
            to_type          : 2,
            from_address     : v1,
            to_address       : v1,
            from_multisig_id : 0x2::object::id<MultisigAccount>(arg0),
            to_multisig_id   : 0x2::object::id<MultisigAccount>(arg0),
            locked_before    : 0,
            approvers        : 0x1::vector::empty<Signature>(),
            rejectors        : 0x1::vector::empty<Signature>(),
            creator          : v1,
            create_time      : 0x2::clock::timestamp_ms(arg5),
            approver         : v1,
            approve_time     : 0x2::clock::timestamp_ms(arg5),
            rejector         : v1,
            reject_time      : 0,
            executor         : v1,
            execute_time     : 0x2::clock::timestamp_ms(arg5),
            transaction_name : v4,
            token_name       : v0,
            multisig_id      : 0x2::object::id<MultisigAccount>(arg0),
        };
        assert!(!0x2::object_table::contains<0x1::string::String, Transaction>(&arg0.txs, v4), 14);
        0x2::object_table::add<0x1::string::String, Transaction>(&mut arg0.txs, v4, v5);
        if (!0x2::object_bag::contains<0x1::string::String>(&arg0.tokens, v0)) {
            0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.tokens, v0, arg4);
        } else {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.tokens, v0), arg4);
        };
        let v6 = DepositEvent{
            account_id     : 0x2::object::id<MultisigAccount>(arg0),
            transaction_id : v3,
        };
        0x2::event::emit<DepositEvent>(v6);
        let v7 = CreateTransactionEvent{
            account_id     : 0x2::object::id<MultisigAccount>(arg0),
            transaction_id : v3,
        };
        0x2::event::emit<CreateTransactionEvent>(v7);
    }

    public entry fun execute_transaction<T0>(arg0: &mut MultisigAccount, arg1: &mut MultisigAccount, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 111);
        assert!(arg1.version == 1, 111);
        check_signer(arg0, arg4);
        let v0 = 0x2::object::id<MultisigAccount>(arg0);
        let v1 = 0x2::object::id<MultisigAccount>(arg1);
        let v2 = 0x2::object_table::borrow_mut<0x1::string::String, Transaction>(&mut arg0.txs, 0x1::string::utf8(arg2));
        assert!(v2.type == 2, 23);
        assert!(v2.status == 2, 19);
        if (v2.locked_before > 0) {
            assert!(v2.locked_before > 0x2::clock::timestamp_ms(arg3), 9);
        };
        assert!(0x1::vector::length<Signature>(&v2.approvers) >= arg0.threshold, 5);
        v2.executor = 0x2::tx_context::sender(arg4);
        v2.execute_time = 0x2::clock::timestamp_ms(arg3);
        v2.status = 4;
        assert!(0x2::object_bag::contains<0x1::string::String>(&arg0.tokens, v2.token_name), 11);
        if (v2.to_type == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.tokens, v2.token_name)), v2.balance, arg4), v2.to_address);
        } else {
            assert!(v2.to_multisig_id == v1, 27);
            let v3 = 0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.tokens, v2.token_name);
            assert!(v0 != v1, 15);
            if (!0x2::object_bag::contains<0x1::string::String>(&arg1.tokens, v2.token_name)) {
                0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg1.tokens, v2.token_name, 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(v3), v2.balance, arg4));
            } else {
                0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg1.tokens, v2.token_name), 0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(v3), v2.balance, arg4));
            };
            let v4 = 0x2::tx_context::sender(arg4);
            let v5 = 0x2::object::new(arg4);
            let v6 = Transaction{
                id               : v5,
                type             : 1,
                status           : 4,
                balance          : v2.balance,
                from_type        : 2,
                to_type          : 2,
                from_address     : v4,
                to_address       : v4,
                from_multisig_id : v0,
                to_multisig_id   : 0x2::object::id<MultisigAccount>(arg1),
                locked_before    : 0,
                approvers        : 0x1::vector::empty<Signature>(),
                rejectors        : 0x1::vector::empty<Signature>(),
                creator          : v4,
                create_time      : 0x2::clock::timestamp_ms(arg3),
                approver         : v4,
                approve_time     : 0x2::clock::timestamp_ms(arg3),
                rejector         : v4,
                reject_time      : 0,
                executor         : v4,
                execute_time     : 0x2::clock::timestamp_ms(arg3),
                transaction_name : 0x1::string::utf8(arg2),
                token_name       : v2.token_name,
                multisig_id      : 0x2::object::id<MultisigAccount>(arg1),
            };
            0x2::object_table::add<0x1::string::String, Transaction>(&mut arg1.txs, 0x1::string::utf8(arg2), v6);
            let v7 = DepositEvent{
                account_id     : 0x2::object::id<MultisigAccount>(arg1),
                transaction_id : 0x2::object::uid_to_inner(&v5),
            };
            0x2::event::emit<DepositEvent>(v7);
        };
        let v8 = ExecuteTransactionEvent{
            account_id     : v0,
            transaction_id : 0x2::object::uid_to_inner(&v2.id),
        };
        0x2::event::emit<ExecuteTransactionEvent>(v8);
    }

    fun is_approver(arg0: vector<Signature>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Signature>(&arg0)) {
            if (borrow_signer(0x1::vector::borrow<Signature>(&arg0, v0)) == &arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_rejector(arg0: vector<Signature>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Signature>(&arg0)) {
            if (borrow_signer(0x1::vector::borrow<Signature>(&arg0, v0)) == &arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun transaction_balance(arg0: &Transaction) : u64 {
        arg0.balance
    }

    public fun transaction_creator(arg0: &Transaction) : address {
        arg0.creator
    }

    public fun transaction_status(arg0: &Transaction) : u8 {
        arg0.status
    }

    fun transfer_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    fun transfer_approve_cap(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ApproveCap{
            id                  : 0x2::object::new(arg2),
            multisig_account_id : arg0,
        };
        0x2::transfer::transfer<ApproveCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

