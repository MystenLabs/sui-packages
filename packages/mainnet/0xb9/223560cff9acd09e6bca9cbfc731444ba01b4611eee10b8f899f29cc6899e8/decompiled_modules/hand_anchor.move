module 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::hand_anchor {
    struct HandPlayer has copy, drop, store {
        seat_idx: u8,
        seat_epoch: u64,
        address: address,
        account_id: 0x2::object::ID,
        start_stack: u64,
        session_pubkey: vector<u8>,
    }

    struct Checkpoint has copy, drop, store {
        seq: u64,
        state_root: vector<u8>,
        seat_stacks: vector<u64>,
        pot: u64,
        rake_so_far: u64,
        chain_hash: vector<u8>,
        signer_bitmap: u64,
        signatures: vector<vector<u8>>,
        created_at_ms: u64,
    }

    struct HandAnchor has key {
        id: 0x2::object::UID,
        table_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        hand_seq: u64,
        player_list: vector<HandPlayer>,
        deck_root: vector<u8>,
        proof_bundle_hash: vector<u8>,
        committee_list: vector<address>,
        status: u8,
        trust_model: u8,
        last_checkpoint_seq: u64,
        latest_checkpoint: 0x1::option::Option<Checkpoint>,
        opened_board_cards: vector<u8>,
        started_at_ms: u64,
        deadline_at_ms: u64,
    }

    struct HandStarted has copy, drop {
        hand_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
        hand_seq: u64,
        player_list: vector<HandPlayer>,
        deck_root: vector<u8>,
        proof_bundle_hash: vector<u8>,
        deadline_at_ms: u64,
        trust_model: u8,
        started_at_ms: u64,
    }

    struct HandSettled has copy, drop {
        hand_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
        final_balances: vector<u64>,
        rake: u64,
        trust_model: u8,
        settled_at_ms: u64,
    }

    struct HandVoided has copy, drop {
        hand_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
        reason_code: u64,
        voided_at_ms: u64,
    }

    struct BoardCardOpened has copy, drop {
        hand_id: 0x2::object::ID,
        idx: u8,
        card: u8,
    }

    fun build_settle_message_v1(arg0: &0x2::object::ID, arg1: &vector<u64>, arg2: u64) : vector<u8> {
        let v0 = b"endless.poker.settle.v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun cp_chain_hash(arg0: &Checkpoint) : &vector<u8> {
        &arg0.chain_hash
    }

    public fun cp_created_at_ms(arg0: &Checkpoint) : u64 {
        arg0.created_at_ms
    }

    public fun cp_pot(arg0: &Checkpoint) : u64 {
        arg0.pot
    }

    public fun cp_rake_so_far(arg0: &Checkpoint) : u64 {
        arg0.rake_so_far
    }

    public fun cp_seat_stacks(arg0: &Checkpoint) : &vector<u64> {
        &arg0.seat_stacks
    }

    public fun cp_seq(arg0: &Checkpoint) : u64 {
        arg0.seq
    }

    public fun cp_signatures(arg0: &Checkpoint) : &vector<vector<u8>> {
        &arg0.signatures
    }

    public fun cp_signer_bitmap(arg0: &Checkpoint) : u64 {
        arg0.signer_bitmap
    }

    public fun cp_state_root(arg0: &Checkpoint) : &vector<u8> {
        &arg0.state_root
    }

    public fun deadline_at_ms(arg0: &HandAnchor) : u64 {
        arg0.deadline_at_ms
    }

    public fun deck_root(arg0: &HandAnchor) : &vector<u8> {
        &arg0.deck_root
    }

    fun execute_settle<T0>(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>, arg1: &mut HandAnchor, arg2: vector<u64>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 501);
        assert!(arg1.table_id == 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>>(arg0), 502);
        assert!(0x1::option::is_some<Checkpoint>(&arg1.latest_checkpoint), 507);
        let v0 = 0x1::vector::length<HandPlayer>(&arg1.player_list);
        assert!(0x1::vector::length<u64>(&arg2) == v0, 508);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + 0x1::vector::borrow<HandPlayer>(&arg1.player_list, v2).start_stack;
            v2 = v2 + 1;
        };
        assert!(vec_sum(&arg2) + arg3 == v1, 509);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<HandPlayer>(&arg1.player_list, v3);
            0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::apply_seat_outcome<T0>(arg0, v4.seat_idx, v4.seat_epoch, v4.address, *0x1::vector::borrow<u64>(&arg2, v3));
            v3 = v3 + 1;
        };
        if (arg3 > 0) {
            let v5 = 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::stakes_rake_cap(0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::stakes_config<T0>(arg0));
            assert!(v5 == 0 || arg3 <= v5, 523);
            assert!(arg3 <= 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::escrow_value<T0>(arg0), 511);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::take_from_escrow<T0>(arg0, arg3), arg5), @0x117c5e19bc1884228f68ecaab30767dd016daaf3976bf2e3e0018e66fd45be71);
        };
        arg1.status = 2;
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::clear_active_hand<T0>(arg0, 0x2::object::id<HandAnchor>(arg1));
        let v6 = HandSettled{
            hand_id        : 0x2::object::id<HandAnchor>(arg1),
            table_id       : arg1.table_id,
            final_balances : arg2,
            rake           : arg3,
            trust_model    : arg1.trust_model,
            settled_at_ms  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<HandSettled>(v6);
    }

    fun execute_void<T0>(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>, arg1: &mut HandAnchor, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.status == 1, 501);
        assert!(arg1.table_id == 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>>(arg0), 502);
        let v0 = 0;
        while (v0 < 0x1::vector::length<HandPlayer>(&arg1.player_list)) {
            let v1 = 0x1::vector::borrow<HandPlayer>(&arg1.player_list, v0);
            0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::apply_seat_outcome<T0>(arg0, v1.seat_idx, v1.seat_epoch, v1.address, v1.start_stack);
            v0 = v0 + 1;
        };
        arg1.status = 3;
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::clear_active_hand<T0>(arg0, 0x2::object::id<HandAnchor>(arg1));
        let v2 = HandVoided{
            hand_id      : 0x2::object::id<HandAnchor>(arg1),
            table_id     : arg1.table_id,
            reason_code  : arg2,
            voided_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<HandVoided>(v2);
    }

    public(friend) fun hand_id(arg0: &HandAnchor) : 0x2::object::ID {
        0x2::object::id<HandAnchor>(arg0)
    }

    public fun hand_seq(arg0: &HandAnchor) : u64 {
        arg0.hand_seq
    }

    public(friend) fun is_active(arg0: &HandAnchor) : bool {
        arg0.status == 1
    }

    fun is_hand_player(arg0: &HandAnchor, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HandPlayer>(&arg0.player_list)) {
            if (0x1::vector::borrow<HandPlayer>(&arg0.player_list, v0).address == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun last_checkpoint_seq(arg0: &HandAnchor) : u64 {
        arg0.last_checkpoint_seq
    }

    public fun latest_checkpoint(arg0: &HandAnchor) : &0x1::option::Option<Checkpoint> {
        &arg0.latest_checkpoint
    }

    public(friend) fun new_checkpoint(arg0: u64, arg1: vector<u8>, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: vector<vector<u8>>, arg8: u64) : Checkpoint {
        Checkpoint{
            seq           : arg0,
            state_root    : arg1,
            seat_stacks   : arg2,
            pot           : arg3,
            rake_so_far   : arg4,
            chain_hash    : arg5,
            signer_bitmap : arg6,
            signatures    : arg7,
            created_at_ms : arg8,
        }
    }

    public fun new_hand_player(arg0: u8, arg1: u64, arg2: address, arg3: 0x2::object::ID, arg4: u64) : HandPlayer {
        new_hand_player_with_pubkey(arg0, arg1, arg2, arg3, arg4, 0x1::vector::empty<u8>())
    }

    public fun new_hand_player_with_pubkey(arg0: u8, arg1: u64, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>) : HandPlayer {
        HandPlayer{
            seat_idx       : arg0,
            seat_epoch     : arg1,
            address        : arg2,
            account_id     : arg3,
            start_stack    : arg4,
            session_pubkey : arg5,
        }
    }

    public fun open_board_card(arg0: &mut HandAnchor, arg1: &0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::assert_coordinator(arg1, arg3);
        assert!(arg0.registry_id == 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry>(arg1), 521);
        assert!(arg0.status == 1, 501);
        0x1::vector::push_back<u8>(&mut arg0.opened_board_cards, arg2);
        let v0 = BoardCardOpened{
            hand_id : 0x2::object::id<HandAnchor>(arg0),
            idx     : (0x1::vector::length<u8>(&arg0.opened_board_cards) as u8),
            card    : arg2,
        };
        0x2::event::emit<BoardCardOpened>(v0);
    }

    public fun opened_board_cards(arg0: &HandAnchor) : &vector<u8> {
        &arg0.opened_board_cards
    }

    public fun player_account_id(arg0: &HandPlayer) : 0x2::object::ID {
        arg0.account_id
    }

    public fun player_address(arg0: &HandPlayer) : address {
        arg0.address
    }

    public(friend) fun player_count(arg0: &HandAnchor) : u64 {
        0x1::vector::length<HandPlayer>(&arg0.player_list)
    }

    public fun player_list(arg0: &HandAnchor) : &vector<HandPlayer> {
        &arg0.player_list
    }

    public fun player_seat_epoch(arg0: &HandPlayer) : u64 {
        arg0.seat_epoch
    }

    public fun player_seat_idx(arg0: &HandPlayer) : u8 {
        arg0.seat_idx
    }

    public fun player_session_pubkey(arg0: &HandPlayer) : &vector<u8> {
        &arg0.session_pubkey
    }

    public fun player_start_stack(arg0: &HandPlayer) : u64 {
        arg0.start_stack
    }

    fun popcount_u64(arg0: u64) : u64 {
        let v0 = 0;
        while (arg0 > 0) {
            v0 = v0 + (arg0 & 1);
            arg0 = arg0 >> 1;
        };
        v0
    }

    public(friend) fun prev_chain_hash(arg0: &HandAnchor) : vector<u8> {
        if (0x1::option::is_some<Checkpoint>(&arg0.latest_checkpoint)) {
            0x1::option::borrow<Checkpoint>(&arg0.latest_checkpoint).chain_hash
        } else {
            zero_hash()
        }
    }

    public fun proof_bundle_hash(arg0: &HandAnchor) : &vector<u8> {
        &arg0.proof_bundle_hash
    }

    public(friend) fun registry_id(arg0: &HandAnchor) : 0x2::object::ID {
        arg0.registry_id
    }

    public(friend) fun set_latest_checkpoint(arg0: &mut HandAnchor, arg1: Checkpoint) {
        arg0.last_checkpoint_seq = arg1.seq;
        arg0.latest_checkpoint = 0x1::option::some<Checkpoint>(arg1);
    }

    public fun settle_hand<T0>(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>, arg1: &mut HandAnchor, arg2: &0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry, arg3: vector<u64>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::assert_coordinator(arg2, arg6);
        assert!(arg1.registry_id == 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry>(arg2), 521);
        execute_settle<T0>(arg0, arg1, arg3, arg4, arg5, arg6);
    }

    public fun settle_hand_with_quorum<T0>(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>, arg1: &mut HandAnchor, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 501);
        let v0 = 0x1::vector::length<HandPlayer>(&arg1.player_list);
        assert!(0x1::vector::length<u64>(&arg2) == v0, 508);
        let v1 = 0x1::vector::length<vector<u8>>(&arg5);
        assert!(v1 == popcount_u64(arg4), 519);
        assert!(v1 >= (v0 * 2 + 2) / 3, 518);
        let v2 = 0x2::object::id<HandAnchor>(arg1);
        let v3 = build_settle_message_v1(&v2, &arg2, arg3);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v0) {
            if (arg4 & 1 << (v5 as u8) != 0) {
                let v6 = 0x1::vector::borrow<HandPlayer>(&arg1.player_list, v5);
                assert!(0x1::vector::length<u8>(&v6.session_pubkey) == 32, 517);
                assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg5, v4), &v6.session_pubkey, &v3), 520);
                v4 = v4 + 1;
            };
            v5 = v5 + 1;
        };
        arg1.trust_model = 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::version::trust_player_quorum();
        execute_settle<T0>(arg0, arg1, arg2, arg3, arg6, arg7);
    }

    public fun settle_message_v1(arg0: &0x2::object::ID, arg1: &vector<u64>, arg2: u64) : vector<u8> {
        build_settle_message_v1(arg0, arg1, arg2)
    }

    public fun start_hand<T0>(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>, arg1: &0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry, arg2: u64, arg3: vector<HandPlayer>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<address>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::assert_coordinator(arg1, arg9);
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::assert_registry<T0>(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 505);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 506);
        let v0 = 0x1::vector::length<HandPlayer>(&arg3);
        assert!(v0 >= 2, 503);
        assert!(v0 <= 9, 510);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg7 > v1, 504);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<HandPlayer>(&arg3, v3);
            assert!(!0x1::vector::contains<u8>(&v2, &v4.seat_idx), 522);
            0x1::vector::push_back<u8>(&mut v2, v4.seat_idx);
            0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::assert_seat_matches<T0>(arg0, v4.seat_idx, v4.seat_epoch, v4.address, v4.account_id);
            assert!(v4.start_stack == 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::seat_current_stack<T0>(arg0, v4.seat_idx), 512);
            let v5 = 0x1::vector::length<u8>(&v4.session_pubkey);
            assert!(v5 == 0 || v5 == 32, 516);
            v3 = v3 + 1;
        };
        let v6 = 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>>(arg0);
        let v7 = HandAnchor{
            id                  : 0x2::object::new(arg9),
            table_id            : v6,
            registry_id         : 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry>(arg1),
            hand_seq            : arg2,
            player_list         : arg3,
            deck_root           : arg4,
            proof_bundle_hash   : arg5,
            committee_list      : arg6,
            status              : 1,
            trust_model         : 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::version::trust_prototype(),
            last_checkpoint_seq : 0,
            latest_checkpoint   : 0x1::option::none<Checkpoint>(),
            opened_board_cards  : 0x1::vector::empty<u8>(),
            started_at_ms       : v1,
            deadline_at_ms      : arg7,
        };
        let v8 = 0x2::object::id<HandAnchor>(&v7);
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::mark_active_hand<T0>(arg0, v8);
        let v9 = HandStarted{
            hand_id           : v8,
            table_id          : v6,
            hand_seq          : v7.hand_seq,
            player_list       : v7.player_list,
            deck_root         : v7.deck_root,
            proof_bundle_hash : v7.proof_bundle_hash,
            deadline_at_ms    : v7.deadline_at_ms,
            trust_model       : v7.trust_model,
            started_at_ms     : v7.started_at_ms,
        };
        0x2::event::emit<HandStarted>(v9);
        0x2::transfer::share_object<HandAnchor>(v7);
    }

    public fun status(arg0: &HandAnchor) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        1
    }

    public fun status_settled() : u8 {
        2
    }

    public fun status_voided() : u8 {
        3
    }

    public fun table_id(arg0: &HandAnchor) : 0x2::object::ID {
        arg0.table_id
    }

    public fun trust_model(arg0: &HandAnchor) : u8 {
        arg0.trust_model
    }

    fun vec_sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun void_hand<T0>(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>, arg1: &mut HandAnchor, arg2: &0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::assert_coordinator(arg2, arg5);
        assert!(arg1.registry_id == 0x2::object::id<0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::coordinator_registry::CoordinatorRegistry>(arg2), 521);
        execute_void<T0>(arg0, arg1, arg3, arg4);
    }

    public fun void_hand_after_deadline<T0>(arg0: &mut 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::table_anchor::TableAnchor<T0>, arg1: &mut HandAnchor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 501);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.deadline_at_ms, 514);
        assert!(is_hand_player(arg1, 0x2::tx_context::sender(arg3)), 515);
        execute_void<T0>(arg0, arg1, 1, arg2);
    }

    fun zero_hash() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

