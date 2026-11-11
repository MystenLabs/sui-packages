module 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::gum_intent {
    struct GUM_INTENT has drop {
        dummy_field: bool,
    }

    struct InboxWitness has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GumBankKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Peer has copy, drop, store {
        inbox: vector<u8>,
        sender: vector<u8>,
        inbound: bool,
        outbound: bool,
    }

    struct PeerKey has copy, drop, store {
        chain_id: u64,
        addr: vector<u8>,
    }

    struct ConsumedKey has copy, drop, store {
        origin_chain_id: u64,
        origin_addr: vector<u8>,
        swap_intent_digest: vector<u8>,
    }

    struct State has key {
        id: 0x2::object::UID,
        initialized: bool,
        chain_id: u64,
        endpoint: vector<u8>,
        api_pubkey: vector<u8>,
        treasury: address,
        open_paused: bool,
        intent_nonce: u64,
        user_counters: 0x2::table::Table<address, u64>,
        peers: 0x2::table::Table<PeerKey, Peer>,
        solvers: 0x2::table::Table<address, bool>,
        consumed: 0x2::table::Table<ConsumedKey, bool>,
    }

    struct Escrow<phantom T0> has key {
        id: 0x2::object::UID,
        escrow_id: u64,
        user: address,
        dst_chain_id: u64,
        dst_endpoint: vector<u8>,
        intent_nonce: u64,
        expiry_time: u64,
        input_amount: u64,
        builder: address,
        builder_fee: u64,
        protocol_fee: u64,
        dst_token: vector<u8>,
        min_dst_amount: u256,
        dst_recipient: vector<u8>,
        exclusive_solver: vector<u8>,
        exclusive_until: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DepositEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        escrow_id: u64,
        user: address,
        dst_chain_id: u64,
        dst_endpoint: vector<u8>,
        intent_nonce: u64,
        expiry_time: u64,
        input_amount: u64,
        builder: address,
        builder_fee: u64,
        protocol_fee: u64,
        dst_token: vector<u8>,
        min_dst_amount: u256,
        dst_recipient: vector<u8>,
        exclusive_solver: vector<u8>,
        exclusive_until: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Terms has copy, drop {
        escrow_id: u64,
        user: address,
        dst_chain_id: u64,
        dst_endpoint: vector<u8>,
        intent_nonce: u64,
        expiry_time: u64,
        input_amount: u64,
        builder: address,
        builder_fee: u64,
        protocol_fee: u64,
        dst_token: vector<u8>,
        min_dst_amount: u256,
        dst_recipient: vector<u8>,
        exclusive_solver: vector<u8>,
        exclusive_until: u64,
        delivery: u8,
    }

    struct OpenArgs has copy, drop {
        dst_chain_id: u64,
        dst_endpoint: vector<u8>,
        dst_token: vector<u8>,
        min_gross: u64,
        max_gross: u64,
        rate_num: u128,
        rate_den: u128,
        slippage_bps: u16,
        dst_recipient: vector<u8>,
        validity_seconds: u64,
        builder: address,
        builder_fee_bps: u16,
        protocol_fee_bps: u16,
        exclusive_solver: vector<u8>,
        exclusive_seconds: u64,
    }

    struct Proof has copy, drop {
        epoch: u64,
        merkle_idx: u64,
        merkle_proof: vector<vector<u8>>,
        aggregate_pubkey: vector<u8>,
        signature: vector<u8>,
    }

    struct Opened has copy, drop {
        escrow: 0x2::object::ID,
        user: address,
        escrow_id: u64,
        intent_hash: vector<u8>,
        intent_nonce: u64,
        dst_chain_id: u64,
        expiry_time: u64,
        builder: address,
        builder_fee: u64,
        protocol_fee: u64,
        raw_message: vector<u8>,
    }

    struct FulfilledEvent has copy, drop {
        intent_hash: vector<u8>,
        swap_intent_digest: vector<u8>,
        origin_chain_id: u64,
        intent_nonce: u64,
        solver: address,
        claim_target: vector<u8>,
        fulfill_amount: u64,
        msg_id: u64,
    }

    struct SettledEvent has copy, drop {
        escrow: 0x2::object::ID,
        user: address,
        escrow_id: u64,
        intent_hash: vector<u8>,
        claim_target: address,
    }

    struct VoidedEvent has copy, drop {
        origin_chain_id: u64,
        intent_nonce: u64,
        escrow_user: vector<u8>,
        escrow_id: u64,
        msg_id: u64,
        swap_intent_digest: vector<u8>,
    }

    struct RefundedEvent has copy, drop {
        escrow: 0x2::object::ID,
        user: address,
        escrow_id: u64,
        intent_hash: vector<u8>,
    }

    fun accept_fill<T0>(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: &vector<u8>, arg5: &0x2::coin::Coin<T0>, arg6: &vector<u8>, arg7: u8, arg8: &0x2::tx_context::TxContext) : (0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::SwapIntent, vector<u8>) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<address, bool>(&arg0.solvers, v0), 109);
        assert!(0x1::vector::length<u8>(arg6) == 32, 118);
        let v1 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::decode_swap_intent(arg4);
        assert!(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_delivery(&v1) == arg7, 124);
        assert!(*0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_dst_token(&v1) == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::sui_token<T0>(), 114);
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v2 < 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_expiry_time(&v1), 110);
        assert!((0x2::coin::value<T0>(arg5) as u256) >= 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_min_dst_amount(&v1), 112);
        let v3 = 0x2::address::to_bytes(v0);
        assert!(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::may_fill(&v1, &v3, v2), 127);
        let v4 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::swap_intent_digest(arg4);
        let v5 = ConsumedKey{
            origin_chain_id    : arg2,
            origin_addr        : arg3,
            swap_intent_digest : v4,
        };
        assert!(!0x2::table::contains<ConsumedKey, bool>(&arg0.consumed, v5), 113);
        0x2::table::add<ConsumedKey, bool>(&mut arg0.consumed, v5, true);
        (v1, v4)
    }

    fun bump_user_counter(arg0: &mut State, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.user_counters, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.user_counters, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_counters, arg1);
        let v1 = *v0;
        *v0 = v1 + 1;
        v1
    }

    public fun chain_id(arg0: &State) : u64 {
        arg0.chain_id
    }

    fun check_header(arg0: &State, arg1: &vector<u8>) {
        let v0 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::decode_header(arg1);
        assert!(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::header_version(&v0) == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::message_version(), 129);
        assert!(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::is_deliverable_to(&v0, arg0.chain_id, &arg0.endpoint), 108);
    }

    fun check_swap_intent_header(arg0: &State, arg1: &vector<u8>) {
        check_header(arg0, arg1);
        assert!(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::payload_tag(arg1) == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::tag_swap_intent(), 108);
    }

    public fun configure(arg0: &AdminCap, arg1: &mut State, arg2: u64, arg3: vector<u8>, arg4: address) {
        assert!(!arg1.initialized, 101);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 118);
        arg1.chain_id = arg2;
        arg1.api_pubkey = arg3;
        arg1.treasury = arg4;
        arg1.initialized = true;
    }

    public fun deposit_escrow_balance<T0>(arg0: &DepositEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun deposit_escrow_id<T0>(arg0: &DepositEscrow<T0>) : u64 {
        arg0.escrow_id
    }

    public fun deposit_escrow_intent_hash<T0>(arg0: &State, arg1: &DepositEscrow<T0>) : vector<u8> {
        let v0 = deposit_terms<T0>(arg1);
        terms_intent_hash<T0>(arg0, &v0)
    }

    fun deposit_escrow_parts<T0>(arg0: DepositEscrow<T0>) : (Terms, 0x2::object::UID, 0x2::balance::Balance<T0>) {
        let DepositEscrow {
            id               : v0,
            escrow_id        : _,
            user             : _,
            dst_chain_id     : _,
            dst_endpoint     : _,
            intent_nonce     : _,
            expiry_time      : _,
            input_amount     : _,
            builder          : _,
            builder_fee      : _,
            protocol_fee     : _,
            dst_token        : _,
            min_dst_amount   : _,
            dst_recipient    : _,
            exclusive_solver : _,
            exclusive_until  : _,
            balance          : v16,
        } = arg0;
        (deposit_terms<T0>(&arg0), v0, v16)
    }

    public fun deposit_escrow_user<T0>(arg0: &DepositEscrow<T0>) : address {
        arg0.user
    }

    public fun deposit_swap_intent_message<T0>(arg0: &State, arg1: &DepositEscrow<T0>) : vector<u8> {
        let v0 = deposit_terms<T0>(arg1);
        terms_message<T0>(arg0, &v0)
    }

    fun deposit_terms<T0>(arg0: &DepositEscrow<T0>) : Terms {
        Terms{
            escrow_id        : arg0.escrow_id,
            user             : arg0.user,
            dst_chain_id     : arg0.dst_chain_id,
            dst_endpoint     : arg0.dst_endpoint,
            intent_nonce     : arg0.intent_nonce,
            expiry_time      : arg0.expiry_time,
            input_amount     : arg0.input_amount,
            builder          : arg0.builder,
            builder_fee      : arg0.builder_fee,
            protocol_fee     : arg0.protocol_fee,
            dst_token        : arg0.dst_token,
            min_dst_amount   : arg0.min_dst_amount,
            dst_recipient    : arg0.dst_recipient,
            exclusive_solver : arg0.exclusive_solver,
            exclusive_until  : arg0.exclusive_until,
            delivery         : 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_gum_deposit(),
        }
    }

    public fun endpoint(arg0: &State) : vector<u8> {
        arg0.endpoint
    }

    public fun escrow_balance<T0>(arg0: &Escrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun escrow_exclusive_solver<T0>(arg0: &Escrow<T0>) : vector<u8> {
        arg0.exclusive_solver
    }

    public fun escrow_exclusive_until<T0>(arg0: &Escrow<T0>) : u64 {
        arg0.exclusive_until
    }

    public fun escrow_expiry_time<T0>(arg0: &Escrow<T0>) : u64 {
        arg0.expiry_time
    }

    public fun escrow_id<T0>(arg0: &Escrow<T0>) : u64 {
        arg0.escrow_id
    }

    public fun escrow_input_amount<T0>(arg0: &Escrow<T0>) : u64 {
        arg0.input_amount
    }

    public fun escrow_intent_hash<T0>(arg0: &State, arg1: &Escrow<T0>) : vector<u8> {
        let v0 = terms<T0>(arg1);
        terms_intent_hash<T0>(arg0, &v0)
    }

    public fun escrow_intent_nonce<T0>(arg0: &Escrow<T0>) : u64 {
        arg0.intent_nonce
    }

    fun escrow_parts<T0>(arg0: Escrow<T0>) : (Terms, 0x2::object::UID, 0x2::balance::Balance<T0>) {
        let Escrow {
            id               : v0,
            escrow_id        : _,
            user             : _,
            dst_chain_id     : _,
            dst_endpoint     : _,
            intent_nonce     : _,
            expiry_time      : _,
            input_amount     : _,
            builder          : _,
            builder_fee      : _,
            protocol_fee     : _,
            dst_token        : _,
            min_dst_amount   : _,
            dst_recipient    : _,
            exclusive_solver : _,
            exclusive_until  : _,
            balance          : v16,
        } = arg0;
        (terms<T0>(&arg0), v0, v16)
    }

    public fun escrow_user<T0>(arg0: &Escrow<T0>) : address {
        arg0.user
    }

    public fun fulfill<T0>(arg0: &mut State, arg1: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.initialized, 100);
        inbound_peer(arg0, arg3, &arg4);
        check_swap_intent_header(arg0, &arg5);
        let (_, _) = fulfill_internal<T0>(arg0, arg1, arg2, arg3, arg4, &arg5, arg6, arg7, arg8);
    }

    public fun fulfill_deposit<T0>(arg0: &mut State, arg1: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg2: &mut 0x58978a0c0678f010ff0ced45da75bf76f2cc33b96508c9a616dc547651f78341::liquidity_pool::Bank, arg3: &0x2::clock::Clock, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) {
        assert!(arg0.initialized, 100);
        inbound_peer(arg0, arg4, &arg5);
        check_swap_intent_header(arg0, &arg6);
        let (_, _) = fulfill_deposit_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6, arg7, arg8, arg9);
    }

    fun fulfill_deposit_internal<T0>(arg0: &mut State, arg1: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg2: &mut 0x58978a0c0678f010ff0ced45da75bf76f2cc33b96508c9a616dc547651f78341::liquidity_pool::Bank, arg3: &0x2::clock::Clock, arg4: u64, arg5: vector<u8>, arg6: &vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) : (u64, vector<u8>) {
        let v0 = gum_bank(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && 0x1::option::destroy_some<0x2::object::ID>(v0) == 0x2::object::id<0x58978a0c0678f010ff0ced45da75bf76f2cc33b96508c9a616dc547651f78341::liquidity_pool::Bank>(arg2), 130);
        let (v1, v2) = accept_fill<T0>(arg0, arg3, arg4, arg5, arg6, &arg7, &arg8, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_gum_deposit(), arg9);
        let v3 = v1;
        0x58978a0c0678f010ff0ced45da75bf76f2cc33b96508c9a616dc547651f78341::liquidity_pool::deposit<T0>(arg2, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::raw_to_address(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_dst_recipient(&v3)), arg7, arg1, arg3);
        fulfilled(arg1, arg3, arg4, arg5, &v3, v2, 0x2::coin::value<T0>(&arg7), arg8, arg9)
    }

    fun fulfill_internal<T0>(arg0: &mut State, arg1: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: &vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) : (u64, vector<u8>) {
        let (v0, v1) = accept_fill<T0>(arg0, arg2, arg3, arg4, arg5, &arg6, &arg7, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_direct(), arg8);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::raw_to_address(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_dst_recipient(&v2)));
        fulfilled(arg1, arg2, arg3, arg4, &v2, v1, 0x2::coin::value<T0>(&arg6), arg7, arg8)
    }

    fun fulfilled(arg0: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: &0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::SwapIntent, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) : (u64, vector<u8>) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::new_fulfilled(*0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_intent_hash(arg4), arg7, 0x2::address::to_bytes(v0), (arg6 as u256), arg5);
        let v2 = InboxWitness{dummy_field: false};
        let (_, v4, v5) = 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::submit_inbox_message<InboxWitness>(arg0, v2, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::encode_fulfilled(arg2, &arg3, &v1), arg1);
        let v6 = FulfilledEvent{
            intent_hash        : *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_intent_hash(arg4),
            swap_intent_digest : arg5,
            origin_chain_id    : arg2,
            intent_nonce       : 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_intent_nonce(arg4),
            solver             : v0,
            claim_target       : arg7,
            fulfill_amount     : arg6,
            msg_id             : v4,
        };
        0x2::event::emit<FulfilledEvent>(v6);
        (v4, v5)
    }

    public fun gum_bank(arg0: &State) : 0x1::option::Option<0x2::object::ID> {
        let v0 = GumBankKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GumBankKey>(&arg0.id, v0)) {
            let v2 = GumBankKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<GumBankKey, 0x2::object::ID>(&arg0.id, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun inbound_peer(arg0: &State, arg1: u64, arg2: &vector<u8>) : Peer {
        let v0 = PeerKey{
            chain_id : arg1,
            addr     : *arg2,
        };
        assert!(0x2::table::contains<PeerKey, Peer>(&arg0.peers, v0), 103);
        let v1 = *0x2::table::borrow<PeerKey, Peer>(&arg0.peers, v0);
        assert!(v1.inbound, 115);
        v1
    }

    fun init(arg0: GUM_INTENT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GUM_INTENT>(arg0, arg1);
        let v0 = State{
            id            : 0x2::object::new(arg1),
            initialized   : false,
            chain_id      : 0,
            endpoint      : package_address_raw(),
            api_pubkey    : b"",
            treasury      : 0x2::tx_context::sender(arg1),
            open_paused   : false,
            intent_nonce  : 0,
            user_counters : 0x2::table::new<address, u64>(arg1),
            peers         : 0x2::table::new<PeerKey, Peer>(arg1),
            solvers       : 0x2::table::new<address, bool>(arg1),
            consumed      : 0x2::table::new<ConsumedKey, bool>(arg1),
        };
        0x2::transfer::share_object<State>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun intent_nonce(arg0: &State) : u64 {
        arg0.intent_nonce
    }

    public fun is_consumed(arg0: &State, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = ConsumedKey{
            origin_chain_id    : arg1,
            origin_addr        : arg2,
            swap_intent_digest : arg3,
        };
        0x2::table::contains<ConsumedKey, bool>(&arg0.consumed, v0)
    }

    public fun is_solver(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.solvers, arg1)
    }

    public fun new_open_args(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u16, arg8: vector<u8>, arg9: u64, arg10: address, arg11: u16, arg12: u16, arg13: vector<u8>, arg14: u64) : OpenArgs {
        OpenArgs{
            dst_chain_id      : arg0,
            dst_endpoint      : arg1,
            dst_token         : arg2,
            min_gross         : arg3,
            max_gross         : arg4,
            rate_num          : arg5,
            rate_den          : arg6,
            slippage_bps      : arg7,
            dst_recipient     : arg8,
            validity_seconds  : arg9,
            builder           : arg10,
            builder_fee_bps   : arg11,
            protocol_fee_bps  : arg12,
            exclusive_solver  : arg13,
            exclusive_seconds : arg14,
        }
    }

    public fun new_proof(arg0: u64, arg1: u64, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<u8>) : Proof {
        Proof{
            epoch            : arg0,
            merkle_idx       : arg1,
            merkle_proof     : arg2,
            aggregate_pubkey : arg3,
            signature        : arg4,
        }
    }

    public fun open_digest<T0>(arg0: &State, arg1: address, arg2: u64, arg3: &OpenArgs) : vector<u8> {
        0x1::hash::sha2_256(open_preimage<T0>(b"gum:intent:open:v3", arg0, arg1, arg2, arg3))
    }

    public fun open_digest_by<T0>(arg0: &State, arg1: address, arg2: u64, arg3: &OpenArgs, arg4: u64) : vector<u8> {
        let v0 = open_preimage<T0>(b"gum:intent:open:v6", arg0, arg1, arg2, arg3);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg3.exclusive_solver);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut v0, arg3.exclusive_seconds);
        0x1::hash::sha2_256(v0)
    }

    public fun open_digest_by_delivery<T0>(arg0: &State, arg1: address, arg2: u64, arg3: &OpenArgs, arg4: u64, arg5: u8) : vector<u8> {
        let v0 = open_preimage<T0>(b"gum:intent:open:v7", arg0, arg1, arg2, arg3);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg3.exclusive_solver);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut v0, arg3.exclusive_seconds);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u8(&mut v0, arg5);
        0x1::hash::sha2_256(v0)
    }

    public fun open_intent<T0>(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: OpenArgs, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 126
    }

    public fun open_intent_by<T0>(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: OpenArgs, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.initialized, 100);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 <= arg4, 125);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = open_digest_by<T0>(arg0, v0, user_counter(arg0, v0), &arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.api_pubkey, &v1), 106);
        open_internal<T0>(arg0, arg1, arg2, arg3, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_direct(), arg6)
    }

    public fun open_intent_by_delivery<T0>(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: OpenArgs, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.initialized, 100);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 <= arg5, 125);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = open_digest_by_delivery<T0>(arg0, v0, user_counter(arg0, v0), &arg3, arg5, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.api_pubkey, &v1), 106);
        open_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg7)
    }

    fun open_internal<T0>(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: OpenArgs, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.initialized, 100);
        assert!(!arg0.open_paused, 102);
        let v0 = if (0x1::vector::length<u8>(&arg3.dst_recipient) == 32) {
            if (0x1::vector::length<u8>(&arg3.dst_endpoint) == 32) {
                0x1::vector::length<u8>(&arg3.exclusive_solver) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 118);
        assert!(arg4 == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_direct() || arg4 == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_gum_deposit(), 124);
        assert!(arg4 == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_direct() || !0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::is_zero(&arg3.dst_recipient), 131);
        let v1 = !0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::is_zero(&arg3.exclusive_solver);
        assert!(v1 && arg3.exclusive_seconds != 0 && arg3.exclusive_seconds < arg3.validity_seconds || arg3.exclusive_seconds == 0, 128);
        let v2 = PeerKey{
            chain_id : arg3.dst_chain_id,
            addr     : arg3.dst_endpoint,
        };
        assert!(0x2::table::contains<PeerKey, Peer>(&arg0.peers, v2), 103);
        assert!(0x2::table::borrow<PeerKey, Peer>(&arg0.peers, v2).outbound, 115);
        assert!(arg3.builder != @0x0 || arg3.builder_fee_bps == 0, 104);
        assert!((arg3.builder_fee_bps as u64) + (arg3.protocol_fee_bps as u64) < 10000, 105);
        assert!(arg3.rate_num != 0 && arg3.rate_den != 0, 120);
        assert!((arg3.slippage_bps as u64) < 10000, 122);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::validate_open_token(&arg3.dst_token);
        let v3 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::sui_token<T0>();
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::validate_open_token(&v3);
        let v4 = 0x2::coin::value<T0>(&arg2);
        assert!(arg3.min_gross <= v4 && v4 <= arg3.max_gross, 119);
        let (v5, v6, v7, _, v9) = open_terms(v4, arg3.builder_fee_bps, arg3.protocol_fee_bps, arg3.rate_num, arg3.rate_den, arg3.slippage_bps);
        assert!(v7 > 0, 105);
        assert!(v9 > 0, 121);
        let v10 = 0x2::tx_context::sender(arg5);
        let v11 = bump_user_counter(arg0, v10);
        let v12 = arg0.intent_nonce;
        arg0.intent_nonce = v12 + 1;
        let v13 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v14 = v13 + arg3.validity_seconds;
        let v15 = if (v1) {
            v13 + arg3.exclusive_seconds
        } else {
            0
        };
        let v16 = Terms{
            escrow_id        : v11,
            user             : v10,
            dst_chain_id     : arg3.dst_chain_id,
            dst_endpoint     : arg3.dst_endpoint,
            intent_nonce     : v12,
            expiry_time      : v14,
            input_amount     : v7,
            builder          : arg3.builder,
            builder_fee      : v5,
            protocol_fee     : v6,
            dst_token        : arg3.dst_token,
            min_dst_amount   : v9,
            dst_recipient    : arg3.dst_recipient,
            exclusive_solver : arg3.exclusive_solver,
            exclusive_until  : v15,
            delivery         : arg4,
        };
        let v17 = 0x2::object::new(arg5);
        let v18 = 0x2::object::uid_to_inner(&v17);
        let v19 = Opened{
            escrow       : v18,
            user         : v10,
            escrow_id    : v11,
            intent_hash  : terms_intent_hash<T0>(arg0, &v16),
            intent_nonce : v12,
            dst_chain_id : v16.dst_chain_id,
            expiry_time  : v14,
            builder      : v16.builder,
            builder_fee  : v5,
            protocol_fee : v6,
            raw_message  : terms_message<T0>(arg0, &v16),
        };
        0x2::event::emit<Opened>(v19);
        let Terms {
            escrow_id        : v20,
            user             : v21,
            dst_chain_id     : v22,
            dst_endpoint     : v23,
            intent_nonce     : v24,
            expiry_time      : v25,
            input_amount     : v26,
            builder          : v27,
            builder_fee      : v28,
            protocol_fee     : v29,
            dst_token        : v30,
            min_dst_amount   : v31,
            dst_recipient    : v32,
            exclusive_solver : v33,
            exclusive_until  : v34,
            delivery         : _,
        } = v16;
        if (arg4 == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_direct()) {
            let v36 = Escrow<T0>{
                id               : v17,
                escrow_id        : v20,
                user             : v21,
                dst_chain_id     : v22,
                dst_endpoint     : v23,
                intent_nonce     : v24,
                expiry_time      : v25,
                input_amount     : v26,
                builder          : v27,
                builder_fee      : v28,
                protocol_fee     : v29,
                dst_token        : v30,
                min_dst_amount   : v31,
                dst_recipient    : v32,
                exclusive_solver : v33,
                exclusive_until  : v34,
                balance          : 0x2::coin::into_balance<T0>(arg2),
            };
            0x2::transfer::share_object<Escrow<T0>>(v36);
        } else {
            let v37 = DepositEscrow<T0>{
                id               : v17,
                escrow_id        : v20,
                user             : v21,
                dst_chain_id     : v22,
                dst_endpoint     : v23,
                intent_nonce     : v24,
                expiry_time      : v25,
                input_amount     : v26,
                builder          : v27,
                builder_fee      : v28,
                protocol_fee     : v29,
                dst_token        : v30,
                min_dst_amount   : v31,
                dst_recipient    : v32,
                exclusive_solver : v33,
                exclusive_until  : v34,
                balance          : 0x2::coin::into_balance<T0>(arg2),
            };
            0x2::transfer::share_object<DepositEscrow<T0>>(v37);
        };
        v18
    }

    fun open_preimage<T0>(arg0: vector<u8>, arg1: &State, arg2: address, arg3: u64, arg4: &OpenArgs) : vector<u8> {
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, arg1.chain_id);
        0x1::vector::append<u8>(&mut arg0, arg1.endpoint);
        0x1::vector::append<u8>(&mut arg0, 0x2::address::to_bytes(arg2));
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, arg3);
        0x1::vector::append<u8>(&mut arg0, 0x1::hash::sha2_256(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::sui_token_payload<T0>()));
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, arg4.min_gross);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, arg4.max_gross);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u256_be(&mut arg0, (arg4.rate_num as u256));
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u256_be(&mut arg0, (arg4.rate_den as u256));
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, (arg4.slippage_bps as u64));
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, arg4.dst_chain_id);
        0x1::vector::append<u8>(&mut arg0, arg4.dst_endpoint);
        0x1::vector::append<u8>(&mut arg0, 0x1::hash::sha2_256(arg4.dst_token));
        0x1::vector::append<u8>(&mut arg0, arg4.dst_recipient);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, arg4.validity_seconds);
        0x1::vector::append<u8>(&mut arg0, 0x2::address::to_bytes(arg4.builder));
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, (arg4.builder_fee_bps as u64));
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::write_u64_be(&mut arg0, (arg4.protocol_fee_bps as u64));
        arg0
    }

    public fun open_terms(arg0: u64, arg1: u16, arg2: u16, arg3: u128, arg4: u128, arg5: u16) : (u64, u64, u64, u256, u256) {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        let v1 = (((arg0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        let v2 = arg0 - v0 - v1;
        let v3 = (v2 as u256) * (arg3 as u256) / (arg4 as u256);
        (v0, v1, v2, v3, v3 * ((10000 - (arg5 as u64)) as u256) / (10000 as u256))
    }

    fun package_address_raw() : vector<u8> {
        let v0 = 0x1::type_name::with_defining_ids<GUM_INTENT>();
        0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::address_string(&v0)))
    }

    public fun peer_flags(arg0: &State, arg1: u64, arg2: vector<u8>) : (bool, bool) {
        let v0 = PeerKey{
            chain_id : arg1,
            addr     : arg2,
        };
        assert!(0x2::table::contains<PeerKey, Peer>(&arg0.peers, v0), 103);
        let v1 = 0x2::table::borrow<PeerKey, Peer>(&arg0.peers, v0);
        (v1.inbound, v1.outbound)
    }

    public fun refund<T0>(arg0: &State, arg1: &0xe26ebb010bbce66dfb657993ed8b5a87cc5905ccf07fb146f60730195a79ca80::outbox_bridge::OutboxBridge, arg2: Escrow<T0>, arg3: u64, arg4: u32, arg5: vector<u8>, arg6: Proof, arg7: &mut 0x2::tx_context::TxContext) {
        verify_inbound(arg0, arg1, arg2.dst_chain_id, &arg2.dst_endpoint, arg3, arg4, &arg5, &arg6, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::finality_finalized());
        let (v0, v1, v2) = escrow_parts<T0>(arg2);
        refund_internal<T0>(arg0, v0, v1, v2, &arg5, arg7);
    }

    public fun refund_deposit<T0>(arg0: &State, arg1: &0xe26ebb010bbce66dfb657993ed8b5a87cc5905ccf07fb146f60730195a79ca80::outbox_bridge::OutboxBridge, arg2: DepositEscrow<T0>, arg3: u64, arg4: u32, arg5: vector<u8>, arg6: Proof, arg7: &mut 0x2::tx_context::TxContext) {
        verify_inbound(arg0, arg1, arg2.dst_chain_id, &arg2.dst_endpoint, arg3, arg4, &arg5, &arg6, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::finality_finalized());
        let (v0, v1, v2) = deposit_escrow_parts<T0>(arg2);
        refund_internal<T0>(arg0, v0, v1, v2, &arg5, arg7);
    }

    fun refund_internal<T0>(arg0: &State, arg1: Terms, arg2: 0x2::object::UID, arg3: 0x2::balance::Balance<T0>, arg4: &vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::decode_voided(arg4);
        let v1 = if (0x2::address::to_bytes(arg1.user) == *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::v_escrow_user(&v0)) {
            if (arg1.escrow_id == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::v_escrow_id(&v0)) {
                if (arg1.intent_nonce == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::v_intent_nonce(&v0)) {
                    arg1.expiry_time == 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::v_expiry_time(&v0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 117);
        let v2 = terms_message<T0>(arg0, &arg1);
        assert!(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::swap_intent_digest(&v2) == *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::v_swap_intent_digest(&v0), 123);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg3, arg5), arg1.user);
        0x2::object::delete(arg2);
        let v3 = RefundedEvent{
            escrow      : 0x2::object::uid_to_inner(&arg2),
            user        : arg1.user,
            escrow_id   : arg1.escrow_id,
            intent_hash : terms_intent_hash<T0>(arg0, &arg1),
        };
        0x2::event::emit<RefundedEvent>(v3);
    }

    public fun register_with_inbox(arg0: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::register<InboxWitness>(arg0, arg1, arg2);
    }

    public fun set_api_pubkey(arg0: &AdminCap, arg1: &mut State, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 118);
        arg1.api_pubkey = arg2;
    }

    public fun set_gum_bank(arg0: &AdminCap, arg1: &mut State, arg2: 0x1::option::Option<0x2::object::ID>) {
        let v0 = GumBankKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GumBankKey>(&arg1.id, v0)) {
            let v1 = GumBankKey{dummy_field: false};
            0x2::dynamic_field::remove<GumBankKey, 0x2::object::ID>(&mut arg1.id, v1);
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            let v2 = GumBankKey{dummy_field: false};
            0x2::dynamic_field::add<GumBankKey, 0x2::object::ID>(&mut arg1.id, v2, 0x1::option::destroy_some<0x2::object::ID>(arg2));
        };
    }

    public fun set_open_paused(arg0: &AdminCap, arg1: &mut State, arg2: bool) {
        arg1.open_paused = arg2;
    }

    public fun set_peer(arg0: &AdminCap, arg1: &mut State, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: bool) {
        let v0 = if (0x1::vector::length<u8>(&arg4) == 32) {
            if (0x1::vector::length<u8>(&arg3) == 32) {
                0x1::vector::length<u8>(&arg5) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 118);
        let v1 = PeerKey{
            chain_id : arg2,
            addr     : arg3,
        };
        let v2 = Peer{
            inbox    : arg4,
            sender   : arg5,
            inbound  : arg6,
            outbound : arg7,
        };
        if (0x2::table::contains<PeerKey, Peer>(&arg1.peers, v1)) {
            *0x2::table::borrow_mut<PeerKey, Peer>(&mut arg1.peers, v1) = v2;
        } else {
            0x2::table::add<PeerKey, Peer>(&mut arg1.peers, v1, v2);
        };
    }

    public fun set_solver(arg0: &AdminCap, arg1: &mut State, arg2: address, arg3: bool) {
        let v0 = 0x2::table::contains<address, bool>(&arg1.solvers, arg2);
        if (arg3 && !v0) {
            0x2::table::add<address, bool>(&mut arg1.solvers, arg2, true);
        } else if (!arg3 && v0) {
            0x2::table::remove<address, bool>(&mut arg1.solvers, arg2);
        };
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut State, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun settle<T0>(arg0: &State, arg1: &0xe26ebb010bbce66dfb657993ed8b5a87cc5905ccf07fb146f60730195a79ca80::outbox_bridge::OutboxBridge, arg2: Escrow<T0>, arg3: u64, arg4: u32, arg5: vector<u8>, arg6: Proof, arg7: &mut 0x2::tx_context::TxContext) {
        verify_inbound(arg0, arg1, arg2.dst_chain_id, &arg2.dst_endpoint, arg3, arg4, &arg5, &arg6, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::finality_finalized());
        let (v0, v1, v2) = escrow_parts<T0>(arg2);
        settle_internal<T0>(arg0, v0, v1, v2, &arg5, arg7);
    }

    public fun settle_deposit<T0>(arg0: &State, arg1: &0xe26ebb010bbce66dfb657993ed8b5a87cc5905ccf07fb146f60730195a79ca80::outbox_bridge::OutboxBridge, arg2: DepositEscrow<T0>, arg3: u64, arg4: u32, arg5: vector<u8>, arg6: Proof, arg7: &mut 0x2::tx_context::TxContext) {
        verify_inbound(arg0, arg1, arg2.dst_chain_id, &arg2.dst_endpoint, arg3, arg4, &arg5, &arg6, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::finality_confirmed());
        let (v0, v1, v2) = deposit_escrow_parts<T0>(arg2);
        settle_internal<T0>(arg0, v0, v1, v2, &arg5, arg7);
    }

    fun settle_internal<T0>(arg0: &State, arg1: Terms, arg2: 0x2::object::UID, arg3: 0x2::balance::Balance<T0>, arg4: &vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::decode_fulfilled(arg4);
        assert!(terms_intent_hash<T0>(arg0, &arg1) == *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::f_intent_hash(&v0), 116);
        let v1 = terms_message<T0>(arg0, &arg1);
        assert!(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::swap_intent_digest(&v1) == *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::f_swap_intent_digest(&v0), 123);
        let v2 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::raw_to_address(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::f_claim_target(&v0));
        if (arg1.builder_fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg3, arg1.builder_fee, arg5), arg1.builder);
        };
        if (arg1.protocol_fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg3, arg1.protocol_fee, arg5), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg3, arg5), v2);
        0x2::object::delete(arg2);
        let v3 = SettledEvent{
            escrow       : 0x2::object::uid_to_inner(&arg2),
            user         : arg1.user,
            escrow_id    : arg1.escrow_id,
            intent_hash  : *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::f_intent_hash(&v0),
            claim_target : v2,
        };
        0x2::event::emit<SettledEvent>(v3);
    }

    public fun swap_intent_message<T0>(arg0: &State, arg1: &Escrow<T0>) : vector<u8> {
        let v0 = terms<T0>(arg1);
        terms_message<T0>(arg0, &v0)
    }

    fun terms<T0>(arg0: &Escrow<T0>) : Terms {
        Terms{
            escrow_id        : arg0.escrow_id,
            user             : arg0.user,
            dst_chain_id     : arg0.dst_chain_id,
            dst_endpoint     : arg0.dst_endpoint,
            intent_nonce     : arg0.intent_nonce,
            expiry_time      : arg0.expiry_time,
            input_amount     : arg0.input_amount,
            builder          : arg0.builder,
            builder_fee      : arg0.builder_fee,
            protocol_fee     : arg0.protocol_fee,
            dst_token        : arg0.dst_token,
            min_dst_amount   : arg0.min_dst_amount,
            dst_recipient    : arg0.dst_recipient,
            exclusive_solver : arg0.exclusive_solver,
            exclusive_until  : arg0.exclusive_until,
            delivery         : 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::delivery_direct(),
        }
    }

    fun terms_intent_hash<T0>(arg0: &State, arg1: &Terms) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg1.user);
        let v1 = 0x1::hash::sha2_256(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::sui_token_payload<T0>());
        let v2 = 0x2::address::to_bytes(arg1.builder);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::intent_hash(arg0.chain_id, arg1.escrow_id, arg1.dst_chain_id, &arg1.dst_endpoint, arg1.intent_nonce, &v0, arg1.expiry_time, &v1, (arg1.input_amount as u256), &v2, (arg1.builder_fee as u256), (arg1.protocol_fee as u256))
    }

    fun terms_message<T0>(arg0: &State, arg1: &Terms) : vector<u8> {
        let v0 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::new_swap_intent(arg1.intent_nonce, terms_intent_hash<T0>(arg0, arg1), arg1.escrow_id, 0x2::address::to_bytes(arg1.user), arg1.expiry_time, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::sui_token<T0>(), (arg1.input_amount as u256), arg1.dst_token, arg1.min_dst_amount, arg1.dst_recipient, arg1.delivery, arg1.exclusive_solver, arg1.exclusive_until);
        0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::encode_swap_intent(arg1.dst_chain_id, &arg1.dst_endpoint, &v0)
    }

    public fun user_counter(arg0: &State, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_counters, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_counters, arg1)
        } else {
            0
        }
    }

    fun verify_inbound(arg0: &State, arg1: &0xe26ebb010bbce66dfb657993ed8b5a87cc5905ccf07fb146f60730195a79ca80::outbox_bridge::OutboxBridge, arg2: u64, arg3: &vector<u8>, arg4: u64, arg5: u32, arg6: &vector<u8>, arg7: &Proof, arg8: u32) {
        assert!(arg0.initialized, 100);
        let v0 = inbound_peer(arg0, arg2, arg3);
        assert!(arg5 >= arg8, 107);
        0xe26ebb010bbce66dfb657993ed8b5a87cc5905ccf07fb146f60730195a79ca80::outbox_bridge::verify_inbox_message(arg1, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::inbox_msg_hash(arg4, arg5, &v0.sender, arg6), arg2, v0.inbox, arg7.epoch, arg7.merkle_idx, arg7.merkle_proof, arg7.aggregate_pubkey, arg7.signature);
        check_header(arg0, arg6);
    }

    public fun void(arg0: &State, arg1: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>) {
        assert!(arg0.initialized, 100);
        inbound_peer(arg0, arg3, &arg4);
        check_swap_intent_header(arg0, &arg5);
        let (_, _) = void_internal(arg0, arg1, arg2, arg3, arg4, &arg5);
    }

    fun void_internal(arg0: &State, arg1: &mut 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::InboxBridge, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: &vector<u8>) : (u64, vector<u8>) {
        let v0 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::decode_swap_intent(arg5);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_expiry_time(&v0), 111);
        let v1 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::swap_intent_digest(arg5);
        let v2 = ConsumedKey{
            origin_chain_id    : arg3,
            origin_addr        : arg4,
            swap_intent_digest : v1,
        };
        assert!(!0x2::table::contains<ConsumedKey, bool>(&arg0.consumed, v2), 113);
        let v3 = 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::new_voided(0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_intent_nonce(&v0), 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_escrow_id(&v0), *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_src_user(&v0), 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_expiry_time(&v0), v1);
        let v4 = InboxWitness{dummy_field: false};
        let (_, v6, v7) = 0x8f5d8eecedc3ec113c7d23b4d9816c33f495d8e1829b3e250275e4d3a31fdce7::inbox_bridge::submit_inbox_message<InboxWitness>(arg1, v4, 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::encode_voided(arg3, &arg4, &v3), arg2);
        let v8 = VoidedEvent{
            origin_chain_id    : arg3,
            intent_nonce       : 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_intent_nonce(&v0),
            escrow_user        : *0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_src_user(&v0),
            escrow_id          : 0x2923e89deb05b72a584da0c5f1b593654538d2af352d2988c84072bfe5f145be::wire::si_escrow_id(&v0),
            msg_id             : v6,
            swap_intent_digest : v1,
        };
        0x2::event::emit<VoidedEvent>(v8);
        (v6, v7)
    }

    // decompiled from Move bytecode v7
}

