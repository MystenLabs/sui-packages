module 0xcfbae556060abedf0e68c36e25bdc2fc7057dc4f1cf71ec4cab770f80f6c1d46::yes_chad_bridge {
    struct ChainData has copy, drop, store {
        enabled: bool,
        exchange_rate: u64,
    }

    struct Transaction has copy, drop, store {
        amount: u64,
        timestamp: u64,
        from_user: vector<u8>,
        to_user: vector<u8>,
        from_chain: vector<u8>,
        to_chain: vector<u8>,
        nonce: u64,
        block: u64,
    }

    struct SendEvent has copy, drop {
        from_user: vector<u8>,
        to_user: vector<u8>,
        from_chain: vector<u8>,
        to_chain: vector<u8>,
        amount: u64,
        exchange_rate: u64,
    }

    struct FulfillEvent has copy, drop {
        from_user: vector<u8>,
        to_user: address,
        from_chain: vector<u8>,
        amount: u64,
        exchange_rate: u64,
    }

    struct DepositEvent has copy, drop {
        depositor: address,
        amount: u64,
        new_balance: u64,
    }

    struct Bridge<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        owner_pubkey: vector<u8>,
        paused: bool,
        fee_wallet: address,
        fee_send: u64,
        fee_fulfill: u64,
        limit_per_send: u64,
        chain_data: 0x2::table::Table<vector<u8>, ChainData>,
        supported_chains: vector<vector<u8>>,
        nonce: u64,
        fulfilled_nonces: 0x2::table::Table<vector<u8>, bool>,
        transactions: 0x2::table::Table<vector<u8>, vector<Transaction>>,
        current_chain: vector<u8>,
        coin_balance: 0x2::balance::Balance<T0>,
    }

    fun assert_chain_is_enabled(arg0: &ChainData) {
        assert!(arg0.enabled, 303);
    }

    fun assert_non_empty_chain(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 300);
    }

    fun assert_not_paused<T0>(arg0: &Bridge<T0>) {
        assert!(!arg0.paused, 600);
    }

    fun assert_owner<T0>(arg0: &Bridge<T0>, arg1: address) {
        assert!(arg1 == arg0.owner, 100);
    }

    fun assert_positive_rate(arg0: u64) {
        assert!(arg0 > 0, 301);
    }

    fun assert_rates(arg0: u64, arg1: u64) {
        assert!(arg0 < 10000, 200);
        assert!(arg1 < 10000, 201);
    }

    fun assert_supported_chain<T0>(arg0: &Bridge<T0>, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, ChainData>(&arg0.chain_data, arg1), 302);
    }

    fun assert_valid_send<T0>(arg0: &Bridge<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 400);
        assert_supported_chain<T0>(arg0, arg2);
        let v0 = 0x2::table::borrow<vector<u8>, ChainData>(&arg0.chain_data, arg2);
        assert_chain_is_enabled(v0);
        assert!(arg3 > 0 && arg3 <= arg0.limit_per_send, 401);
        let v1 = v0.exchange_rate;
        assert!(arg3 % v1 == 0, 402);
        assert!(arg3 / v1 >= 10000, 403);
    }

    public fun deposit<T0>(arg0: &mut Bridge<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v0) >= arg2, 406);
        assert!(arg2 > 0, 405);
        0x2::balance::join<T0>(&mut arg0.coin_balance, 0x2::balance::split<T0>(&mut v0, arg2));
        let v1 = DepositEvent{
            depositor   : 0x2::tx_context::sender(arg3),
            amount      : arg2,
            new_balance : 0x2::balance::value<T0>(&arg0.coin_balance),
        };
        0x2::event::emit<DepositEvent>(v1);
        return_back_or_delete<T0>(v0, arg3);
    }

    public fun fulfill<T0>(arg0: &mut Bridge<T0>, arg1: u64, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 404);
        assert_not_paused<T0>(arg0);
        assert_supported_chain<T0>(arg0, arg4);
        assert_chain_is_enabled(0x2::table::borrow<vector<u8>, ChainData>(&arg0.chain_data, arg4));
        let v0 = make_nonce_key(&arg4, &arg2, arg5);
        assert!(0x1::vector::length<u8>(&arg6) == 64, 500);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.fulfilled_nonces, v0), 501);
        0x2::table::add<vector<u8>, bool>(&mut arg0.fulfilled_nonces, v0, true);
        let v1 = make_fulfill_message(arg1, arg2, arg3, arg4, arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &arg0.owner_pubkey, &v1, 1), 502);
        let v2 = 0x2::table::borrow<vector<u8>, ChainData>(&arg0.chain_data, arg4);
        let v3 = arg1 * v2.exchange_rate;
        let v4 = v3 * arg0.fee_fulfill / 10000;
        let v5 = v3 - v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, v5, arg7), arg3);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, v4, arg7), arg0.fee_wallet);
        };
        let v6 = FulfillEvent{
            from_user     : arg2,
            to_user       : arg3,
            from_chain    : arg4,
            amount        : v5,
            exchange_rate : v2.exchange_rate,
        };
        0x2::event::emit<FulfillEvent>(v6);
    }

    public fun initialize<T0>(arg0: address, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_rates(arg3, arg4);
        assert_non_empty_chain(&arg6);
        let v0 = Bridge<T0>{
            id               : 0x2::object::new(arg7),
            owner            : arg0,
            owner_pubkey     : arg1,
            paused           : false,
            fee_wallet       : arg2,
            fee_send         : arg3,
            fee_fulfill      : arg4,
            limit_per_send   : arg5,
            chain_data       : 0x2::table::new<vector<u8>, ChainData>(arg7),
            supported_chains : 0x1::vector::empty<vector<u8>>(),
            nonce            : 0,
            fulfilled_nonces : 0x2::table::new<vector<u8>, bool>(arg7),
            transactions     : 0x2::table::new<vector<u8>, vector<Transaction>>(arg7),
            current_chain    : arg6,
            coin_balance     : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Bridge<T0>>(v0);
    }

    fun make_fulfill_message(arg0: u64, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        v0
    }

    fun make_nonce_key(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun pause<T0>(arg0: &mut Bridge<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = true;
    }

    fun return_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun send<T0>(arg0: &mut Bridge<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        assert_valid_send<T0>(arg0, arg3, arg4, arg2);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v0) >= arg2, 406);
        let (v1, v2) = send_internal<T0>(arg0, 0x2::balance::split<T0>(&mut v0, arg2), arg3, arg4, arg5);
        let v3 = v1;
        let v4 = SendEvent{
            from_user     : v3.from_user,
            to_user       : v3.to_user,
            from_chain    : v3.from_chain,
            to_chain      : v3.to_chain,
            amount        : v3.amount,
            exchange_rate : v2,
        };
        0x2::event::emit<SendEvent>(v4);
        return_back_or_delete<T0>(v0, arg5);
    }

    fun send_internal<T0>(arg0: &mut Bridge<T0>, arg1: 0x2::balance::Balance<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : (Transaction, u64) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.coin_balance, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::table::borrow<vector<u8>, ChainData>(&arg0.chain_data, arg3).exchange_rate;
        let v3 = v0 * arg0.fee_send / 10000 / v2;
        let v4 = v3 * v2;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_balance, v4, arg4), arg0.fee_wallet);
        };
        let v5 = 0x2::bcs::to_bytes<address>(&v1);
        arg0.nonce = arg0.nonce + 1;
        let v6 = Transaction{
            amount     : v0 / v2 - v3,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg4),
            from_user  : v5,
            to_user    : arg2,
            from_chain : arg0.current_chain,
            to_chain   : arg3,
            nonce      : arg0.nonce,
            block      : 0x2::tx_context::epoch(arg4),
        };
        if (!0x2::table::contains<vector<u8>, vector<Transaction>>(&arg0.transactions, v5)) {
            0x2::table::add<vector<u8>, vector<Transaction>>(&mut arg0.transactions, v5, 0x1::vector::empty<Transaction>());
        };
        0x1::vector::push_back<Transaction>(0x2::table::borrow_mut<vector<u8>, vector<Transaction>>(&mut arg0.transactions, v5), v6);
        (v6, v2)
    }

    public fun set_chain_data<T0>(arg0: &mut Bridge<T0>, arg1: vector<u8>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg4));
        assert_positive_rate(arg3);
        update_chain_data<T0>(arg0, arg1, arg2, arg3);
        if (arg2) {
            let v0 = false;
            let v1 = &mut arg0.supported_chains;
            let v2 = 0;
            while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
                if (*0x1::vector::borrow<vector<u8>>(v1, v2) == arg1) {
                    v0 = true;
                    break
                };
                v2 = v2 + 1;
            };
            if (!v0) {
                0x1::vector::push_back<vector<u8>>(v1, arg1);
            };
        };
    }

    public fun set_params<T0>(arg0: &mut Bridge<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg6));
        assert_rates(arg1, arg2);
        arg0.fee_send = arg1;
        arg0.fee_fulfill = arg2;
        arg0.limit_per_send = arg3;
        arg0.paused = arg4;
        arg0.fee_wallet = arg5;
    }

    public fun transfer_ownership<T0>(arg0: &mut Bridge<T0>, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg0.owner != arg1, 101);
        assert!(arg0.owner_pubkey != arg2, 102);
        arg0.owner = arg1;
        arg0.owner_pubkey = arg2;
    }

    public fun unpause<T0>(arg0: &mut Bridge<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = false;
    }

    fun update_chain_data<T0>(arg0: &mut Bridge<T0>, arg1: vector<u8>, arg2: bool, arg3: u64) {
        if (0x2::table::contains<vector<u8>, ChainData>(&arg0.chain_data, arg1)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, ChainData>(&mut arg0.chain_data, arg1);
            v0.enabled = arg2;
            v0.exchange_rate = arg3;
        } else {
            let v1 = ChainData{
                enabled       : arg2,
                exchange_rate : arg3,
            };
            0x2::table::add<vector<u8>, ChainData>(&mut arg0.chain_data, arg1, v1);
        };
    }

    public fun withdraw<T0>(arg0: &mut Bridge<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x2::balance::value<T0>(&arg0.coin_balance);
        assert!(v0 > 0, 601);
        0x2::pay::keep<T0>(0x2::coin::take<T0>(&mut arg0.coin_balance, v0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

