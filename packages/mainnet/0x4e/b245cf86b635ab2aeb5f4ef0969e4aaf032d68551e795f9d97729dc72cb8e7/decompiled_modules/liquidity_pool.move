module 0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::liquidity_pool {
    struct Bank<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        sweep_accounts: 0x2::object_table::ObjectTable<address, SweepAccount>,
        swap_requests: 0x2::object_table::ObjectTable<address, SwapRequest>,
        jupnet_withdraw_requests: 0x2::table::Table<address, bool>,
        jupnet_swap_requests: 0x2::table::Table<address, bool>,
        invalidated_jupnet_requests: 0x2::table::Table<address, bool>,
        transaction_digest: vector<u8>,
        roots: vector<MerkleRootState>,
        active_swap_cap_ids: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bank_id: 0x2::object::ID,
    }

    struct SwapCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bank_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BankBalance<phantom T0> has store {
        amount: 0x2::balance::Balance<T0>,
    }

    struct SweepAccount has store, key {
        id: 0x2::object::UID,
        user: address,
    }

    struct SwapRequest has store, key {
        id: 0x2::object::UID,
        user: address,
        valid_till: u64,
        coin_type_in: 0x1::type_name::TypeName,
        coin_type_out: 0x1::type_name::TypeName,
        expected_input_amount: u64,
        minimum_output_amount: u64,
    }

    struct MerkleRootState has drop, store {
        epoch: u64,
        root: vector<u8>,
    }

    struct SwapHotPotato {
        swap_request: SwapRequest,
        jupnet_swap_request: address,
    }

    struct SweepCoinEvent has copy, drop {
        user: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawCoinEvent has copy, drop {
        user_withdrawal_address: address,
        jupnet_withdrawal_request: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        jupnet_swap_request: address,
        input_coin_type: 0x1::type_name::TypeName,
        output_coin_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
    }

    struct RequestInvalidatedEvent has copy, drop {
        jupnet_request: address,
    }

    struct InjectBalanceEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LIQUIDITY_POOL has drop {
        dummy_field: bool,
    }

    public fun complete_fulfill_swap_request<T0, T1, T2>(arg0: &SwapCap<T0>, arg1: address, arg2: SwapHotPotato, arg3: &mut Bank<T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: vector<vector<u8>>, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: u16, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg3.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(arg0)), 13);
        assert!(arg3.transaction_digest != *0x2::tx_context::digest(arg12), 5);
        arg3.transaction_digest = *0x2::tx_context::digest(arg12);
        let SwapHotPotato {
            swap_request        : v0,
            jupnet_swap_request : v1,
        } = arg2;
        let v2 = v0;
        assert!(arg1 == v1, 11);
        assert!(0x1::type_name::with_defining_ids<T1>() == v2.coin_type_in, 10);
        assert!(0x1::type_name::with_defining_ids<T2>() == v2.coin_type_out, 10);
        assert!(v2.valid_till > 0x2::clock::timestamp_ms(arg4), 2);
        let v3 = 0x2::coin::value<T2>(&arg5);
        assert!(v3 >= v2.minimum_output_amount, 3);
        let v4 = BalanceKey<T2>{dummy_field: false};
        0x2::balance::join<T2>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T2>, BankBalance<T2>>(&mut arg3.id, v4).amount, 0x2::coin::into_balance<T2>(arg5));
        let v5 = &arg3.roots;
        assert!(0x1::vector::borrow<MerkleRootState>(v5, 0).epoch == arg8, 6);
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::verify_merkle_aggregation(arg6, arg9, arg7, 0x1::vector::borrow<MerkleRootState>(v5, 0).root), 7);
        let v6 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC");
        if (!v6) {
            assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 12);
        };
        let v7 = if (v6) {
            0x1::type_name::with_defining_ids<T2>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::verify(arg10, arg9, 0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::hash_to_g1(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::create_swap_message_hash(v7, v2.expected_input_amount, v2.minimum_output_amount, v2.valid_till, 0x2::address::to_bytes(arg1), v6), (arg11 as u8))), 8);
        let v8 = SwapEvent{
            user                : v2.user,
            jupnet_swap_request : arg1,
            input_coin_type     : 0x1::type_name::with_defining_ids<T1>(),
            output_coin_type    : 0x1::type_name::with_defining_ids<T2>(),
            input_amount        : v2.expected_input_amount,
            output_amount       : v3,
        };
        0x2::event::emit<SwapEvent>(v8);
        let SwapRequest {
            id                    : v9,
            user                  : _,
            valid_till            : _,
            coin_type_in          : _,
            coin_type_out         : _,
            expected_input_amount : _,
            minimum_output_amount : _,
        } = v2;
        0x2::object::delete(v9);
    }

    public fun create_swap_cap<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) : SwapCap<T0> {
        let v0 = 0x2::object::new(arg2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.active_swap_cap_ids, 0x2::object::uid_to_inner(&v0), true);
        SwapCap<T0>{
            id      : v0,
            bank_id : 0x2::object::id<Bank<T0>>(arg1),
        }
    }

    public fun create_swap_request<T0, T1, T2>(arg0: &SwapCap<T0>, arg1: address, arg2: &mut Bank<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg2.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(arg0)), 13);
        let v0 = SwapRequest{
            id                    : 0x2::object::new(arg7),
            user                  : arg3,
            valid_till            : arg4,
            coin_type_in          : 0x1::type_name::with_defining_ids<T1>(),
            coin_type_out         : 0x1::type_name::with_defining_ids<T2>(),
            expected_input_amount : arg5,
            minimum_output_amount : arg6,
        };
        0x2::object_table::add<address, SwapRequest>(&mut arg2.swap_requests, arg1, v0);
        0x2::table::add<address, bool>(&mut arg2.jupnet_swap_requests, arg1, true);
    }

    public fun create_sweep_account_for_user<T0>(arg0: address, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = SweepAccount{
            id   : 0x2::object::new(arg2),
            user : arg0,
        };
        0x2::object_table::add<address, SweepAccount>(&mut arg1.sweep_accounts, arg0, v0);
    }

    fun init(arg0: LIQUIDITY_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUIDITY_POOL>(arg0, arg1);
        let (v0, v1, v2) = init_bank<LIQUIDITY_POOL>(arg1);
        0x2::transfer::share_object<Bank<LIQUIDITY_POOL>>(v0);
        0x2::transfer::transfer<AdminCap<LIQUIDITY_POOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<SwapCap<LIQUIDITY_POOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun init_balance_for_coin<T0, T1>(arg0: &mut Bank<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = BalanceKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceKey<T1>>(&arg0.id, v0)) {
            let v1 = BalanceKey<T1>{dummy_field: false};
            let v2 = BankBalance<T1>{amount: 0x2::balance::zero<T1>()};
            0x2::dynamic_field::add<BalanceKey<T1>, BankBalance<T1>>(&mut arg0.id, v1, v2);
        };
    }

    fun init_bank<T0>(arg0: &mut 0x2::tx_context::TxContext) : (Bank<T0>, AdminCap<T0>, SwapCap<T0>) {
        let v0 = Bank<T0>{
            id                          : 0x2::object::new(arg0),
            version                     : 1,
            sweep_accounts              : 0x2::object_table::new<address, SweepAccount>(arg0),
            swap_requests               : 0x2::object_table::new<address, SwapRequest>(arg0),
            jupnet_withdraw_requests    : 0x2::table::new<address, bool>(arg0),
            jupnet_swap_requests        : 0x2::table::new<address, bool>(arg0),
            invalidated_jupnet_requests : 0x2::table::new<address, bool>(arg0),
            transaction_digest          : *0x2::tx_context::digest(arg0),
            roots                       : 0x1::vector::empty<MerkleRootState>(),
            active_swap_cap_ids         : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        let v1 = AdminCap<T0>{
            id      : 0x2::object::new(arg0),
            bank_id : 0x2::object::id<Bank<T0>>(&v0),
        };
        let v2 = SwapCap<T0>{
            id      : 0x2::object::new(arg0),
            bank_id : 0x2::object::id<Bank<T0>>(&v0),
        };
        0x2::table::add<0x2::object::ID, bool>(&mut v0.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(&v2), true);
        (v0, v1, v2)
    }

    public fun init_fulfill_swap_request<T0, T1>(arg0: &SwapCap<T0>, arg1: address, arg2: &mut Bank<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapHotPotato) {
        assert!(arg2.version == 1, 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg2.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(arg0)), 13);
        assert!(!0x2::table::contains<address, bool>(&arg2.invalidated_jupnet_requests, arg1), 8);
        let v0 = 0x2::object_table::remove<address, SwapRequest>(&mut arg2.swap_requests, arg1);
        assert!(0x1::type_name::with_defining_ids<T1>() == v0.coin_type_in, 10);
        let v1 = BalanceKey<T1>{dummy_field: false};
        let v2 = SwapHotPotato{
            swap_request        : v0,
            jupnet_swap_request : arg1,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg2.id, v1).amount, v0.expected_input_amount), arg3), v2)
    }

    public fun inject_balance<T0>(arg0: &AdminCap<LIQUIDITY_POOL>, arg1: &mut Bank<LIQUIDITY_POOL>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg1.id, v0)) {
            let v1 = BalanceKey<T0>{dummy_field: false};
            let v2 = BankBalance<T0>{amount: 0x2::balance::zero<T0>()};
            0x2::dynamic_field::add<BalanceKey<T0>, BankBalance<T0>>(&mut arg1.id, v1, v2);
        };
        let v3 = BalanceKey<T0>{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T0>, BankBalance<T0>>(&mut arg1.id, v3).amount, 0x2::coin::into_balance<T0>(arg2));
        let v4 = InjectBalanceEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<InjectBalanceEvent>(v4);
    }

    public fun invalidate_jupnet_request<T0>(arg0: &mut Bank<T0>, arg1: u64, arg2: address, arg3: u64, arg4: vector<vector<u8>>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u16, arg9: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.jupnet_swap_requests, arg2), 8);
        assert!(!0x2::table::contains<address, bool>(&arg0.jupnet_withdraw_requests, arg2), 8);
        assert!(arg1 < 0x2::clock::timestamp_ms(arg9), 2);
        let v0 = &arg0.roots;
        assert!(0x1::vector::borrow<MerkleRootState>(v0, 0).epoch == arg5, 6);
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::verify_merkle_aggregation(arg3, arg6, arg4, 0x1::vector::borrow<MerkleRootState>(v0, 0).root), 7);
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::verify(arg7, arg6, 0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::hash_to_g1(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::create_invalidation_message_hash(arg1, arg2), (arg8 as u8))), 8);
        0x2::table::add<address, bool>(&mut arg0.invalidated_jupnet_requests, arg2, true);
        let v1 = RequestInvalidatedEvent{jupnet_request: arg2};
        0x2::event::emit<RequestInvalidatedEvent>(v1);
    }

    public fun migrate_version<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.version = 1;
    }

    public fun revoke_swap_cap<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: 0x2::object::ID) {
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.active_swap_cap_ids, arg2);
    }

    public fun set_merkle_root_state<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 14);
        let v0 = MerkleRootState{
            epoch : arg2,
            root  : arg3,
        };
        arg1.roots = 0x1::vector::singleton<MerkleRootState>(v0);
    }

    public fun sweep_coin<T0, T1>(arg0: &mut Bank<T0>, arg1: address, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut 0x2::object_table::borrow_mut<address, SweepAccount>(&mut arg0.sweep_accounts, arg1).id, arg2);
        let v1 = BalanceKey<T1>{dummy_field: false};
        let v2 = SweepCoinEvent{
            user      : arg1,
            coin_type : 0x1::type_name::with_defining_ids<T1>(),
            amount    : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<SweepCoinEvent>(v2);
        0x2::balance::join<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg0.id, v1).amount, 0x2::coin::into_balance<T1>(v0));
    }

    public fun update_merkle_root_state<T0>(arg0: &mut Bank<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: vector<u8>, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 14);
        let v0 = &mut arg0.roots;
        assert!(0x1::vector::length<MerkleRootState>(v0) > 0, 9);
        let v1 = 0x1::vector::borrow<MerkleRootState>(v0, 0).epoch;
        if (arg1 == v1) {
            return
        };
        assert!(arg1 > v1, 6);
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::verify_merkle_aggregation(arg3, arg5, arg4, 0x1::vector::borrow<MerkleRootState>(v0, 0).root), 7);
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::verify(arg6, arg5, 0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::hash_to_g1(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::create_merkle_root_message_hash(arg2, arg1), (arg7 as u8))), 8);
        let v2 = MerkleRootState{
            epoch : arg1,
            root  : arg2,
        };
        *v0 = 0x1::vector::singleton<MerkleRootState>(v2);
    }

    public fun withdraw_tokens<T0, T1>(arg0: address, arg1: &mut Bank<T0>, arg2: &0x2::clock::Clock, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: vector<vector<u8>>, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: u16, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(arg1.transaction_digest != *0x2::tx_context::digest(arg12), 5);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg2), 2);
        arg1.transaction_digest = *0x2::tx_context::digest(arg12);
        assert!(!0x2::table::contains<address, bool>(&arg1.invalidated_jupnet_requests, arg0), 8);
        let v0 = BalanceKey<T1>{dummy_field: false};
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg1.id, v0).amount, arg4), arg12);
        0x2::table::add<address, bool>(&mut arg1.jupnet_withdraw_requests, arg0, true);
        let v2 = &arg1.roots;
        assert!(0x1::vector::borrow<MerkleRootState>(v2, 0).epoch == arg8, 6);
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::verify_merkle_aggregation(arg6, arg9, arg7, 0x1::vector::borrow<MerkleRootState>(v2, 0).root), 7);
        assert!(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::verify(arg10, arg9, 0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::alt_bn128_bls::hash_to_g1(0x4eb245cf86b635ab2aeb5f4ef0969e4aaf032d68551e795f9d97729dc72cb8e7::verification::create_withdrawal_message_hash(0x1::type_name::with_defining_ids<T1>(), arg4, arg5, arg3, arg0), (arg11 as u8))), 8);
        let v3 = WithdrawCoinEvent{
            user_withdrawal_address   : arg3,
            jupnet_withdrawal_request : arg0,
            coin_type                 : 0x1::type_name::with_defining_ids<T1>(),
            amount                    : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<WithdrawCoinEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg3);
    }

    // decompiled from Move bytecode v6
}

