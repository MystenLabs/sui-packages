module 0x4479fe1d936051823526e9a0c890c3d582001d28c6d57ce26d7bb9159a8c5638::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        solver_pubkey: vector<u8>,
        domain: vector<u8>,
        paused: bool,
        balances: 0x2::bag::Bag,
        quote_used: 0x2::table::Table<vector<u8>, bool>,
        marked_for_refund: 0x2::table::Table<vector<u8>, bool>,
    }

    struct Deposited has copy, drop {
        quote_id: vector<u8>,
        token_type: 0x1::ascii::String,
        amount: u64,
        sender: address,
    }

    struct Fulfilled has copy, drop {
        quote_id: vector<u8>,
        token_type: 0x1::ascii::String,
        amount: u64,
        receiver: address,
    }

    struct MarkedForRefund has copy, drop {
        quote_id: vector<u8>,
    }

    struct Refunded has copy, drop {
        quote_id: vector<u8>,
        token_type: 0x1::ascii::String,
        amount: u64,
        receiver: address,
    }

    struct SettlementMessage has drop {
        domain: vector<u8>,
        vault: address,
        action: u64,
        quote_id: vector<u8>,
        nonce: u64,
        token_type: vector<u8>,
        amount: u64,
        receiver: address,
    }

    struct MarkForRefundMessage has drop {
        domain: vector<u8>,
        vault: address,
        action: u64,
        quote_id: vector<u8>,
        nonce: u64,
    }

    fun assert_not_paused(arg0: &Vault) {
        assert!(!arg0.paused, 3);
    }

    fun assert_owner(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
    }

    fun assert_valid_quote_id(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
    }

    fun assert_valid_solver_pubkey(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 33, 5);
    }

    fun balance_mut_or_create<T0>(arg0: &mut Vault) : &mut 0x2::balance::Balance<T0> {
        let v0 = token_key<T0>();
        if (!0x2::bag::contains_with_type<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
    }

    public entry fun create_vault(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 7);
        assert_valid_solver_pubkey(&arg1);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 6);
        let v0 = Vault{
            id                : 0x2::object::new(arg3),
            owner             : arg0,
            solver_pubkey     : arg1,
            domain            : arg2,
            paused            : false,
            balances          : 0x2::bag::new(arg3),
            quote_used        : 0x2::table::new<vector<u8>, bool>(arg3),
            marked_for_refund : 0x2::table::new<vector<u8>, bool>(arg3),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert_valid_quote_id(&arg1);
        0x2::coin::put<T0>(balance_mut_or_create<T0>(arg0), arg2);
        let v0 = Deposited{
            quote_id   : arg1,
            token_type : token_type<T0>(),
            amount     : 0x2::coin::value<T0>(&arg2),
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun domain(arg0: &Vault) : vector<u8> {
        arg0.domain
    }

    fun existing_balance_mut<T0>(arg0: &mut Vault) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.balances, token_key<T0>())
    }

    public entry fun fulfil<T0>(arg0: &mut Vault, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = fulfil_message<T0>(arg0, arg1, arg2, arg3, arg4);
        verify_signature(arg0, &v0, &arg5);
        mark_quote_id(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(existing_balance_mut<T0>(arg0), arg3, arg6), arg4);
        let v1 = Fulfilled{
            quote_id   : arg1,
            token_type : token_type<T0>(),
            amount     : arg3,
            receiver   : arg4,
        };
        0x2::event::emit<Fulfilled>(v1);
    }

    public fun fulfil_message<T0>(arg0: &Vault, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: address) : vector<u8> {
        assert_valid_quote_id(&arg1);
        settlement_message<T0>(arg0, 1, arg1, arg2, arg3, arg4)
    }

    public entry fun fund<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        0x2::coin::put<T0>(balance_mut_or_create<T0>(arg0), arg1);
    }

    public fun is_marked_for_refund(arg0: &Vault, arg1: vector<u8>) : bool {
        assert_valid_quote_id(&arg1);
        0x2::table::contains<vector<u8>, bool>(&arg0.marked_for_refund, arg1)
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun is_quote_used(arg0: &Vault, arg1: vector<u8>) : bool {
        assert_valid_quote_id(&arg1);
        0x2::table::contains<vector<u8>, bool>(&arg0.quote_used, arg1)
    }

    public entry fun mark_for_refund(arg0: &mut Vault, arg1: vector<u8>, arg2: u64, arg3: vector<u8>) {
        assert_not_paused(arg0);
        let v0 = mark_for_refund_message(arg0, arg1, arg2);
        verify_signature(arg0, &v0, &arg3);
        mark_quote_id(arg0, arg1);
        0x2::table::add<vector<u8>, bool>(&mut arg0.marked_for_refund, arg1, true);
        let v1 = MarkedForRefund{quote_id: arg1};
        0x2::event::emit<MarkedForRefund>(v1);
    }

    public fun mark_for_refund_message(arg0: &Vault, arg1: vector<u8>, arg2: u64) : vector<u8> {
        assert_valid_quote_id(&arg1);
        let v0 = MarkForRefundMessage{
            domain   : arg0.domain,
            vault    : 0x2::object::uid_to_address(&arg0.id),
            action   : 4,
            quote_id : arg1,
            nonce    : arg2,
        };
        0x1::bcs::to_bytes<MarkForRefundMessage>(&v0)
    }

    fun mark_quote_id(arg0: &mut Vault, arg1: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.quote_used, arg1), 1);
        0x2::table::add<vector<u8>, bool>(&mut arg0.quote_used, arg1, true);
    }

    public fun owner(arg0: &Vault) : address {
        arg0.owner
    }

    public entry fun pause(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.paused = true;
    }

    public entry fun refund<T0>(arg0: &mut Vault, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = refund_message<T0>(arg0, arg1, arg2, arg3, arg4);
        verify_signature(arg0, &v0, &arg5);
        mark_quote_id(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(existing_balance_mut<T0>(arg0), arg3, arg6), arg4);
        let v1 = Refunded{
            quote_id   : arg1,
            token_type : token_type<T0>(),
            amount     : arg3,
            receiver   : arg4,
        };
        0x2::event::emit<Refunded>(v1);
    }

    public fun refund_message<T0>(arg0: &Vault, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: address) : vector<u8> {
        assert_valid_quote_id(&arg1);
        settlement_message<T0>(arg0, 2, arg1, arg2, arg3, arg4)
    }

    public entry fun rescue<T0>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(existing_balance_mut<T0>(arg0), arg1, arg3), arg2);
    }

    public entry fun set_solver_pubkey(arg0: &mut Vault, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_valid_solver_pubkey(&arg1);
        arg0.solver_pubkey = arg1;
    }

    fun settlement_message<T0>(arg0: &Vault, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: address) : vector<u8> {
        let v0 = SettlementMessage{
            domain     : arg0.domain,
            vault      : 0x2::object::uid_to_address(&arg0.id),
            action     : arg1,
            quote_id   : arg2,
            nonce      : arg3,
            token_type : token_key<T0>(),
            amount     : arg4,
            receiver   : arg5,
        };
        0x1::bcs::to_bytes<SettlementMessage>(&v0)
    }

    public fun signature_hash_algorithm() : u8 {
        1
    }

    public fun solver_pubkey(arg0: &Vault) : vector<u8> {
        arg0.solver_pubkey
    }

    fun token_key<T0>() : vector<u8> {
        0x1::ascii::into_bytes(token_type<T0>())
    }

    fun token_type<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public entry fun transfer_ownership(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 7);
        arg0.owner = arg1;
    }

    public entry fun unpause(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.paused = false;
    }

    public fun vault_balance<T0>(arg0: &Vault) : u64 {
        let v0 = token_key<T0>();
        if (0x2::bag::contains_with_type<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    fun verify_signature(arg0: &Vault, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg2) == 64, 2);
        assert!(0x2::ecdsa_k1::secp256k1_verify(arg2, &arg0.solver_pubkey, arg1, 1), 2);
    }

    // decompiled from Move bytecode v7
}

