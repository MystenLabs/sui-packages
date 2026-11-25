module 0x356be0ce0790173ade29fa856fd22200c44e7b2f74f82170001b96f1316dc8a::substrate {
    struct SUBSTRATE has drop {
        dummy_field: bool,
    }

    struct Actor has key {
        id: 0x2::object::UID,
        aid: 0x1::string::String,
        name: 0x1::string::String,
        actor_type: 0x1::string::String,
        owner: 0x1::string::String,
        status: 0x1::string::String,
        success_rate: u64,
        activity_score: u64,
        sample_count: u64,
        balance: u64,
        path_id: 0x1::string::String,
    }

    struct Group has key {
        id: 0x2::object::UID,
        gid: 0x1::string::String,
        name: 0x1::string::String,
        group_type: 0x1::string::String,
        status: 0x1::string::String,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        fade_rate: u64,
        members: 0x2::table::Table<address, Member>,
        owners: u64,
        wait_ms: u64,
        paper: address,
    }

    struct SignalObj has key {
        id: 0x2::object::UID,
        signal_id: 0x1::string::String,
        receiver: 0x1::string::String,
        task_name: 0x1::string::String,
        sender: 0x1::string::String,
        status: 0x1::string::String,
        timestamp: u64,
    }

    struct Highway has key {
        id: 0x2::object::UID,
        highway_id: 0x1::string::String,
        source_ref: 0x1::string::String,
        target_ref: 0x1::string::String,
        hardened_strength: u64,
        hardened_at: u64,
        confidence: u64,
    }

    struct ScopedWallet has key {
        id: 0x2::object::UID,
        wallet_id: 0x1::string::String,
        owner: 0x1::string::String,
        purpose: 0x1::string::String,
        wallet_state: u64,
    }

    struct SpendCeiling has key {
        id: 0x2::object::UID,
        ceiling_id: 0x1::string::String,
        owner: address,
        agent_ref: 0x1::string::String,
        max_per_tx: u64,
        max_total: u64,
        total_spend: u64,
        ceiling_state: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x1::string::String,
        owner: address,
        line: u64,
        quorum_move: u64,
        quorum_signers: u64,
        balance: 0x2::balance::Balance<T0>,
        vault_state: u64,
        owner_spent: u64,
        owner_period_start: u64,
        grant_signers: vector<address>,
        readers: vector<address>,
        sealed_hash: vector<u8>,
        group_ref: 0x2::object::ID,
        signers: 0x2::vec_map::VecMap<address, Signer>,
        pause_epoch: u64,
        wait_ms: u64,
        paper: address,
    }

    struct AffiliateProgram has key {
        id: 0x2::object::UID,
        program_id: 0x1::string::String,
        owner: 0x1::string::String,
        commission_model: u64,
        commission_bps: u64,
        commission_fixed: u64,
        min_payout: u64,
    }

    struct AffiliateBudget has key {
        id: 0x2::object::UID,
        budget_id: 0x1::string::String,
        program_ref: 0x1::string::String,
        event_kind: 0x1::string::String,
        rate_per_event: u64,
        total_budget: u64,
        spent: u64,
        velocity_cap: u64,
        budget_state: u64,
    }

    struct Referral has key {
        id: 0x2::object::UID,
        referral_id: 0x1::string::String,
        program_ref: 0x1::string::String,
        affiliate_ref: 0x1::string::String,
        referrer_address: 0x1::string::String,
        conversions: u64,
        referral_state: u64,
    }

    struct WorkerCap has key {
        id: 0x2::object::UID,
        cap_id: 0x1::string::String,
        scope: 0x1::string::String,
    }

    struct Path has key {
        id: 0x2::object::UID,
        source: address,
        target: address,
        path_id: 0x1::string::String,
        path_type: 0x1::string::String,
        strength: u64,
        resistance: u64,
        hits: u64,
        misses: u64,
        path_status: 0x1::string::String,
    }

    struct Contains has key {
        id: 0x2::object::UID,
        parent: address,
        child: address,
    }

    struct Escrow has key {
        id: 0x2::object::UID,
        poster: address,
        worker: address,
        escrow_id: 0x1::string::String,
        bounty: 0x2::balance::Balance<0x2::sui::SUI>,
        deadline: u64,
        escrow_status: 0x1::string::String,
    }

    struct Spawns has key {
        id: 0x2::object::UID,
        parent: address,
        child: address,
    }

    struct ActorCreated has copy, drop {
        actor: address,
    }

    struct GroupCreated has copy, drop {
        group: address,
    }

    struct SignalObjCreated has copy, drop {
        signal_obj: address,
    }

    struct HighwayCreated has copy, drop {
        highway: address,
    }

    struct ScopedWalletCreated has copy, drop {
        scoped_wallet: address,
    }

    struct SpendCeilingCreated has copy, drop {
        spend_ceiling: address,
    }

    struct VaultCreated has copy, drop {
        vault: address,
        coin: 0x1::ascii::String,
        owner: address,
        line: u64,
        quorum_move: u64,
        quorum_signers: u64,
    }

    struct AffiliateProgramCreated has copy, drop {
        affiliate_program: address,
    }

    struct AffiliateBudgetCreated has copy, drop {
        affiliate_budget: address,
    }

    struct ReferralCreated has copy, drop {
        referral: address,
    }

    struct WorkerCapCreated has copy, drop {
        worker_cap: address,
    }

    struct PathCreated has copy, drop {
        path: address,
    }

    struct ContainsCreated has copy, drop {
        contains: address,
    }

    struct EscrowCreated has copy, drop {
        escrow: address,
    }

    struct SpawnsCreated has copy, drop {
        spawns: address,
    }

    struct SpendCeilingTotalSpendRecorded has copy, drop {
        spend_ceiling: address,
        amount: u64,
        total: u64,
    }

    struct SpendCeilingUpdated has copy, drop {
        spend_ceiling: address,
        max_per_tx: u64,
        max_total: u64,
    }

    struct SpendCeilingRevoked has copy, drop {
        spend_ceiling: address,
    }

    struct Signer has copy, drop, store {
        weight: u64,
        max_per_tx: u64,
        max_per_period: u64,
        spent: u64,
        period_start: u64,
        signer_state: u64,
        max_lifetime: u64,
        lifetime_spent: u64,
        life: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        vault: address,
        kind: u8,
        to: address,
        amount: u64,
        weight: u64,
        max_per_tx: u64,
        max_per_period: u64,
        max_lifetime: u64,
        line: u64,
        quorum_move: u64,
        quorum_signers: u64,
        approvals: vector<address>,
        approval_lives: vector<u64>,
        approved_weight: u64,
        expires_at: u64,
        proposal_state: u64,
        pause_epoch: u64,
        ready_at: u64,
    }

    struct VaultSpent has copy, drop {
        vault: address,
        who: address,
        amount: u64,
        to: address,
        spent: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault: address,
        who: address,
        amount: u64,
        to: address,
        approvers: vector<address>,
    }

    struct VaultProposed has copy, drop {
        vault: address,
        proposal: address,
        kind: u8,
        who: address,
    }

    struct VaultApproved has copy, drop {
        vault: address,
        proposal: address,
        who: address,
        approved_weight: u64,
        executed: bool,
    }

    struct VaultSignerSet has copy, drop {
        vault: address,
        who: address,
        weight: u64,
        max_per_tx: u64,
        max_per_period: u64,
        signer_state: u64,
        life: u64,
    }

    struct SignerLifetimeSet has copy, drop {
        vault: address,
        who: address,
        max_lifetime: u64,
        lifetime_spent: u64,
    }

    struct VaultPeriodRolled has copy, drop {
        vault: address,
        who: address,
        owners: bool,
        period_start: u64,
    }

    struct VaultLineSet has copy, drop {
        vault: address,
        line: u64,
        quorum_move: u64,
        quorum_signers: u64,
    }

    struct VaultPaused has copy, drop {
        vault: address,
        paused: bool,
    }

    struct VaultOwnerTransferred has copy, drop {
        vault: address,
        previous_owner: address,
        new_owner: address,
    }

    struct VaultDeposited has copy, drop {
        vault: address,
        who: address,
        amount: u64,
    }

    struct WaitSet has copy, drop {
        vault: address,
        wait_ms: u64,
        paper: address,
    }

    struct ChangeWaiting has copy, drop {
        vault: address,
        proposal: address,
        kind: u8,
        ready_at: u64,
    }

    struct ChangeLanded has copy, drop {
        vault: address,
        proposal: address,
        kind: u8,
    }

    struct ChangeCancelled has copy, drop {
        vault: address,
        proposal: address,
        sender: address,
    }

    struct RotationWaiting has copy, drop {
        vault: address,
        from: address,
        to: address,
        ready_at: u64,
    }

    struct RotationCancelled has copy, drop {
        vault: address,
        from: address,
        sender: address,
    }

    struct OwnerOfferKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwnerOffer has copy, drop, store {
        pk: vector<u8>,
        keep_tx: u64,
        keep_period: u64,
        expires_at: u64,
        ready_at: u64,
        by: address,
    }

    struct OwnerOffered has copy, drop {
        vault: address,
        seat_pk: vector<u8>,
        keep_tx: u64,
        keep_period: u64,
        expires_at: u64,
        ready_at: u64,
        by: address,
        replaced: bool,
    }

    struct RotationKey has copy, drop, store {
        from: address,
    }

    struct Rotation has copy, drop, store {
        to: address,
    }

    struct VaultGrantSignersSet has copy, drop {
        vault: address,
        who: address,
        added: bool,
        sender: address,
        grant_signers: vector<address>,
    }

    struct VaultGrantSignerProposed has copy, drop {
        vault: address,
        who: address,
        sender: address,
    }

    struct VaultGrantSignerWithdrawn has copy, drop {
        vault: address,
        who: address,
        sender: address,
    }

    struct GrantSignersPendingKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GrantSignersPending has copy, drop, store {
        who: address,
        by: address,
        ready_at: u64,
    }

    struct GrantSignersResetKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultGrantSignersResetRequested has copy, drop {
        vault: address,
        sender: address,
        ready_at: u64,
        grant_signers: vector<address>,
    }

    struct VaultGrantSignersResetCancelled has copy, drop {
        vault: address,
        sender: address,
    }

    struct VaultReadersSet has copy, drop {
        vault: address,
        readers: vector<address>,
    }

    struct ReadersWaitKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReadersWaiting has copy, drop, store {
        list: vector<address>,
        ready_at: u64,
        by: address,
    }

    struct VaultSealedHashSet has copy, drop {
        vault: address,
        sealed_hash: vector<u8>,
    }

    struct Member has copy, drop, store {
        rung: u64,
        member_state: u64,
    }

    struct Seat has copy, drop, store {
        rung: u64,
        expires_at: u64,
        hand_over: bool,
        by: address,
        approvals: vector<address>,
        ready_at: u64,
    }

    struct GroupChangeKey has copy, drop, store {
        kind: u8,
        who: address,
    }

    struct GroupChange has copy, drop, store {
        value: u64,
        to: address,
        by: address,
        ready_at: u64,
    }

    struct ChangesByKey has copy, drop, store {
        by: address,
    }

    struct SeatKey has copy, drop, store {
        pk: vector<u8>,
    }

    struct OwnerActKey has copy, drop, store {
        act: u8,
        who: address,
        rung: u64,
    }

    struct RemovalKey has copy, drop, store {
        who: address,
    }

    struct Removal has copy, drop, store {
        by: address,
        ready_at: u64,
        epoch: u64,
    }

    struct RotatedKey has copy, drop, store {
        from: address,
    }

    struct OwnersEpochKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MemberSet has copy, drop {
        group: address,
        who: address,
        rung: u64,
        member_state: u64,
        owners: u64,
    }

    struct SeatOffered has copy, drop {
        group: address,
        seat_pk: vector<u8>,
        rung: u64,
        by: address,
        expires_at: u64,
        hand_over: bool,
        approvals: u64,
    }

    struct SeatTaken has copy, drop {
        group: address,
        seat_pk: vector<u8>,
        who: address,
        rung: u64,
    }

    struct SeatWithdrawn has copy, drop {
        group: address,
        seat_pk: vector<u8>,
        sender: address,
    }

    struct OwnerActProposed has copy, drop {
        group: address,
        act: u8,
        who: address,
        rung: u64,
        by: address,
    }

    struct OwnerRemovalRequested has copy, drop {
        group: address,
        who: address,
        by: address,
        ready_at: u64,
    }

    struct OwnerRemovalCancelled has copy, drop {
        group: address,
        who: address,
        sender: address,
    }

    struct MemberRotated has copy, drop {
        group: address,
        from: address,
        to: address,
    }

    struct GroupWaitSet has copy, drop {
        group: address,
        wait_ms: u64,
        paper: address,
    }

    struct GroupChangeWaiting has copy, drop {
        group: address,
        kind: u8,
        who: address,
        to: address,
        value: u64,
        ready_at: u64,
    }

    struct GroupChangeLanded has copy, drop {
        group: address,
        kind: u8,
        who: address,
    }

    struct GroupChangeCancelled has copy, drop {
        group: address,
        kind: u8,
        who: address,
        sender: address,
    }

    struct Marked has copy, drop {
        path: address,
        amount: u64,
        strength: u64,
    }

    struct Warned has copy, drop {
        path: address,
        amount: u64,
        resistance: u64,
    }

    struct Hardened has copy, drop {
        path: address,
        strength: u64,
    }

    struct Faded has copy, drop {
        path: address,
        strength_before: u64,
        strength_after: u64,
    }

    struct Followed has copy, drop {
        path: address,
    }

    public fun balance(arg0: &Actor) : u64 {
        arg0.balance
    }

    public fun sender(arg0: &SignalObj) : &0x1::string::String {
        &arg0.sender
    }

    public fun accept_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_group<T0>(arg0, arg1);
        let v1 = grant_signers_pending_by<T0>(arg0, v0);
        let v2 = if (v1 == @0x0) {
            true
        } else if (0x1::vector::contains<address>(&arg0.grant_signers, &v1)) {
            true
        } else {
            is_active_owner<T0>(arg0, v1) && pen_ok(arg1, v1, 1)
        };
        assert!(v2, 24);
        assert!(0x2::clock::timestamp_ms(arg2) >= grant_signers_pending_ready<T0>(arg0, v0), 50);
        let (v3, _) = grant_signers_pending_take<T0>(arg0, v0);
        assert!(v3, 37);
        assert!(!0x1::vector::contains<address>(&arg0.grant_signers, &v0), 30);
        0x1::vector::push_back<address>(&mut arg0.grant_signers, v0);
        let v5 = VaultGrantSignersSet{
            vault         : 0x2::object::uid_to_address(&arg0.id),
            who           : v0,
            added         : true,
            sender        : v0,
            grant_signers : arg0.grant_signers,
        };
        0x2::event::emit<VaultGrantSignersSet>(v5);
    }

    fun active_owner_weight<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x2::vec_map::keys<address, Signer>(&arg0.signers);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0)) {
            let v3 = 0x2::vec_map::get<address, Signer>(&arg0.signers, 0x1::vector::borrow<address>(&v0, v2));
            if (v3.signer_state == 0) {
                v1 = v1 + v3.weight;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun activity_score(arg0: &Actor) : u64 {
        arg0.activity_score
    }

    public fun actor_type(arg0: &Actor) : &0x1::string::String {
        &arg0.actor_type
    }

    public fun add_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.grant_signers, &v0), 32);
        assert!(arg1 != @0x0, 29);
        assert!(!0x1::vector::contains<address>(&arg0.grant_signers, &arg1), 30);
        assert!(grant_signers_pending_by<T0>(arg0, arg1) == @0x0, 30);
        let v1 = grant_signers_pending<T0>(arg0);
        assert!(0x1::vector::length<address>(&v1) < 8, 38);
        let v2 = if (may_skip<T0>(arg0, v0)) {
            0x2::clock::timestamp_ms(arg2)
        } else {
            0x2::clock::timestamp_ms(arg2) + arg0.wait_ms
        };
        grant_signers_pending_push<T0>(arg0, arg1, v0, v2);
        let v3 = VaultGrantSignerProposed{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            who    : arg1,
            sender : v0,
        };
        0x2::event::emit<VaultGrantSignerProposed>(v3);
    }

    public fun add_signer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert_group<T0>(arg0, arg1);
        assert_owner<T0>(arg0, v0);
        assert_pause_rule<T0>(arg0, 1);
        assert!(quorum_of<T0>(arg0, 1, arg2, arg3) <= weight_of<T0>(arg0, v0), 27);
        assert_pen_in(arg1, v0, 1);
        if (own_key(arg1, arg2)) {
            assert!(is_member(arg1, v0, 3), 44);
        };
        assert_pen_in(arg1, arg2, arg3);
        assert!(may_skip<T0>(arg0, v0), 49);
        do_add_signer<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun adds_reader<T0>(arg0: &Vault<T0>, arg1: &vector<address>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            if (!0x1::vector::contains<address>(&arg0.readers, 0x1::vector::borrow<address>(arg1, v0))) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun admitted(arg0: &Group, arg1: address, arg2: u64) : bool {
        if (own_key(arg0, arg1)) {
            return arg2 > 0
        };
        let v0 = if (arg2 > 0) {
            3
        } else {
            0
        };
        is_member(arg0, arg1, v0)
    }

    public fun affiliate_program_owner(arg0: &AffiliateProgram) : &0x1::string::String {
        &arg0.owner
    }

    public fun affiliate_ref(arg0: &Referral) : &0x1::string::String {
        &arg0.affiliate_ref
    }

    public fun agent_ref(arg0: &SpendCeiling) : &0x1::string::String {
        &arg0.agent_ref
    }

    public fun aid(arg0: &Actor) : &0x1::string::String {
        &arg0.aid
    }

    fun another_active_owner<T0>(arg0: &Vault<T0>, arg1: address) : address {
        let v0 = 0x2::vec_map::keys<address, Signer>(&arg0.signers);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            let v2 = *0x1::vector::borrow<address>(&v0, v1);
            if (v2 != arg1 && is_active_owner<T0>(arg0, v2)) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 28
    }

    fun any_root(arg0: &Group, arg1: &vector<address>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            if (is_member(arg0, *0x1::vector::borrow<address>(arg1, v0), 3)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun apply_readers<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_group<T0>(arg0, arg1);
        let v0 = ReadersWaitKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<ReadersWaitKey>(&arg0.id, v0), 51);
        let v1 = ReadersWaitKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<ReadersWaitKey, ReadersWaiting>(&mut arg0.id, v1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2.ready_at, 50);
        assert!(is_active_owner<T0>(arg0, v2.by) && pen_ok(arg1, v2.by, 1), 24);
        arg0.readers = v2.list;
        let v3 = VaultReadersSet{
            vault   : 0x2::object::uid_to_address(&arg0.id),
            readers : arg0.readers,
        };
        0x2::event::emit<VaultReadersSet>(v3);
    }

    public fun approve<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut Proposal, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_group<T0>(arg0, arg1);
        assert!(arg2.vault == 0x2::object::uid_to_address(&arg0.id), 29);
        assert!(arg2.proposal_state == 0, 26);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2.expires_at, 25);
        assert!(arg2.kind != 4 || arg2.pause_epoch == arg0.pause_epoch, 25);
        assert_owner<T0>(arg0, v0);
        assert_pen<T0>(arg0, arg1, v0);
        let v1 = life_of<T0>(arg0, v0);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg2.approvals, &v0);
        if (v2) {
            assert!(*0x1::vector::borrow<u64>(&arg2.approval_lives, v3) != v1, 26);
            *0x1::vector::borrow_mut<u64>(&mut arg2.approval_lives, v3) = v1;
        } else {
            0x1::vector::push_back<address>(&mut arg2.approvals, v0);
            0x1::vector::push_back<u64>(&mut arg2.approval_lives, v1);
        };
        arg2.approved_weight = approved_weight_of<T0>(arg0, arg1, &arg2.approvals, &arg2.approval_lives);
        let v4 = false;
        if (arg2.approved_weight >= proposal_quorum<T0>(arg0, arg2)) {
            if (proposal_grows<T0>(arg0, arg2) && !paper_voted<T0>(arg0, arg1, arg2)) {
                assert_pause_rule<T0>(arg0, arg2.kind);
                arg2.proposal_state = 2;
                arg2.ready_at = 0x2::clock::timestamp_ms(arg3) + arg0.wait_ms;
                let v5 = ChangeWaiting{
                    vault    : 0x2::object::uid_to_address(&arg0.id),
                    proposal : 0x2::object::uid_to_address(&arg2.id),
                    kind     : arg2.kind,
                    ready_at : arg2.ready_at,
                };
                0x2::event::emit<ChangeWaiting>(v5);
            } else {
                execute<T0>(arg0, arg1, arg2, arg4);
                arg2.proposal_state = 1;
                v4 = true;
            };
        };
        let v6 = VaultApproved{
            vault           : 0x2::object::uid_to_address(&arg0.id),
            proposal        : 0x2::object::uid_to_address(&arg2.id),
            who             : v0,
            approved_weight : arg2.approved_weight,
            executed        : v4,
        };
        0x2::event::emit<VaultApproved>(v6);
    }

    fun approved_weight_of<T0>(arg0: &Vault<T0>, arg1: &Group, arg2: &vector<address>, arg3: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg2)) {
            let v2 = *0x1::vector::borrow<address>(arg2, v1);
            if (votes<T0>(arg0, arg1, v2, *0x1::vector::borrow<u64>(arg3, v1))) {
                v0 = v0 + weight_of<T0>(arg0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun assert_group<T0>(arg0: &Vault<T0>, arg1: &Group) {
        assert!(0x2::object::id<Group>(arg1) == arg0.group_ref, 43);
    }

    fun assert_live_owner(arg0: &Group, arg1: address) {
        assert!(is_member(arg0, arg1, 3), 41);
        assert!(!removal_live(arg0, arg1), 45);
    }

    fun assert_owner<T0>(arg0: &Vault<T0>, arg1: address) {
        assert!(is_active_owner<T0>(arg0, arg1), 24);
    }

    fun assert_owner_in<T0>(arg0: &Vault<T0>, arg1: &Group, arg2: address) {
        assert_group<T0>(arg0, arg1);
        assert_owner<T0>(arg0, arg2);
        assert_pen<T0>(arg0, arg1, arg2);
    }

    fun assert_pause_rule<T0>(arg0: &Vault<T0>, arg1: u8) {
        if (arg1 == 4) {
            assert!(arg0.vault_state == 1, 30);
        } else if (arg1 != 2 && arg1 != 5) {
            assert!(arg0.vault_state == 0, 22);
        };
    }

    fun assert_pen<T0>(arg0: &Vault<T0>, arg1: &Group, arg2: address) {
        assert_pen_in(arg1, arg2, weight_of<T0>(arg0, arg2));
    }

    fun assert_pen_in(arg0: &Group, arg1: address, arg2: u64) {
        if (own_key(arg0, arg1)) {
            assert!(arg2 > 0, 44);
        } else {
            assert!(is_member(arg0, arg1, 0), 40);
            assert!(arg2 == 0 || is_member(arg0, arg1, 3), 41);
        };
        assert!(!removal_live(arg0, arg1), 45);
    }

    public fun bounty(arg0: &Escrow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bounty)
    }

    public fun budget_id(arg0: &AffiliateBudget) : &0x1::string::String {
        &arg0.budget_id
    }

    public fun budget_state(arg0: &AffiliateBudget) : u64 {
        arg0.budget_state
    }

    fun bump_owners_epoch(arg0: &mut Group) {
        let v0 = OwnersEpochKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<OwnersEpochKey>(&arg0.id, v0)) {
            let v1 = OwnersEpochKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<OwnersEpochKey, u64>(&mut arg0.id, v1);
            *v2 = *v2 + 1;
        } else {
            let v3 = OwnersEpochKey{dummy_field: false};
            0x2::dynamic_field::add<OwnersEpochKey, u64>(&mut arg0.id, v3, 1);
        };
    }

    public fun cancel_grant_signers_reset<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner_in<T0>(arg0, arg1, v0);
        let v1 = GrantSignersResetKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v1), 35);
        let v2 = GrantSignersResetKey{dummy_field: false};
        0x2::dynamic_field::remove<GrantSignersResetKey, u64>(&mut arg0.id, v2);
        let v3 = VaultGrantSignersResetCancelled{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            sender : v0,
        };
        0x2::event::emit<VaultGrantSignersResetCancelled>(v3);
    }

    public fun cancel_group_change(arg0: &mut Group, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1 == 1 && v0 == arg2;
        if (!v1) {
            assert_live_owner(arg0, v0);
        };
        let v2 = GroupChangeKey{
            kind : arg1,
            who  : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GroupChangeKey>(&arg0.id, v2), 51);
        let v3 = 0x2::dynamic_field::remove<GroupChangeKey, GroupChange>(&mut arg0.id, v2);
        unindex_change(arg0, v3.by, v2);
        let v4 = GroupChangeCancelled{
            group  : 0x2::object::uid_to_address(&arg0.id),
            kind   : arg1,
            who    : arg2,
            sender : v0,
        };
        0x2::event::emit<GroupChangeCancelled>(v4);
    }

    public fun cancel_owner_removal(arg0: &mut Group, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = RemovalKey{who: arg1};
        assert!(0x2::dynamic_field::exists_<RemovalKey>(&arg0.id, v1), 46);
        let v2 = 0x2::dynamic_field::remove<RemovalKey, Removal>(&mut arg0.id, v1);
        assert!(v0 == arg1 || v0 == v2.by, 41);
        let v3 = OwnerRemovalCancelled{
            group  : 0x2::object::uid_to_address(&arg0.id),
            who    : arg1,
            sender : v0,
        };
        0x2::event::emit<OwnerRemovalCancelled>(v3);
    }

    public fun cancel_readers<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner_in<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
        let v0 = ReadersWaitKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<ReadersWaitKey>(&arg0.id, v0), 51);
        let v1 = ReadersWaitKey{dummy_field: false};
        0x2::dynamic_field::remove<ReadersWaitKey, ReadersWaiting>(&mut arg0.id, v1);
    }

    public fun cancel_rotation<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_group<T0>(arg0, arg1);
        if (v0 != arg2) {
            assert_owner_in<T0>(arg0, arg1, v0);
        };
        let v1 = RotationKey{from: arg2};
        assert!(0x2::dynamic_field::exists_<RotationKey>(&arg0.id, v1), 51);
        let v2 = 0x2::dynamic_field::remove<RotationKey, Rotation>(&mut arg0.id, v1);
        assert!(rotated_to(arg1, arg2) != v2.to, 51);
        let v3 = RotationCancelled{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            from   : arg2,
            sender : v0,
        };
        0x2::event::emit<RotationCancelled>(v3);
    }

    public fun cancel_waiting<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut Proposal, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_owner_in<T0>(arg0, arg1, v0);
        assert!(arg2.vault == 0x2::object::uid_to_address(&arg0.id), 29);
        assert!(arg2.proposal_state == 2, 51);
        arg2.proposal_state = 3;
        let v1 = ChangeCancelled{
            vault    : 0x2::object::uid_to_address(&arg0.id),
            proposal : 0x2::object::uid_to_address(&arg2.id),
            sender   : v0,
        };
        0x2::event::emit<ChangeCancelled>(v1);
    }

    public fun cap_id(arg0: &WorkerCap) : &0x1::string::String {
        &arg0.cap_id
    }

    public fun ceiling_id(arg0: &SpendCeiling) : &0x1::string::String {
        &arg0.ceiling_id
    }

    public fun ceiling_state(arg0: &SpendCeiling) : u64 {
        arg0.ceiling_state
    }

    public fun check_spend_ceiling_total_spend(arg0: &SpendCeiling, arg1: u64) : bool {
        if (arg0.ceiling_state != 0) {
            return false
        };
        if (arg1 > arg0.max_per_tx) {
            return false
        };
        if (arg0.max_total > 0 && arg0.total_spend + arg1 > arg0.max_total) {
            return false
        };
        true
    }

    public fun child(arg0: &Contains) : address {
        arg0.child
    }

    fun clear_grant_signers<T0>(arg0: &mut Vault<T0>, arg1: address) {
        arg0.grant_signers = 0x1::vector::empty<address>();
        let v0 = GrantSignersResetKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v0)) {
            let v1 = GrantSignersResetKey{dummy_field: false};
            0x2::dynamic_field::remove<GrantSignersResetKey, u64>(&mut arg0.id, v1);
            let v2 = VaultGrantSignersResetCancelled{
                vault  : 0x2::object::uid_to_address(&arg0.id),
                sender : arg1,
            };
            0x2::event::emit<VaultGrantSignersResetCancelled>(v2);
        };
        clear_grant_signers_pending<T0>(arg0, arg1);
        let v3 = VaultGrantSignersSet{
            vault         : 0x2::object::uid_to_address(&arg0.id),
            who           : @0x0,
            added         : false,
            sender        : arg1,
            grant_signers : arg0.grant_signers,
        };
        0x2::event::emit<VaultGrantSignersSet>(v3);
    }

    fun clear_grant_signers_pending<T0>(arg0: &mut Vault<T0>, arg1: address) {
        let v0 = GrantSignersPendingKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v0)) {
            let v1 = GrantSignersPendingKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<GrantSignersPendingKey, vector<GrantSignersPending>>(&mut arg0.id, v1);
            while (!0x1::vector::is_empty<GrantSignersPending>(v2)) {
                let v3 = 0x1::vector::pop_back<GrantSignersPending>(v2);
                let v4 = VaultGrantSignerWithdrawn{
                    vault  : 0x2::object::uid_to_address(&arg0.id),
                    who    : v3.who,
                    sender : arg1,
                };
                0x2::event::emit<VaultGrantSignerWithdrawn>(v4);
            };
        };
    }

    public fun clear_group_paper(arg0: &mut Group, arg1: &mut 0x2::tx_context::TxContext) {
        assert_live_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.paper = @0x0;
        let v0 = GroupWaitSet{
            group   : 0x2::object::uid_to_address(&arg0.id),
            wait_ms : arg0.wait_ms,
            paper   : @0x0,
        };
        0x2::event::emit<GroupWaitSet>(v0);
    }

    fun clear_owner_acts(arg0: &mut Group, arg1: address) {
        let v0 = 0;
        while (v0 <= 3) {
            let v1 = OwnerActKey{
                act  : 0,
                who  : arg1,
                rung : v0,
            };
            if (0x2::dynamic_field::exists_<OwnerActKey>(&arg0.id, v1)) {
                0x2::dynamic_field::remove<OwnerActKey, address>(&mut arg0.id, v1);
            };
            v0 = v0 + 1;
        };
        let v2 = OwnerActKey{
            act  : 1,
            who  : arg1,
            rung : 0,
        };
        if (0x2::dynamic_field::exists_<OwnerActKey>(&arg0.id, v2)) {
            0x2::dynamic_field::remove<OwnerActKey, address>(&mut arg0.id, v2);
        };
    }

    public fun clear_paper<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner_in<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
        arg0.paper = @0x0;
        let v0 = WaitSet{
            vault   : 0x2::object::uid_to_address(&arg0.id),
            wait_ms : arg0.wait_ms,
            paper   : @0x0,
        };
        0x2::event::emit<WaitSet>(v0);
    }

    public fun commission_bps(arg0: &AffiliateProgram) : u64 {
        arg0.commission_bps
    }

    public fun commission_fixed(arg0: &AffiliateProgram) : u64 {
        arg0.commission_fixed
    }

    public fun commission_model(arg0: &AffiliateProgram) : u64 {
        arg0.commission_model
    }

    public fun confidence(arg0: &Highway) : u64 {
        arg0.confidence
    }

    public fun conversions(arg0: &Referral) : u64 {
        arg0.conversions
    }

    public fun create_actor(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = Actor{
            id             : 0x2::object::new(arg10),
            aid            : arg0,
            name           : arg1,
            actor_type     : arg2,
            owner          : arg3,
            status         : arg4,
            success_rate   : arg5,
            activity_score : arg6,
            sample_count   : arg7,
            balance        : arg8,
            path_id        : arg9,
        };
        let v1 = ActorCreated{actor: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<ActorCreated>(v1);
        0x2::transfer::transfer<Actor>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun create_affiliate_budget(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = AffiliateBudget{
            id             : 0x2::object::new(arg6),
            budget_id      : arg0,
            program_ref    : arg1,
            event_kind     : arg2,
            rate_per_event : arg3,
            total_budget   : arg4,
            spent          : 0,
            velocity_cap   : arg5,
            budget_state   : 0,
        };
        let v1 = AffiliateBudgetCreated{affiliate_budget: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<AffiliateBudgetCreated>(v1);
        0x2::transfer::share_object<AffiliateBudget>(v0);
    }

    public fun create_affiliate_program(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = AffiliateProgram{
            id               : 0x2::object::new(arg6),
            program_id       : arg0,
            owner            : arg1,
            commission_model : arg2,
            commission_bps   : arg3,
            commission_fixed : arg4,
            min_payout       : arg5,
        };
        let v1 = AffiliateProgramCreated{affiliate_program: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<AffiliateProgramCreated>(v1);
        0x2::transfer::share_object<AffiliateProgram>(v0);
    }

    public fun create_contains(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Contains{
            id     : 0x2::object::new(arg2),
            parent : arg0,
            child  : arg1,
        };
        let v1 = ContainsCreated{contains: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<ContainsCreated>(v1);
        0x2::transfer::share_object<Contains>(v0);
    }

    public fun create_escrow(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow{
            id            : 0x2::object::new(arg5),
            poster        : arg0,
            worker        : arg1,
            escrow_id     : arg2,
            bounty        : 0x2::balance::zero<0x2::sui::SUI>(),
            deadline      : arg3,
            escrow_status : arg4,
        };
        let v1 = EscrowCreated{escrow: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<EscrowCreated>(v1);
        0x2::transfer::share_object<Escrow>(v0);
    }

    public fun create_group(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 3600000, 52);
        assert!(arg5 <= 604800000, 49);
        assert!(arg6 != 0x2::tx_context::sender(arg7), 30);
        let v0 = Group{
            id         : 0x2::object::new(arg7),
            gid        : arg0,
            name       : arg1,
            group_type : arg2,
            status     : arg3,
            treasury   : 0x2::balance::zero<0x2::sui::SUI>(),
            fade_rate  : arg4,
            members    : 0x2::table::new<address, Member>(arg7),
            owners     : 0,
            wait_ms    : arg5,
            paper      : arg6,
        };
        let v1 = &mut v0;
        set_row(v1, 0x2::tx_context::sender(arg7), 3, 0);
        let v2 = GroupCreated{group: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<GroupCreated>(v2);
        let v3 = GroupWaitSet{
            group   : 0x2::object::uid_to_address(&v0.id),
            wait_ms : arg5,
            paper   : arg6,
        };
        0x2::event::emit<GroupWaitSet>(v3);
        0x2::transfer::share_object<Group>(v0);
    }

    public fun create_highway(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Highway{
            id                : 0x2::object::new(arg4),
            highway_id        : arg0,
            source_ref        : arg1,
            target_ref        : arg2,
            hardened_strength : 0,
            hardened_at       : 0x2::clock::timestamp_ms(arg3),
            confidence        : 0,
        };
        let v1 = HighwayCreated{highway: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<HighwayCreated>(v1);
        0x2::transfer::freeze_object<Highway>(v0);
    }

    public fun create_path(arg0: &WorkerCap, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Path{
            id          : 0x2::object::new(arg6),
            source      : arg1,
            target      : arg2,
            path_id     : arg3,
            path_type   : arg4,
            strength    : 0,
            resistance  : 0,
            hits        : 0,
            misses      : 0,
            path_status : arg5,
        };
        let v1 = PathCreated{path: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<PathCreated>(v1);
        0x2::transfer::share_object<Path>(v0);
    }

    public fun create_referral(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Referral{
            id               : 0x2::object::new(arg5),
            referral_id      : arg0,
            program_ref      : arg1,
            affiliate_ref    : arg2,
            referrer_address : arg3,
            conversions      : arg4,
            referral_state   : 0,
        };
        let v1 = ReferralCreated{referral: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<ReferralCreated>(v1);
        0x2::transfer::transfer<Referral>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun create_scoped_wallet(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ScopedWallet{
            id           : 0x2::object::new(arg3),
            wallet_id    : arg0,
            owner        : arg1,
            purpose      : arg2,
            wallet_state : 0,
        };
        let v1 = ScopedWalletCreated{scoped_wallet: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<ScopedWalletCreated>(v1);
        0x2::transfer::transfer<ScopedWallet>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_signal_obj(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = SignalObj{
            id        : 0x2::object::new(arg6),
            signal_id : arg0,
            receiver  : arg1,
            task_name : arg2,
            sender    : arg3,
            status    : arg4,
            timestamp : arg5,
        };
        let v1 = SignalObjCreated{signal_obj: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<SignalObjCreated>(v1);
        0x2::transfer::transfer<SignalObj>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun create_spawns(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Spawns{
            id     : 0x2::object::new(arg2),
            parent : arg0,
            child  : arg1,
        };
        let v1 = SpawnsCreated{spawns: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<SpawnsCreated>(v1);
        0x2::transfer::share_object<Spawns>(v0);
    }

    public fun create_spend_ceiling(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SpendCeiling{
            id            : 0x2::object::new(arg5),
            ceiling_id    : arg0,
            owner         : arg1,
            agent_ref     : arg2,
            max_per_tx    : arg3,
            max_total     : arg4,
            total_spend   : 0,
            ceiling_state : 0,
        };
        let v1 = SpendCeilingCreated{spend_ceiling: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<SpendCeilingCreated>(v1);
        0x2::transfer::share_object<SpendCeiling>(v0);
    }

    public fun create_vault<T0>(arg0: &Group, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: vector<address>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 && arg5 > 0, 29);
        assert!(arg5 >= arg4, 27);
        assert!(arg2 != @0x0, 29);
        assert!(is_member(arg0, 0x2::tx_context::sender(arg13), 0), 40);
        assert_pen_in(arg0, arg2, 1);
        assert!(is_member(arg0, 0x2::tx_context::sender(arg13), 2), 41);
        assert!(arg6 >= 3600000, 52);
        assert!(arg6 <= 604800000, 49);
        assert!(arg7 != arg2, 30);
        assert!(arg7 == @0x0 || 0x2::tx_context::sender(arg13) == arg2, 24);
        let v0 = 0x1::vector::length<address>(&arg8);
        assert!(v0 <= 8, 38);
        let v1 = if (0x1::vector::length<u64>(&arg9) == v0) {
            if (0x1::vector::length<u64>(&arg10) == v0) {
                if (0x1::vector::length<u64>(&arg11) == v0) {
                    0x1::vector::length<u64>(&arg12) == v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 29);
        assert!(v0 == 0 || 0x2::tx_context::sender(arg13) == arg2, 24);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg8, v2);
            if (own_key(arg0, v3)) {
                assert!(is_member(arg0, 0x2::tx_context::sender(arg13), 3), 44);
            };
            assert_pen_in(arg0, v3, *0x1::vector::borrow<u64>(&arg9, v2));
            v2 = v2 + 1;
        };
        let v4 = Vault<T0>{
            id                 : 0x2::object::new(arg13),
            vault_id           : arg1,
            owner              : arg2,
            line               : arg3,
            quorum_move        : arg4,
            quorum_signers     : arg5,
            balance            : 0x2::balance::zero<T0>(),
            vault_state        : 0,
            owner_spent        : 0,
            owner_period_start : 0,
            grant_signers      : 0x1::vector::empty<address>(),
            readers            : 0x1::vector::empty<address>(),
            sealed_hash        : 0x1::vector::empty<u8>(),
            group_ref          : 0x2::object::id<Group>(arg0),
            signers            : 0x2::vec_map::empty<address, Signer>(),
            pause_epoch        : 0,
            wait_ms            : arg6,
            paper              : arg7,
        };
        let v5 = Signer{
            weight         : 1,
            max_per_tx     : 0,
            max_per_period : 0,
            spent          : 0,
            period_start   : 0,
            signer_state   : 0,
            max_lifetime   : 0,
            lifetime_spent : 0,
            life           : 0,
        };
        0x2::vec_map::insert<address, Signer>(&mut v4.signers, arg2, v5);
        let v6 = VaultCreated{
            vault          : 0x2::object::uid_to_address(&v4.id),
            coin           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner          : v4.owner,
            line           : v4.line,
            quorum_move    : v4.quorum_move,
            quorum_signers : v4.quorum_signers,
        };
        0x2::event::emit<VaultCreated>(v6);
        let v7 = WaitSet{
            vault   : 0x2::object::uid_to_address(&v4.id),
            wait_ms : arg6,
            paper   : arg7,
        };
        0x2::event::emit<WaitSet>(v7);
        let v8 = 0;
        while (v8 < v0) {
            let v9 = &mut v4;
            do_add_signer<T0>(v9, *0x1::vector::borrow<address>(&arg8, v8), *0x1::vector::borrow<u64>(&arg9, v8), *0x1::vector::borrow<u64>(&arg10, v8), *0x1::vector::borrow<u64>(&arg11, v8), *0x1::vector::borrow<u64>(&arg12, v8));
            v8 = v8 + 1;
        };
        0x2::transfer::share_object<Vault<T0>>(v4);
    }

    public fun deadline(arg0: &Escrow) : u64 {
        arg0.deadline
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.vault_state == 0, 22);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = VaultDeposited{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            who    : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<VaultDeposited>(v0);
    }

    fun do_add_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg1 != @0x0, 29);
        assert!(arg2 <= 1, 29);
        let v0 = 0;
        let v1 = 0;
        if (0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1)) {
            assert!(0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).signer_state == 2, 30);
            v0 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).life + 1;
            v1 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).lifetime_spent;
            let (_, _) = 0x2::vec_map::remove<address, Signer>(&mut arg0.signers, &arg1);
        };
        let v4 = Signer{
            weight         : arg2,
            max_per_tx     : arg3,
            max_per_period : arg4,
            spent          : 0,
            period_start   : 0,
            signer_state   : 0,
            max_lifetime   : arg5,
            lifetime_spent : v1,
            life           : v0,
        };
        0x2::vec_map::insert<address, Signer>(&mut arg0.signers, arg1, v4);
        emit_signer<T0>(arg0, arg1);
        emit_lifetime<T0>(arg0, arg1);
    }

    fun do_group_rotate(arg0: &mut Group, arg1: address, arg2: address) {
        let v0 = 0x2::table::borrow<address, Member>(&arg0.members, arg1).rung;
        set_row(arg0, arg1, v0, 2);
        set_row(arg0, arg2, v0, 0);
        let v1 = RotatedKey{from: arg1};
        0x2::dynamic_field::add<RotatedKey, address>(&mut arg0.id, v1, arg2);
        let v2 = MemberRotated{
            group : 0x2::object::uid_to_address(&arg0.id),
            from  : arg1,
            to    : arg2,
        };
        0x2::event::emit<MemberRotated>(v2);
    }

    fun do_remove_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        let v0 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &arg1);
        assert!(v0.signer_state != 2, 20);
        if (v0.signer_state == 0 && v0.weight > 0) {
            assert!(active_owner_weight<T0>(arg0) > v0.weight, 28);
        };
        v0.signer_state = 2;
        v0.max_per_tx = 0;
        v0.max_per_period = 0;
        v0.max_lifetime = 0;
        if (v0.weight > 0) {
            clear_grant_signers<T0>(arg0, 0x2::tx_context::sender(arg2));
        };
        if (arg1 == arg0.owner) {
            let v1 = another_active_owner<T0>(arg0, arg1);
            arg0.owner = v1;
            let v2 = VaultOwnerTransferred{
                vault          : 0x2::object::uid_to_address(&arg0.id),
                previous_owner : arg1,
                new_owner      : v1,
            };
            0x2::event::emit<VaultOwnerTransferred>(v2);
        };
        emit_signer<T0>(arg0, arg1);
    }

    fun do_rotate<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: address) {
        let v0 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1);
        let v1 = v0.life + 1;
        let v2 = v1;
        if (0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg2)) {
            let v3 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2).life + 1;
            if (v3 > v1) {
                v2 = v3;
            };
            let (_, _) = 0x2::vec_map::remove<address, Signer>(&mut arg0.signers, &arg2);
        };
        let v6 = Signer{
            weight         : v0.weight,
            max_per_tx     : v0.max_per_tx,
            max_per_period : v0.max_per_period,
            spent          : v0.spent,
            period_start   : v0.period_start,
            signer_state   : v0.signer_state,
            max_lifetime   : v0.max_lifetime,
            lifetime_spent : v0.lifetime_spent,
            life           : v2,
        };
        0x2::vec_map::insert<address, Signer>(&mut arg0.signers, arg2, v6);
        let v7 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &arg1);
        v7.signer_state = 2;
        v7.max_per_tx = 0;
        v7.max_per_period = 0;
        if (arg0.owner == arg1) {
            arg0.owner = arg2;
            let v8 = VaultOwnerTransferred{
                vault          : 0x2::object::uid_to_address(&arg0.id),
                previous_owner : arg1,
                new_owner      : arg2,
            };
            0x2::event::emit<VaultOwnerTransferred>(v8);
        };
        let (v9, v10) = 0x1::vector::index_of<address>(&arg0.grant_signers, &arg1);
        if (v9) {
            0x1::vector::remove<address>(&mut arg0.grant_signers, v10);
            grant_signers_pending_drop_by<T0>(arg0, arg1, arg1);
            let v11 = VaultGrantSignersSet{
                vault         : 0x2::object::uid_to_address(&arg0.id),
                who           : arg1,
                added         : false,
                sender        : arg1,
                grant_signers : arg0.grant_signers,
            };
            0x2::event::emit<VaultGrantSignersSet>(v11);
        };
        let (v12, _) = grant_signers_pending_take<T0>(arg0, arg1);
        if (v12) {
            let v14 = VaultGrantSignerWithdrawn{
                vault  : 0x2::object::uid_to_address(&arg0.id),
                who    : arg1,
                sender : arg1,
            };
            0x2::event::emit<VaultGrantSignerWithdrawn>(v14);
        };
        let (v15, v16) = 0x1::vector::index_of<address>(&arg0.readers, &arg1);
        if (v15) {
            if (0x1::vector::contains<address>(&arg0.readers, &arg2)) {
                0x1::vector::remove<address>(&mut arg0.readers, v16);
            } else {
                *0x1::vector::borrow_mut<address>(&mut arg0.readers, v16) = arg2;
            };
            let v17 = VaultReadersSet{
                vault   : 0x2::object::uid_to_address(&arg0.id),
                readers : arg0.readers,
            };
            0x2::event::emit<VaultReadersSet>(v17);
        };
        emit_signer<T0>(arg0, arg2);
        emit_signer<T0>(arg0, arg1);
    }

    fun do_set_ceiling<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        let v0 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &arg1);
        assert!(v0.signer_state != 2, 20);
        let v1 = if (arg2 > v0.max_per_tx) {
            true
        } else if (arg3 > v0.max_per_period) {
            true
        } else {
            arg4 > v0.max_lifetime
        };
        if (v1) {
            assert!(!(arg0.vault_state != 0), 22);
        };
        v0.max_lifetime = arg4;
        let v2 = arg2 == 0 || arg3 == 0;
        let v3 = if (v2) {
            if (v0.signer_state == 0) {
                v0.weight > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            assert!(active_owner_weight<T0>(arg0) > v0.weight, 28);
        };
        if (!v2 && v0.signer_state == 1) {
            v0.life = v0.life + 1;
        };
        v0.max_per_tx = arg2;
        v0.max_per_period = arg3;
        let v4 = if (v2) {
            1
        } else {
            0
        };
        v0.signer_state = v4;
        emit_signer<T0>(arg0, arg1);
        emit_lifetime<T0>(arg0, arg1);
    }

    fun do_set_group_wait(arg0: &mut Group, arg1: u64) {
        assert!(arg1 >= 3600000, 52);
        assert!(arg1 <= 604800000, 49);
        arg0.wait_ms = arg1;
        let v0 = GroupWaitSet{
            group   : 0x2::object::uid_to_address(&arg0.id),
            wait_ms : arg1,
            paper   : arg0.paper,
        };
        0x2::event::emit<GroupWaitSet>(v0);
    }

    fun do_set_line<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg2 > 0 && arg3 > 0, 29);
        assert!(arg3 >= arg2, 27);
        arg0.line = arg1;
        arg0.quorum_move = arg2;
        arg0.quorum_signers = arg3;
        let v0 = VaultLineSet{
            vault          : 0x2::object::uid_to_address(&arg0.id),
            line           : arg1,
            quorum_move    : arg2,
            quorum_signers : arg3,
        };
        0x2::event::emit<VaultLineSet>(v0);
    }

    fun do_set_paper<T0>(arg0: &mut Vault<T0>, arg1: address) {
        assert!(arg1 != arg0.owner, 30);
        arg0.paper = arg1;
        let v0 = WaitSet{
            vault   : 0x2::object::uid_to_address(&arg0.id),
            wait_ms : arg0.wait_ms,
            paper   : arg1,
        };
        0x2::event::emit<WaitSet>(v0);
    }

    fun do_set_wait<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        assert!(arg1 >= 3600000, 52);
        assert!(arg1 <= 604800000, 49);
        arg0.wait_ms = arg1;
        let v0 = WaitSet{
            vault   : 0x2::object::uid_to_address(&arg0.id),
            wait_ms : arg1,
            paper   : arg0.paper,
        };
        0x2::event::emit<WaitSet>(v0);
    }

    fun drop_changes_by(arg0: &mut Group, arg1: address) {
        let v0 = ChangesByKey{by: arg1};
        if (!0x2::dynamic_field::exists_<ChangesByKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::remove<ChangesByKey, vector<GroupChangeKey>>(&mut arg0.id, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<GroupChangeKey>(&v1)) {
            let v3 = *0x1::vector::borrow<GroupChangeKey>(&v1, v2);
            if (0x2::dynamic_field::exists_<GroupChangeKey>(&arg0.id, v3) && 0x2::dynamic_field::borrow<GroupChangeKey, GroupChange>(&arg0.id, v3).by == arg1) {
                0x2::dynamic_field::remove<GroupChangeKey, GroupChange>(&mut arg0.id, v3);
                let v4 = GroupChangeCancelled{
                    group  : 0x2::object::uid_to_address(&arg0.id),
                    kind   : v3.kind,
                    who    : v3.who,
                    sender : @0x0,
                };
                0x2::event::emit<GroupChangeCancelled>(v4);
            };
            v2 = v2 + 1;
        };
    }

    fun ed25519_address(arg0: &vector<u8>) : address {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    fun emit_lifetime<T0>(arg0: &Vault<T0>, arg1: address) {
        let v0 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1);
        let v1 = SignerLifetimeSet{
            vault          : 0x2::object::uid_to_address(&arg0.id),
            who            : arg1,
            max_lifetime   : v0.max_lifetime,
            lifetime_spent : v0.lifetime_spent,
        };
        0x2::event::emit<SignerLifetimeSet>(v1);
    }

    fun emit_signer<T0>(arg0: &Vault<T0>, arg1: address) {
        let v0 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1);
        let v1 = VaultSignerSet{
            vault          : 0x2::object::uid_to_address(&arg0.id),
            who            : arg1,
            weight         : v0.weight,
            max_per_tx     : v0.max_per_tx,
            max_per_period : v0.max_per_period,
            signer_state   : v0.signer_state,
            life           : v0.life,
        };
        0x2::event::emit<VaultSignerSet>(v1);
    }

    public fun escrow_id(arg0: &Escrow) : &0x1::string::String {
        &arg0.escrow_id
    }

    public fun escrow_status(arg0: &Escrow) : &0x1::string::String {
        &arg0.escrow_status
    }

    public fun event_kind(arg0: &AffiliateBudget) : &0x1::string::String {
        &arg0.event_kind
    }

    fun execute<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &Proposal, arg3: &mut 0x2::tx_context::TxContext) {
        assert_pause_rule<T0>(arg0, arg2.kind);
        if (arg2.kind == 0) {
            assert!(arg2.amount > 0, 29);
            let v0 = live_approvers<T0>(arg0, arg1, &arg2.approvals, &arg2.approval_lives);
            pay_out<T0>(arg0, arg2.amount, arg2.to, arg3);
            let v1 = VaultWithdrawn{
                vault     : 0x2::object::uid_to_address(&arg0.id),
                who       : 0x2::tx_context::sender(arg3),
                amount    : arg2.amount,
                to        : arg2.to,
                approvers : v0,
            };
            0x2::event::emit<VaultWithdrawn>(v1);
        } else if (arg2.kind == 1) {
            assert_pen_in(arg1, arg2.to, arg2.weight);
            if (own_key(arg1, arg2.to)) {
                let v2 = live_approvers<T0>(arg0, arg1, &arg2.approvals, &arg2.approval_lives);
                assert!(any_root(arg1, &v2), 44);
            };
            do_add_signer<T0>(arg0, arg2.to, arg2.weight, arg2.max_per_tx, arg2.max_per_period, arg2.max_lifetime);
        } else if (arg2.kind == 2) {
            do_remove_signer<T0>(arg0, arg2.to, arg3);
        } else if (arg2.kind == 3) {
            do_set_line<T0>(arg0, arg2.line, arg2.quorum_move, arg2.quorum_signers);
        } else if (arg2.kind == 5) {
            do_set_ceiling<T0>(arg0, arg2.to, arg2.max_per_tx, arg2.max_per_period, arg2.max_lifetime);
        } else if (arg2.kind == 6) {
            do_set_wait<T0>(arg0, arg2.amount);
        } else if (arg2.kind == 7) {
            do_set_paper<T0>(arg0, arg2.to);
        } else {
            arg0.vault_state = 0;
            let v3 = VaultPaused{
                vault  : 0x2::object::uid_to_address(&arg0.id),
                paused : false,
            };
            0x2::event::emit<VaultPaused>(v3);
        };
    }

    public fun execute_grant_signers_reset<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_owner_in<T0>(arg0, arg1, v0);
        let v1 = GrantSignersResetKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v1), 35);
        let v2 = GrantSignersResetKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg2) >= *0x2::dynamic_field::borrow<GrantSignersResetKey, u64>(&arg0.id, v2), 36);
        clear_grant_signers<T0>(arg0, v0);
    }

    public fun execute_owner_removal(arg0: &mut Group, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = RemovalKey{who: arg1};
        assert!(0x2::dynamic_field::exists_<RemovalKey>(&arg0.id, v0), 46);
        let v1 = 0x2::dynamic_field::remove<RemovalKey, Removal>(&mut arg0.id, v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.ready_at, 47);
        assert!(arg0.owners > 1, 28);
        assert!(v1.epoch == owners_epoch(arg0), 46);
        assert!(is_member(arg0, arg1, 3) && is_member(arg0, v1.by, 3), 46);
        assert!(arg0.owners == 2, 27);
        set_row(arg0, arg1, 3, 2);
    }

    public fun execute_ready<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut Proposal, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_group<T0>(arg0, arg1);
        assert!(arg2.vault == 0x2::object::uid_to_address(&arg0.id), 29);
        assert!(arg2.proposal_state == 2, 51);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.ready_at, 50);
        assert!(arg2.kind != 4 || arg2.pause_epoch == arg0.pause_epoch, 25);
        arg2.approved_weight = approved_weight_of<T0>(arg0, arg1, &arg2.approvals, &arg2.approval_lives);
        assert!(arg2.approved_weight >= proposal_quorum<T0>(arg0, arg2), 27);
        execute<T0>(arg0, arg1, arg2, arg4);
        arg2.proposal_state = 1;
        let v0 = ChangeLanded{
            vault    : 0x2::object::uid_to_address(&arg0.id),
            proposal : 0x2::object::uid_to_address(&arg2.id),
            kind     : arg2.kind,
        };
        0x2::event::emit<ChangeLanded>(v0);
    }

    public fun fade_path(arg0: &mut Path, arg1: &WorkerCap, arg2: &Group) {
        arg0.strength = arg0.strength * (10000 - arg2.fade_rate) / 10000;
        let v0 = Faded{
            path            : 0x2::object::uid_to_address(&arg0.id),
            strength_before : arg0.strength,
            strength_after  : arg0.strength,
        };
        0x2::event::emit<Faded>(v0);
    }

    public fun fade_rate(arg0: &Group) : u64 {
        arg0.fade_rate
    }

    public fun finish_group_change(arg0: &mut Group, arg1: u8, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = GroupChangeKey{
            kind : arg1,
            who  : arg2,
        };
        assert!(0x2::dynamic_field::exists_<GroupChangeKey>(&arg0.id, v0), 51);
        let v1 = 0x2::dynamic_field::remove<GroupChangeKey, GroupChange>(&mut arg0.id, v0);
        unindex_change(arg0, v1.by, v0);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.ready_at, 50);
        assert!(!removal_live(arg0, v1.by), 45);
        if (arg1 == 2 || arg1 == 3) {
            assert!(is_member(arg0, v1.by, 3), 41);
        };
        if (arg1 == 0) {
            let v2 = rung_of(arg0, arg2);
            assert!(v1.value > v2, 30);
            if (v1.value == 3 || v2 == 3) {
                assert!(rung_of(arg0, v1.by) == 3, 41);
            } else {
                assert!(rung_of(arg0, v1.by) > v1.value, 41);
            };
            set_row(arg0, arg2, v1.value, 0);
        } else if (arg1 == 1) {
            assert!(!is_member(arg0, v1.to, 0), 30);
            assert!(rung_of(arg0, arg2) != 3 || arg0.owners < 2, 27);
            do_group_rotate(arg0, arg2, v1.to);
        } else if (arg1 == 2) {
            do_set_group_wait(arg0, v1.value);
        } else {
            arg0.paper = v1.to;
            let v3 = GroupWaitSet{
                group   : 0x2::object::uid_to_address(&arg0.id),
                wait_ms : arg0.wait_ms,
                paper   : v1.to,
            };
            0x2::event::emit<GroupWaitSet>(v3);
        };
        let v4 = GroupChangeLanded{
            group : 0x2::object::uid_to_address(&arg0.id),
            kind  : arg1,
            who   : arg2,
        };
        0x2::event::emit<GroupChangeLanded>(v4);
    }

    public fun finish_rotation<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_group<T0>(arg0, arg1);
        let v0 = RotationKey{from: arg2};
        assert!(0x2::dynamic_field::exists_<RotationKey>(&arg0.id, v0), 51);
        let v1 = 0x2::dynamic_field::remove<RotationKey, Rotation>(&mut arg0.id, v0);
        assert!(rotated_to(arg1, arg2) == v1.to, 50);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg2) && 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2).signer_state != 2, 20);
        assert!(arg0.vault_state == 0, 22);
        assert!(!0x2::vec_map::contains<address, Signer>(&arg0.signers, &v1.to) || 0x2::vec_map::get<address, Signer>(&arg0.signers, &v1.to).signer_state == 2, 30);
        let v2 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2);
        assert_pen_in(arg1, v1.to, v2.weight);
        assert!(v2.weight == 0 || active_owner_weight<T0>(arg0) < 2, 27);
        do_rotate<T0>(arg0, arg2, v1.to);
    }

    public fun follow_path(arg0: &Path, arg1: &WorkerCap) {
        let v0 = Followed{path: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<Followed>(v0);
    }

    public fun frozen(arg0: &Group, arg1: address) : bool {
        removal_live(arg0, arg1)
    }

    public fun gid(arg0: &Group) : &0x1::string::String {
        &arg0.gid
    }

    public fun grant_signers<T0>(arg0: &Vault<T0>) : vector<address> {
        arg0.grant_signers
    }

    public fun grant_signers_contains<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.grant_signers, &arg1)
    }

    public fun grant_signers_pending<T0>(arg0: &Vault<T0>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = GrantSignersPendingKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v1)) {
            let v2 = GrantSignersPendingKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow<GrantSignersPendingKey, vector<GrantSignersPending>>(&arg0.id, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<GrantSignersPending>(v3)) {
                0x1::vector::push_back<address>(&mut v0, 0x1::vector::borrow<GrantSignersPending>(v3, v4).who);
                v4 = v4 + 1;
            };
        };
        v0
    }

    public fun grant_signers_pending_by<T0>(arg0: &Vault<T0>, arg1: address) : address {
        let v0 = GrantSignersPendingKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v0)) {
            let v1 = GrantSignersPendingKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<GrantSignersPendingKey, vector<GrantSignersPending>>(&arg0.id, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<GrantSignersPending>(v2)) {
                let v4 = 0x1::vector::borrow<GrantSignersPending>(v2, v3);
                if (v4.who == arg1) {
                    return v4.by
                };
                v3 = v3 + 1;
            };
        };
        @0x0
    }

    fun grant_signers_pending_drop_by<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: address) {
        let v0 = GrantSignersPendingKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v0)) {
            let v1 = GrantSignersPendingKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<GrantSignersPendingKey, vector<GrantSignersPending>>(&mut arg0.id, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<GrantSignersPending>(v2)) {
                if (0x1::vector::borrow<GrantSignersPending>(v2, v3).by == arg1) {
                    let v4 = 0x1::vector::remove<GrantSignersPending>(v2, v3);
                    let v5 = VaultGrantSignerWithdrawn{
                        vault  : 0x2::object::uid_to_address(&arg0.id),
                        who    : v4.who,
                        sender : arg2,
                    };
                    0x2::event::emit<VaultGrantSignerWithdrawn>(v5);
                    continue
                };
                v3 = v3 + 1;
            };
        };
    }

    fun grant_signers_pending_push<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: address, arg3: u64) {
        let v0 = GrantSignersPendingKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v0)) {
            let v1 = GrantSignersPendingKey{dummy_field: false};
            0x2::dynamic_field::add<GrantSignersPendingKey, vector<GrantSignersPending>>(&mut arg0.id, v1, 0x1::vector::empty<GrantSignersPending>());
        };
        let v2 = GrantSignersPendingKey{dummy_field: false};
        let v3 = GrantSignersPending{
            who      : arg1,
            by       : arg2,
            ready_at : arg3,
        };
        0x1::vector::push_back<GrantSignersPending>(0x2::dynamic_field::borrow_mut<GrantSignersPendingKey, vector<GrantSignersPending>>(&mut arg0.id, v2), v3);
    }

    public fun grant_signers_pending_ready<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        let v0 = GrantSignersPendingKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v0)) {
            let v1 = GrantSignersPendingKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<GrantSignersPendingKey, vector<GrantSignersPending>>(&arg0.id, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<GrantSignersPending>(v2)) {
                let v4 = 0x1::vector::borrow<GrantSignersPending>(v2, v3);
                if (v4.who == arg1) {
                    return v4.ready_at
                };
                v3 = v3 + 1;
            };
        };
        0
    }

    fun grant_signers_pending_take<T0>(arg0: &mut Vault<T0>, arg1: address) : (bool, address) {
        let v0 = GrantSignersPendingKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v0)) {
            return (false, @0x0)
        };
        let v1 = GrantSignersPendingKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<GrantSignersPendingKey, vector<GrantSignersPending>>(&mut arg0.id, v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<GrantSignersPending>(v2)) {
            if (0x1::vector::borrow<GrantSignersPending>(v2, v3).who == arg1) {
                let v4 = 0x1::vector::remove<GrantSignersPending>(v2, v3);
                return (true, v4.by)
            };
            v3 = v3 + 1;
        };
        (false, @0x0)
    }

    public fun grant_signers_reset_ready<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = GrantSignersResetKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v0)) {
            let v2 = GrantSignersResetKey{dummy_field: false};
            *0x2::dynamic_field::borrow<GrantSignersResetKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun group_change_ready(arg0: &Group, arg1: u8, arg2: address) : u64 {
        let v0 = GroupChangeKey{
            kind : arg1,
            who  : arg2,
        };
        if (0x2::dynamic_field::exists_<GroupChangeKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<GroupChangeKey, GroupChange>(&arg0.id, v0).ready_at
        } else {
            0
        }
    }

    public fun group_name(arg0: &Group) : &0x1::string::String {
        &arg0.name
    }

    public fun group_paper(arg0: &Group) : address {
        arg0.paper
    }

    public fun group_ref<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.group_ref
    }

    fun group_skip(arg0: &Group, arg1: address) : bool {
        arg0.paper != @0x0 && arg1 == arg0.paper
    }

    public fun group_status(arg0: &Group) : &0x1::string::String {
        &arg0.status
    }

    public fun group_type(arg0: &Group) : &0x1::string::String {
        &arg0.group_type
    }

    public fun group_wait_ms(arg0: &Group) : u64 {
        arg0.wait_ms
    }

    public fun harden(arg0: &mut Path, arg1: &WorkerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.strength >= 5000, 1);
        assert!(arg0.path_status != 0x1::string::utf8(b"hardened"), 6);
        let v0 = Highway{
            id                : 0x2::object::new(arg6),
            highway_id        : arg2,
            source_ref        : arg3,
            target_ref        : arg4,
            hardened_strength : arg0.strength,
            hardened_at       : 0x2::clock::timestamp_ms(arg5),
            confidence        : 0,
        };
        arg0.path_status = 0x1::string::utf8(b"hardened");
        0x2::transfer::freeze_object<Highway>(v0);
        let v1 = Hardened{
            path     : 0x2::object::uid_to_address(&arg0.id),
            strength : arg0.strength,
        };
        0x2::event::emit<Hardened>(v1);
    }

    public fun hardened_at(arg0: &Highway) : u64 {
        arg0.hardened_at
    }

    public fun hardened_strength(arg0: &Highway) : u64 {
        arg0.hardened_strength
    }

    public fun highway_id(arg0: &Highway) : &0x1::string::String {
        &arg0.highway_id
    }

    public fun hits(arg0: &Path) : u64 {
        arg0.hits
    }

    fun index_change(arg0: &mut Group, arg1: address, arg2: GroupChangeKey) {
        let v0 = ChangesByKey{by: arg1};
        if (!0x2::dynamic_field::exists_<ChangesByKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<ChangesByKey, vector<GroupChangeKey>>(&mut arg0.id, v0, 0x1::vector::empty<GroupChangeKey>());
        };
        let v1 = 0x2::dynamic_field::borrow_mut<ChangesByKey, vector<GroupChangeKey>>(&mut arg0.id, v0);
        if (!0x1::vector::contains<GroupChangeKey>(v1, &arg2)) {
            assert!(0x1::vector::length<GroupChangeKey>(v1) < 8, 38);
            0x1::vector::push_back<GroupChangeKey>(v1, arg2);
        };
    }

    fun init(arg0: SUBSTRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkerCap{
            id     : 0x2::object::new(arg1),
            cap_id : 0x1::string::utf8(b""),
            scope  : 0x1::string::utf8(b""),
        };
        0x2::transfer::transfer<WorkerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun is_active_owner<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        if (!0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1)) {
            return false
        };
        let v0 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1);
        v0.weight > 0 && v0.signer_state == 0
    }

    public fun is_member(arg0: &Group, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, Member>(&arg0.members, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, Member>(&arg0.members, arg1);
        if (v0.member_state != 0) {
            return false
        };
        if (v0.rung >= arg2) {
            return true
        };
        false
    }

    fun is_personal(arg0: &Group) : bool {
        arg0.group_type == 0x1::string::utf8(b"personal")
    }

    public fun is_signer<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1) && 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).signer_state != 2
    }

    public fun leave(arg0: &mut Group, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = rung_of(arg0, v0);
        if (v1 == 3) {
            assert!(arg0.owners > 1, 28);
        };
        set_row(arg0, v0, v1, 2);
    }

    fun life_of<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).life
    }

    public fun line<T0>(arg0: &Vault<T0>) : u64 {
        arg0.line
    }

    fun line_quorum<T0>(arg0: &Vault<T0>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = active_owner_weight<T0>(arg0);
        let v1 = if (arg1 > arg0.line) {
            true
        } else if (arg2 < arg0.quorum_move) {
            true
        } else {
            arg3 < arg0.quorum_signers
        };
        let v2 = arg2 > arg0.quorum_move && arg2 >= v0 || arg3 > arg0.quorum_signers && arg3 >= v0;
        let v3 = if (v1) {
            quorum_for<T0>(arg0, 0)
        } else {
            1
        };
        let v4 = v3;
        if (arg3 < arg0.quorum_signers) {
            let v5 = quorum_for<T0>(arg0, 3);
            if (v5 > v3) {
                v4 = v5;
            };
        };
        if (v2) {
            let v6 = owner_quorum<T0>(arg0, 3);
            if (v6 > v4) {
                v4 = v6;
            };
        };
        v4
    }

    fun live_approvers<T0>(arg0: &Vault<T0>, arg1: &Group, arg2: &vector<address>, arg3: &vector<u64>) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg2)) {
            let v2 = *0x1::vector::borrow<address>(arg2, v1);
            if (votes<T0>(arg0, arg1, v2, *0x1::vector::borrow<u64>(arg3, v1))) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun live_owner_approvals(arg0: &Group, arg1: &vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            if (is_member(arg0, *0x1::vector::borrow<address>(arg1, v1), 3)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun live_signers<T0>(arg0: &Vault<T0>) : vector<address> {
        let v0 = 0x2::vec_map::keys<address, Signer>(&arg0.signers);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0)) {
            let v3 = *0x1::vector::borrow<address>(&v0, v2);
            if (0x2::vec_map::get<address, Signer>(&arg0.signers, &v3).signer_state != 2) {
                0x1::vector::push_back<address>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun mark_path(arg0: &mut Path, arg1: &WorkerCap, arg2: u64) {
        let v0 = if (arg2 > 10000) {
            10000
        } else {
            arg2
        };
        arg0.strength = arg0.strength + v0;
        let v1 = Marked{
            path     : 0x2::object::uid_to_address(&arg0.id),
            amount   : v0,
            strength : arg0.strength,
        };
        0x2::event::emit<Marked>(v1);
    }

    public fun max_per_tx(arg0: &SpendCeiling) : u64 {
        arg0.max_per_tx
    }

    public fun max_total(arg0: &SpendCeiling) : u64 {
        arg0.max_total
    }

    public fun may_sign<T0>(arg0: &Vault<T0>, arg1: address, arg2: u64) : u8 {
        if (!0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1)) {
            return 3
        };
        let v0 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1);
        if (arg0.vault_state != 0 || v0.signer_state != 0) {
            return 3
        };
        if (v0.weight == 0 && arg2 <= v0.max_per_tx) {
            return 0
        };
        if (v0.weight == 0) {
            return 3
        };
        if (arg2 <= arg0.line && arg0.owner_spent <= arg0.line - arg2) {
            return 1
        };
        2
    }

    fun may_skip<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        arg0.paper != @0x0 && arg1 == arg0.paper
    }

    public fun member_rung(arg0: &Group, arg1: address) : u64 {
        assert!(0x2::table::contains<address, Member>(&arg0.members, arg1), 40);
        0x2::table::borrow<address, Member>(&arg0.members, arg1).rung
    }

    public fun member_state(arg0: &Group, arg1: address) : u64 {
        assert!(0x2::table::contains<address, Member>(&arg0.members, arg1), 40);
        0x2::table::borrow<address, Member>(&arg0.members, arg1).member_state
    }

    public fun min_payout(arg0: &AffiliateProgram) : u64 {
        arg0.min_payout
    }

    public fun misses(arg0: &Path) : u64 {
        arg0.misses
    }

    public fun name(arg0: &Actor) : &0x1::string::String {
        &arg0.name
    }

    public fun offer_owner<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert_group<T0>(arg0, arg1);
        assert!(!is_personal(arg1), 44);
        assert!(arg0.owner == v0, 24);
        assert_owner<T0>(arg0, v0);
        assert_pen<T0>(arg0, arg1, v0);
        assert!(arg0.vault_state == 0, 22);
        assert!(active_owner_weight<T0>(arg0) < 2, 27);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 42);
        let v1 = if (may_skip<T0>(arg0, v0)) {
            0x2::clock::timestamp_ms(arg6)
        } else {
            0x2::clock::timestamp_ms(arg6) + arg0.wait_ms
        };
        assert!(arg5 > v1, 25);
        let v2 = OwnerOfferKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::exists_<OwnerOfferKey>(&arg0.id, v2);
        if (v3) {
            let v4 = OwnerOfferKey{dummy_field: false};
            0x2::dynamic_field::remove<OwnerOfferKey, OwnerOffer>(&mut arg0.id, v4);
        };
        let v5 = OwnerOfferKey{dummy_field: false};
        let v6 = OwnerOffer{
            pk          : arg2,
            keep_tx     : arg3,
            keep_period : arg4,
            expires_at  : arg5,
            ready_at    : v1,
            by          : v0,
        };
        0x2::dynamic_field::add<OwnerOfferKey, OwnerOffer>(&mut arg0.id, v5, v6);
        let v7 = OwnerOffered{
            vault       : 0x2::object::uid_to_address(&arg0.id),
            seat_pk     : arg2,
            keep_tx     : arg3,
            keep_period : arg4,
            expires_at  : arg5,
            ready_at    : v1,
            by          : v0,
            replaced    : v3,
        };
        0x2::event::emit<OwnerOffered>(v7);
    }

    public fun offer_seat(arg0: &mut Group, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!is_personal(arg0), 44);
        let v1 = rung_of(arg0, v0);
        assert!(v1 >= 2 && arg2 <= v1, 41);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 42);
        if (arg4) {
            assert!(arg2 == 3, 41);
            assert!(arg0.owners < 2, 27);
        };
        let v2 = SeatKey{pk: arg1};
        let v3 = if (0x2::dynamic_field::exists_<SeatKey>(&arg0.id, v2)) {
            let v4 = 0x2::dynamic_field::borrow_mut<SeatKey, Seat>(&mut arg0.id, v2);
            let v5 = if (arg2 == 3) {
                if (v4.rung == 3) {
                    if (v4.expires_at == arg3) {
                        v4.hand_over == arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 38);
            assert!(!0x1::vector::contains<address>(&v4.approvals, &v0), 30);
            0x1::vector::push_back<address>(&mut v4.approvals, v0);
            0x1::vector::length<address>(&v4.approvals)
        } else {
            let v6 = if (arg2 >= 2 && !group_skip(arg0, v0)) {
                0x2::clock::timestamp_ms(arg5) + arg0.wait_ms
            } else {
                0x2::clock::timestamp_ms(arg5)
            };
            let v7 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v7, v0);
            let v8 = Seat{
                rung       : arg2,
                expires_at : arg3,
                hand_over  : arg4,
                by         : v0,
                approvals  : v7,
                ready_at   : v6,
            };
            0x2::dynamic_field::add<SeatKey, Seat>(&mut arg0.id, v2, v8);
            1
        };
        let v9 = SeatOffered{
            group      : 0x2::object::uid_to_address(&arg0.id),
            seat_pk    : v2.pk,
            rung       : arg2,
            by         : v0,
            expires_at : arg3,
            hand_over  : arg4,
            approvals  : v3,
        };
        0x2::event::emit<SeatOffered>(v9);
    }

    fun own_key(arg0: &Group, arg1: address) : bool {
        is_personal(arg0) && !0x2::table::contains<address, Member>(&arg0.members, arg1)
    }

    public fun owner(arg0: &Actor) : &0x1::string::String {
        &arg0.owner
    }

    fun owner_act(arg0: &mut Group, arg1: u8, arg2: address, arg3: u64, arg4: address) : bool {
        if (arg0.owners < 2) {
            return true
        };
        let v0 = OwnerActKey{
            act  : arg1,
            who  : arg2,
            rung : arg3,
        };
        if (0x2::dynamic_field::exists_<OwnerActKey>(&arg0.id, v0)) {
            let v1 = *0x2::dynamic_field::borrow<OwnerActKey, address>(&arg0.id, v0);
            assert!(v1 != arg4, 30);
            if (is_member(arg0, v1, 3)) {
                0x2::dynamic_field::remove<OwnerActKey, address>(&mut arg0.id, v0);
                return true
            };
            *0x2::dynamic_field::borrow_mut<OwnerActKey, address>(&mut arg0.id, v0) = arg4;
        } else {
            0x2::dynamic_field::add<OwnerActKey, address>(&mut arg0.id, v0, arg4);
        };
        let v2 = OwnerActProposed{
            group : 0x2::object::uid_to_address(&arg0.id),
            act   : arg1,
            who   : arg2,
            rung  : arg3,
            by    : arg4,
        };
        0x2::event::emit<OwnerActProposed>(v2);
        false
    }

    public fun owner_count(arg0: &Group) : u64 {
        arg0.owners
    }

    fun owner_need(arg0: &Group) : u64 {
        if (arg0.owners >= 2) {
            2
        } else {
            1
        }
    }

    public fun owner_offered<T0>(arg0: &Vault<T0>) : bool {
        let v0 = OwnerOfferKey{dummy_field: false};
        0x2::dynamic_field::exists_<OwnerOfferKey>(&arg0.id, v0)
    }

    public fun owner_period_start<T0>(arg0: &Vault<T0>) : u64 {
        arg0.owner_period_start
    }

    fun owner_quorum<T0>(arg0: &Vault<T0>, arg1: u8) : u64 {
        let v0 = quorum_for<T0>(arg0, arg1);
        if (v0 < 2 && active_owner_weight<T0>(arg0) >= 2) {
            2
        } else {
            v0
        }
    }

    public fun owner_removal_ready(arg0: &Group, arg1: address) : u64 {
        if (removal_live(arg0, arg1)) {
            let v1 = RemovalKey{who: arg1};
            0x2::dynamic_field::borrow<RemovalKey, Removal>(&arg0.id, v1).ready_at
        } else {
            0
        }
    }

    public fun owner_spent<T0>(arg0: &Vault<T0>) : u64 {
        arg0.owner_spent
    }

    fun owners_epoch(arg0: &Group) : u64 {
        let v0 = OwnersEpochKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<OwnersEpochKey>(&arg0.id, v0)) {
            let v2 = OwnersEpochKey{dummy_field: false};
            *0x2::dynamic_field::borrow<OwnersEpochKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun paper<T0>(arg0: &Vault<T0>) : address {
        arg0.paper
    }

    fun paper_voted<T0>(arg0: &Vault<T0>, arg1: &Group, arg2: &Proposal) : bool {
        if (arg0.paper != @0x0) {
            let v1 = live_approvers<T0>(arg0, arg1, &arg2.approvals, &arg2.approval_lives);
            0x1::vector::contains<address>(&v1, &arg0.paper)
        } else {
            false
        }
    }

    public fun parent(arg0: &Contains) : address {
        arg0.parent
    }

    public fun path_id(arg0: &Actor) : &0x1::string::String {
        &arg0.path_id
    }

    public fun path_path_id(arg0: &Path) : &0x1::string::String {
        &arg0.path_id
    }

    public fun path_status(arg0: &Path) : &0x1::string::String {
        &arg0.path_status
    }

    public fun path_type(arg0: &Path) : &0x1::string::String {
        &arg0.path_type
    }

    public fun pause<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner_in<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
        assert!(arg0.vault_state == 0, 30);
        arg0.vault_state = 1;
        arg0.pause_epoch = arg0.pause_epoch + 1;
        let v0 = VaultPaused{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            paused : true,
        };
        0x2::event::emit<VaultPaused>(v0);
    }

    public fun pause_epoch<T0>(arg0: &Vault<T0>) : u64 {
        arg0.pause_epoch
    }

    fun pay_out<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg3), arg2);
    }

    fun pen_ok(arg0: &Group, arg1: address, arg2: u64) : bool {
        !removal_live(arg0, arg1) && admitted(arg0, arg1, arg2)
    }

    public fun pending_rotation_to(arg0: &Group, arg1: address) : address {
        let v0 = GroupChangeKey{
            kind : 1,
            who  : arg1,
        };
        if (0x2::dynamic_field::exists_<GroupChangeKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<GroupChangeKey, GroupChange>(&arg0.id, v0).to
        } else {
            @0x0
        }
    }

    public fun poster(arg0: &Escrow) : address {
        arg0.poster
    }

    public fun program_id(arg0: &AffiliateProgram) : &0x1::string::String {
        &arg0.program_id
    }

    public fun program_ref(arg0: &AffiliateBudget) : &0x1::string::String {
        &arg0.program_ref
    }

    public fun proposal_amount(arg0: &Proposal) : u64 {
        arg0.amount
    }

    public fun proposal_approved_weight(arg0: &Proposal) : u64 {
        arg0.approved_weight
    }

    public fun proposal_expires_at(arg0: &Proposal) : u64 {
        arg0.expires_at
    }

    fun proposal_grows<T0>(arg0: &Vault<T0>, arg1: &Proposal) : bool {
        if (arg1.kind == 1 || arg1.kind == 4) {
            return true
        };
        if (arg1.kind == 7) {
            return arg1.to != @0x0
        };
        if (arg1.kind == 6) {
            return arg1.amount < arg0.wait_ms
        };
        if (arg1.kind == 3) {
            return if (arg1.line > arg0.line) {
                true
            } else if (arg1.quorum_move < arg0.quorum_move) {
                true
            } else {
                arg1.quorum_signers < arg0.quorum_signers
            }
        };
        if (!0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1.to)) {
            return false
        };
        let v1 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1.to);
        if (arg1.kind == 2) {
            return v1.weight > 0
        };
        if (arg1.kind == 5) {
            return if (arg1.max_per_tx > v1.max_per_tx) {
                true
            } else if (arg1.max_per_period > v1.max_per_period) {
                true
            } else {
                arg1.max_lifetime > v1.max_lifetime
            }
        };
        false
    }

    public fun proposal_kind(arg0: &Proposal) : u8 {
        arg0.kind
    }

    fun proposal_quorum<T0>(arg0: &Vault<T0>, arg1: &Proposal) : u64 {
        if (arg1.kind == 3) {
            line_quorum<T0>(arg0, arg1.line, arg1.quorum_move, arg1.quorum_signers)
        } else {
            quorum_of<T0>(arg0, arg1.kind, arg1.to, arg1.weight)
        }
    }

    public fun proposal_ready_at(arg0: &Proposal) : u64 {
        arg0.ready_at
    }

    public fun proposal_state(arg0: &Proposal) : u64 {
        arg0.proposal_state
    }

    public fun proposal_to(arg0: &Proposal) : address {
        arg0.to
    }

    public fun proposal_vault(arg0: &Proposal) : address {
        arg0.vault
    }

    public fun propose<T0>(arg0: &Vault<T0>, arg1: &Group, arg2: u8, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        assert_group<T0>(arg0, arg1);
        assert!(arg2 <= 7, 29);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &v0), 20);
        assert!(0x2::vec_map::get<address, Signer>(&arg0.signers, &v0).signer_state == 0, 20);
        assert_pen<T0>(arg0, arg1, v0);
        assert_pause_rule<T0>(arg0, arg2);
        if (arg2 == 6) {
            assert!(arg4 >= 3600000, 52);
        };
        let v1 = Proposal{
            id              : 0x2::object::new(arg13),
            vault           : 0x2::object::uid_to_address(&arg0.id),
            kind            : arg2,
            to              : arg3,
            amount          : arg4,
            weight          : arg5,
            max_per_tx      : arg6,
            max_per_period  : arg7,
            max_lifetime    : arg8,
            line            : arg9,
            quorum_move     : arg10,
            quorum_signers  : arg11,
            approvals       : vector[],
            approval_lives  : vector[],
            approved_weight : 0,
            expires_at      : 0x2::clock::timestamp_ms(arg12) + 86400000,
            proposal_state  : 0,
            pause_epoch     : arg0.pause_epoch,
            ready_at        : 0,
        };
        let v2 = VaultProposed{
            vault    : 0x2::object::uid_to_address(&arg0.id),
            proposal : 0x2::object::uid_to_address(&v1.id),
            kind     : arg2,
            who      : v0,
        };
        0x2::event::emit<VaultProposed>(v2);
        0x2::transfer::share_object<Proposal>(v1);
    }

    public fun prune_signer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_group<T0>(arg0, arg1);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg2), 20);
        assert!(0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2).signer_state != 2, 20);
        assert!(!admitted(arg1, arg2, 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2).weight), 30);
        do_remove_signer<T0>(arg0, arg2, arg3);
    }

    public fun purpose(arg0: &ScopedWallet) : &0x1::string::String {
        &arg0.purpose
    }

    fun quorum_for<T0>(arg0: &Vault<T0>, arg1: u8) : u64 {
        let v0 = if (arg1 == 0) {
            arg0.quorum_move
        } else {
            arg0.quorum_signers
        };
        let v1 = active_owner_weight<T0>(arg0);
        let v2 = if (v0 == 0) {
            1
        } else {
            v0
        };
        if (v2 > v1) {
            v1
        } else {
            v2
        }
    }

    public fun quorum_move<T0>(arg0: &Vault<T0>) : u64 {
        arg0.quorum_move
    }

    fun quorum_of<T0>(arg0: &Vault<T0>, arg1: u8, arg2: address, arg3: u64) : u64 {
        if (arg1 == 7 || touches_owner<T0>(arg0, arg1, arg2, arg3)) {
            owner_quorum<T0>(arg0, arg1)
        } else if (arg1 == 2) {
            quorum_for<T0>(arg0, arg1)
        } else {
            quorum_for<T0>(arg0, 0)
        }
    }

    public fun quorum_signers<T0>(arg0: &Vault<T0>) : u64 {
        arg0.quorum_signers
    }

    public fun rate_per_event(arg0: &AffiliateBudget) : u64 {
        arg0.rate_per_event
    }

    public fun readers<T0>(arg0: &Vault<T0>) : vector<address> {
        arg0.readers
    }

    public fun readers_contains<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.readers, &arg1)
    }

    public fun readers_ready<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = ReadersWaitKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ReadersWaitKey>(&arg0.id, v0)) {
            let v2 = ReadersWaitKey{dummy_field: false};
            0x2::dynamic_field::borrow<ReadersWaitKey, ReadersWaiting>(&arg0.id, v2).ready_at
        } else {
            0
        }
    }

    public fun receive_coin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.vault_state == 0, 22);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v0));
        let v1 = VaultDeposited{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            who    : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<VaultDeposited>(v1);
    }

    public fun receiver(arg0: &SignalObj) : &0x1::string::String {
        &arg0.receiver
    }

    fun record_change(arg0: &mut Group, arg1: u8, arg2: address, arg3: u64, arg4: address, arg5: address, arg6: &0x2::clock::Clock) {
        let v0 = GroupChangeKey{
            kind : arg1,
            who  : arg2,
        };
        if (0x2::dynamic_field::exists_<GroupChangeKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::remove<GroupChangeKey, GroupChange>(&mut arg0.id, v0);
            unindex_change(arg0, v1.by, v0);
        };
        let v2 = 0x2::clock::timestamp_ms(arg6) + arg0.wait_ms;
        let v3 = GroupChange{
            value    : arg3,
            to       : arg4,
            by       : arg5,
            ready_at : v2,
        };
        0x2::dynamic_field::add<GroupChangeKey, GroupChange>(&mut arg0.id, v0, v3);
        index_change(arg0, arg5, v0);
        let v4 = GroupChangeWaiting{
            group    : 0x2::object::uid_to_address(&arg0.id),
            kind     : arg1,
            who      : arg2,
            to       : arg4,
            value    : arg3,
            ready_at : v2,
        };
        0x2::event::emit<GroupChangeWaiting>(v4);
    }

    public fun record_spend_ceiling_total_spend(arg0: &mut SpendCeiling, arg1: &WorkerCap, arg2: u64) {
        assert!(arg0.ceiling_state == 0, 11);
        assert!(arg2 <= arg0.max_per_tx, 12);
        if (arg0.max_total > 0) {
            assert!(arg0.total_spend + arg2 <= arg0.max_total, 13);
        };
        arg0.total_spend = arg0.total_spend + arg2;
        let v0 = SpendCeilingTotalSpendRecorded{
            spend_ceiling : 0x2::object::uid_to_address(&arg0.id),
            amount        : arg2,
            total         : arg0.total_spend,
        };
        0x2::event::emit<SpendCeilingTotalSpendRecorded>(v0);
    }

    public fun referral_id(arg0: &Referral) : &0x1::string::String {
        &arg0.referral_id
    }

    public fun referral_program_ref(arg0: &Referral) : &0x1::string::String {
        &arg0.program_ref
    }

    public fun referral_state(arg0: &Referral) : u64 {
        arg0.referral_state
    }

    public fun referrer_address(arg0: &Referral) : &0x1::string::String {
        &arg0.referrer_address
    }

    fun removal_live(arg0: &Group, arg1: address) : bool {
        let v0 = RemovalKey{who: arg1};
        0x2::dynamic_field::exists_<RemovalKey>(&arg0.id, v0) && 0x2::dynamic_field::borrow<RemovalKey, Removal>(&arg0.id, v0).epoch == owners_epoch(arg0)
    }

    public fun remove_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.grant_signers, &v0), 32);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.grant_signers, &arg1);
        assert!(v1, 20);
        0x1::vector::remove<address>(&mut arg0.grant_signers, v2);
        grant_signers_pending_drop_by<T0>(arg0, arg1, v0);
        let v3 = VaultGrantSignersSet{
            vault         : 0x2::object::uid_to_address(&arg0.id),
            who           : arg1,
            added         : false,
            sender        : v0,
            grant_signers : arg0.grant_signers,
        };
        0x2::event::emit<VaultGrantSignersSet>(v3);
    }

    public fun remove_member(arg0: &mut Group, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 != v0, 30);
        let v1 = rung_of(arg0, arg1);
        if (v1 == 3) {
            assert!(rung_of(arg0, v0) == 3, 41);
            assert!(arg0.owners != 2, 27);
            let v2 = owner_act(arg0, 1, arg1, 0, v0);
            if (!v2) {
                return
            };
        } else {
            assert!(rung_of(arg0, v0) > v1, 41);
        };
        set_row(arg0, arg1, v1, 2);
    }

    public fun remove_signer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_owner_in<T0>(arg0, arg1, v0);
        assert!(quorum_of<T0>(arg0, 2, arg2, 0) <= weight_of<T0>(arg0, v0), 27);
        if (0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg2) && 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2).weight > 0) {
            assert!(may_skip<T0>(arg0, v0), 49);
        };
        do_remove_signer<T0>(arg0, arg2, arg3);
    }

    public fun request_grant_signers_reset<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_owner_in<T0>(arg0, arg1, v0);
        let v1 = GrantSignersResetKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v1), 34);
        let v2 = 0x2::clock::timestamp_ms(arg2) + 604800000;
        let v3 = GrantSignersResetKey{dummy_field: false};
        0x2::dynamic_field::add<GrantSignersResetKey, u64>(&mut arg0.id, v3, v2);
        let v4 = VaultGrantSignersResetRequested{
            vault         : 0x2::object::uid_to_address(&arg0.id),
            sender        : v0,
            ready_at      : v2,
            grant_signers : arg0.grant_signers,
        };
        0x2::event::emit<VaultGrantSignersResetRequested>(v4);
    }

    public fun request_owner_removal(arg0: &mut Group, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 != v0, 30);
        assert!(rung_of(arg0, v0) == 3, 41);
        assert!(rung_of(arg0, arg1) == 3, 41);
        assert!(arg0.owners == 2, 27);
        let v1 = RemovalKey{who: arg1};
        assert!(!removal_live(arg0, arg1), 45);
        if (0x2::dynamic_field::exists_<RemovalKey>(&arg0.id, v1)) {
            0x2::dynamic_field::remove<RemovalKey, Removal>(&mut arg0.id, v1);
        };
        let v2 = 0x2::clock::timestamp_ms(arg2) + 604800000;
        let v3 = Removal{
            by       : v0,
            ready_at : v2,
            epoch    : owners_epoch(arg0),
        };
        0x2::dynamic_field::add<RemovalKey, Removal>(&mut arg0.id, v1, v3);
        let v4 = OwnerRemovalRequested{
            group    : 0x2::object::uid_to_address(&arg0.id),
            who      : arg1,
            by       : v0,
            ready_at : v2,
        };
        0x2::event::emit<OwnerRemovalRequested>(v4);
    }

    public fun request_readers<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_owner_in<T0>(arg0, arg1, v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            assert!(v2 != @0x0, 29);
            let (_, v4) = 0x1::vector::index_of<address>(&arg2, &v2);
            assert!(v4 == v1, 30);
            v1 = v1 + 1;
        };
        let v5 = if (may_skip<T0>(arg0, v0)) {
            0x2::clock::timestamp_ms(arg3)
        } else {
            0x2::clock::timestamp_ms(arg3) + arg0.wait_ms
        };
        let v6 = ReadersWaitKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ReadersWaitKey>(&arg0.id, v6)) {
            let v7 = ReadersWaitKey{dummy_field: false};
            0x2::dynamic_field::remove<ReadersWaitKey, ReadersWaiting>(&mut arg0.id, v7);
        };
        let v8 = ReadersWaitKey{dummy_field: false};
        let v9 = ReadersWaiting{
            list     : arg2,
            ready_at : v5,
            by       : v0,
        };
        0x2::dynamic_field::add<ReadersWaitKey, ReadersWaiting>(&mut arg0.id, v8, v9);
    }

    public fun resistance(arg0: &Path) : u64 {
        arg0.resistance
    }

    public fun resume<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner_in<T0>(arg0, arg1, v0);
        assert!(arg0.vault_state == 1, 30);
        assert!(quorum_for<T0>(arg0, 0) <= weight_of<T0>(arg0, v0), 27);
        assert!(may_skip<T0>(arg0, v0), 49);
        arg0.vault_state = 0;
        let v1 = VaultPaused{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            paused : false,
        };
        0x2::event::emit<VaultPaused>(v1);
    }

    public fun revoke_spend_ceiling(arg0: &mut SpendCeiling, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 14);
        arg0.ceiling_state = 1;
        let v0 = SpendCeilingRevoked{spend_ceiling: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<SpendCeilingRevoked>(v0);
    }

    fun roll_owner_period<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        if (arg1 >= arg0.owner_period_start + 86400000) {
            arg0.owner_period_start = arg1;
            arg0.owner_spent = 0;
            let v0 = VaultPeriodRolled{
                vault        : 0x2::object::uid_to_address(&arg0.id),
                who          : @0x0,
                owners       : true,
                period_start : arg1,
            };
            0x2::event::emit<VaultPeriodRolled>(v0);
        };
    }

    public fun rotate(arg0: &mut Group, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 42);
        let v1 = seat_message(b"one:rotate:v1", 0x2::object::uid_to_address(&arg0.id), v0);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &v1), 42);
        let v2 = ed25519_address(&arg1);
        assert!(v2 != v0 && !is_member(arg0, v2, 0), 30);
        assert!(rung_of(arg0, v0) != 3 || arg0.owners < 2, 27);
        if (group_skip(arg0, v0)) {
            do_group_rotate(arg0, v0, v2);
            return
        };
        record_change(arg0, 1, v0, 0, v2, v0, arg3);
    }

    public fun rotate_signer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_group<T0>(arg0, arg1);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &v0), 20);
        assert!(0x2::vec_map::get<address, Signer>(&arg0.signers, &v0).signer_state != 2, 20);
        assert!(!removal_live(arg1, v0), 45);
        assert!(arg0.vault_state == 0, 22);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 42);
        let v1 = seat_message(b"one:rotate:v1", 0x2::object::uid_to_address(&arg0.id), v0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg2, &v1), 42);
        let v2 = ed25519_address(&arg2);
        assert!(v2 != v0, 30);
        assert!(!0x2::vec_map::contains<address, Signer>(&arg0.signers, &v2) || 0x2::vec_map::get<address, Signer>(&arg0.signers, &v2).signer_state == 2, 30);
        let v3 = rotated_to(arg1, v0) == v2;
        assert!(v3 || pending_rotation_to(arg1, v0) == v2, 40);
        assert!(may_skip<T0>(arg0, v0) || group_wait_ms(arg1) >= arg0.wait_ms, 49);
        let v4 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &v0);
        if (v3) {
            assert_pen_in(arg1, v2, v4.weight);
            assert!(v4.weight == 0 || active_owner_weight<T0>(arg0) < 2, 27);
            do_rotate<T0>(arg0, v0, v2);
            return
        };
        assert!(v4.weight == 0 || active_owner_weight<T0>(arg0) < 2, 27);
        let v5 = RotationKey{from: v0};
        if (0x2::dynamic_field::exists_<RotationKey>(&arg0.id, v5)) {
            0x2::dynamic_field::remove<RotationKey, Rotation>(&mut arg0.id, v5);
        };
        let v6 = Rotation{to: v2};
        0x2::dynamic_field::add<RotationKey, Rotation>(&mut arg0.id, v5, v6);
        let v7 = RotationWaiting{
            vault    : 0x2::object::uid_to_address(&arg0.id),
            from     : v0,
            to       : v2,
            ready_at : group_change_ready(arg1, 1, v0),
        };
        0x2::event::emit<RotationWaiting>(v7);
    }

    public fun rotated_to(arg0: &Group, arg1: address) : address {
        let v0 = RotatedKey{from: arg1};
        if (0x2::dynamic_field::exists_<RotatedKey>(&arg0.id, v0)) {
            let v2 = RotatedKey{from: arg1};
            *0x2::dynamic_field::borrow<RotatedKey, address>(&arg0.id, v2)
        } else {
            @0x0
        }
    }

    public fun rotation_pending<T0>(arg0: &Vault<T0>, arg1: address) : address {
        let v0 = RotationKey{from: arg1};
        if (0x2::dynamic_field::exists_<RotationKey>(&arg0.id, v0)) {
            let v2 = RotationKey{from: arg1};
            0x2::dynamic_field::borrow<RotationKey, Rotation>(&arg0.id, v2).to
        } else {
            @0x0
        }
    }

    fun rung_of(arg0: &Group, arg1: address) : u64 {
        assert!(is_member(arg0, arg1, 0), 40);
        0x2::table::borrow<address, Member>(&arg0.members, arg1).rung
    }

    public fun sample_count(arg0: &Actor) : u64 {
        arg0.sample_count
    }

    public fun scope(arg0: &WorkerCap) : &0x1::string::String {
        &arg0.scope
    }

    public fun scoped_wallet_owner(arg0: &ScopedWallet) : &0x1::string::String {
        &arg0.owner
    }

    public fun sealed_hash<T0>(arg0: &Vault<T0>) : vector<u8> {
        arg0.sealed_hash
    }

    fun seat_message(arg0: vector<u8>, arg1: address, arg2: address) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut arg0, 0x1::bcs::to_bytes<address>(&arg2));
        arg0
    }

    public fun seat_offered(arg0: &Group, arg1: vector<u8>) : bool {
        let v0 = SeatKey{pk: arg1};
        0x2::dynamic_field::exists_<SeatKey>(&arg0.id, v0)
    }

    public fun set_ceiling<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert_owner_in<T0>(arg0, arg1, v0);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg2), 20);
        let v1 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2);
        let v2 = if (arg3 > v1.max_per_tx) {
            true
        } else if (arg4 > v1.max_per_period) {
            true
        } else {
            arg5 > v1.max_lifetime
        };
        if (v2 || v1.weight > 0) {
            assert!(quorum_of<T0>(arg0, 5, arg2, 0) <= weight_of<T0>(arg0, v0), 27);
        };
        if (v2) {
            assert!(may_skip<T0>(arg0, v0), 49);
        };
        do_set_ceiling<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun set_first_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_owner_in<T0>(arg0, arg1, v0);
        assert!(0x1::vector::is_empty<address>(&arg0.grant_signers), 33);
        let v1 = grant_signers_pending<T0>(arg0);
        assert!(0x1::vector::is_empty<address>(&v1), 38);
        assert!(arg2 != @0x0, 29);
        let v2 = if (may_skip<T0>(arg0, v0)) {
            0x2::clock::timestamp_ms(arg3)
        } else {
            0x2::clock::timestamp_ms(arg3) + arg0.wait_ms
        };
        grant_signers_pending_push<T0>(arg0, arg2, v0, v2);
        let v3 = VaultGrantSignerProposed{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            who    : arg2,
            sender : v0,
        };
        0x2::event::emit<VaultGrantSignerProposed>(v3);
        let v4 = GrantSignersResetKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v4)) {
            let v5 = GrantSignersResetKey{dummy_field: false};
            0x2::dynamic_field::remove<GrantSignersResetKey, u64>(&mut arg0.id, v5);
            let v6 = VaultGrantSignersResetCancelled{
                vault  : 0x2::object::uid_to_address(&arg0.id),
                sender : v0,
            };
            0x2::event::emit<VaultGrantSignersResetCancelled>(v6);
        };
    }

    public fun set_group_paper(arg0: &mut Group, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_live_owner(arg0, v0);
        assert!(arg1 != v0 && arg1 != @0x0, 30);
        if (group_skip(arg0, v0)) {
            arg0.paper = arg1;
            let v1 = GroupWaitSet{
                group   : 0x2::object::uid_to_address(&arg0.id),
                wait_ms : arg0.wait_ms,
                paper   : arg1,
            };
            0x2::event::emit<GroupWaitSet>(v1);
            return
        };
        record_change(arg0, 3, @0x0, 0, arg1, v0, arg2);
    }

    public fun set_group_wait(arg0: &mut Group, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_live_owner(arg0, v0);
        if (arg1 >= arg0.wait_ms || group_skip(arg0, v0)) {
            do_set_group_wait(arg0, arg1);
            return
        };
        assert!(arg1 >= 3600000, 52);
        assert!(arg1 <= 604800000, 49);
        record_change(arg0, 2, @0x0, arg1, @0x0, v0, arg2);
    }

    public fun set_line<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_owner_in<T0>(arg0, arg1, v0);
        assert_pause_rule<T0>(arg0, 3);
        assert!(line_quorum<T0>(arg0, arg2, arg3, arg4) <= weight_of<T0>(arg0, v0), 27);
        let v1 = if (arg2 > arg0.line) {
            true
        } else if (arg3 < arg0.quorum_move) {
            true
        } else {
            arg4 < arg0.quorum_signers
        };
        if (v1) {
            assert!(may_skip<T0>(arg0, v0), 49);
        };
        do_set_line<T0>(arg0, arg2, arg3, arg4);
    }

    public fun set_readers<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_in<T0>(arg0, arg1, 0x2::tx_context::sender(arg3));
        if (adds_reader<T0>(arg0, &arg2)) {
            assert!(may_skip<T0>(arg0, 0x2::tx_context::sender(arg3)), 49);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            assert!(v1 != @0x0, 29);
            let (_, v3) = 0x1::vector::index_of<address>(&arg2, &v1);
            assert!(v3 == v0, 30);
            v0 = v0 + 1;
        };
        arg0.readers = arg2;
        let v4 = VaultReadersSet{
            vault   : 0x2::object::uid_to_address(&arg0.id),
            readers : arg0.readers,
        };
        0x2::event::emit<VaultReadersSet>(v4);
    }

    fun set_row(arg0: &mut Group, arg1: address, arg2: u64, arg3: u64) {
        let v0 = is_member(arg0, arg1, 3);
        if (0x2::table::contains<address, Member>(&arg0.members, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, Member>(&mut arg0.members, arg1);
            v1.rung = arg2;
            v1.member_state = arg3;
        } else {
            let v2 = Member{
                rung         : arg2,
                member_state : arg3,
            };
            0x2::table::add<address, Member>(&mut arg0.members, arg1, v2);
        };
        let v3 = arg3 == 0 && arg2 >= 3;
        if (v0 && !v3) {
            arg0.owners = arg0.owners - 1;
        };
        if (!v0 && v3) {
            arg0.owners = arg0.owners + 1;
        };
        if (v0 != v3) {
            bump_owners_epoch(arg0);
        };
        if (arg3 != 0 || v0 && !v3) {
            drop_changes_by(arg0, arg1);
        };
        clear_owner_acts(arg0, arg1);
        let v4 = RotatedKey{from: arg1};
        if (0x2::dynamic_field::exists_<RotatedKey>(&arg0.id, v4)) {
            let v5 = RotatedKey{from: arg1};
            0x2::dynamic_field::remove<RotatedKey, address>(&mut arg0.id, v5);
        };
        let v6 = MemberSet{
            group        : 0x2::object::uid_to_address(&arg0.id),
            who          : arg1,
            rung         : arg2,
            member_state : arg3,
            owners       : arg0.owners,
        };
        0x2::event::emit<MemberSet>(v6);
    }

    public fun set_rung(arg0: &mut Group, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = rung_of(arg0, v0);
        let v2 = rung_of(arg0, arg1);
        assert!(arg2 <= 3, 41);
        assert!(arg2 != v2, 30);
        if (v2 == 3 || arg2 == 3) {
            assert!(v1 == 3, 41);
            if (v2 == 3) {
                assert!(arg0.owners > 1, 28);
            };
            let v3 = owner_act(arg0, 0, arg1, arg2, v0);
            if (!v3) {
                return
            };
        } else {
            assert!(v1 > v2 && v1 > arg2, 41);
        };
        if (arg2 > v2 && !group_skip(arg0, v0)) {
            record_change(arg0, 0, arg1, arg2, @0x0, v0, arg3);
            return
        };
        set_row(arg0, arg1, arg2, 0);
    }

    public fun set_sealed_hash<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_in<T0>(arg0, arg1, 0x2::tx_context::sender(arg3));
        assert!(0x1::vector::length<u8>(&arg2) == 32, 31);
        arg0.sealed_hash = arg2;
        let v0 = VaultSealedHashSet{
            vault       : 0x2::object::uid_to_address(&arg0.id),
            sealed_hash : arg0.sealed_hash,
        };
        0x2::event::emit<VaultSealedHashSet>(v0);
    }

    public fun set_wait<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_owner_in<T0>(arg0, arg1, v0);
        if (arg2 < arg0.wait_ms) {
            assert!(may_skip<T0>(arg0, v0), 49);
        };
        do_set_wait<T0>(arg0, arg2);
    }

    public fun signal_id(arg0: &SignalObj) : &0x1::string::String {
        &arg0.signal_id
    }

    public fun signal_obj_status(arg0: &SignalObj) : &0x1::string::String {
        &arg0.status
    }

    public fun signer_count<T0>(arg0: &Vault<T0>) : u64 {
        0x2::vec_map::length<address, Signer>(&arg0.signers)
    }

    public fun signer_life<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).life
    }

    public fun signer_lifetime_spent<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).lifetime_spent
    }

    public fun signer_max_lifetime<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).max_lifetime
    }

    public fun signer_max_per_period<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).max_per_period
    }

    public fun signer_max_per_tx<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).max_per_tx
    }

    public fun signer_period_start<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).period_start
    }

    fun signer_set_is<T0>(arg0: &Vault<T0>, arg1: &vector<address>) : bool {
        let v0 = 0x2::vec_map::keys<address, Signer>(&arg0.signers);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0)) {
            let v3 = 0x1::vector::borrow<address>(&v0, v2);
            if (0x2::vec_map::get<address, Signer>(&arg0.signers, v3).signer_state != 2) {
                if (!0x1::vector::contains<address>(arg1, v3)) {
                    return false
                };
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1 == 0x1::vector::length<address>(arg1)
    }

    public fun signer_spent<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).spent
    }

    public fun signer_state<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).signer_state
    }

    public fun signer_weight<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).weight
    }

    public fun signers_bytes<T0>(arg0: &Vault<T0>) : vector<u8> {
        0x1::bcs::to_bytes<0x2::vec_map::VecMap<address, Signer>>(&arg0.signers)
    }

    public fun source(arg0: &Path) : address {
        arg0.source
    }

    public fun source_ref(arg0: &Highway) : &0x1::string::String {
        &arg0.source_ref
    }

    public fun spawns_child(arg0: &Spawns) : address {
        arg0.child
    }

    public fun spawns_parent(arg0: &Spawns) : address {
        arg0.parent
    }

    public fun spend<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_group<T0>(arg0, arg1);
        assert!(arg0.vault_state == 0, 22);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &v0), 20);
        assert!(arg2 > 0, 29);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &v0);
        assert!(v2.signer_state != 2, 20);
        assert!(v2.signer_state == 0, 22);
        assert_pen<T0>(arg0, arg1, v0);
        assert!(may_sign<T0>(arg0, v0, arg2) == 0, 21);
        let v3 = 0x2::object::uid_to_address(&arg0.id);
        let v4 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &v0);
        if (v1 >= v4.period_start + 86400000) {
            v4.period_start = v1;
            v4.spent = 0;
            let v5 = VaultPeriodRolled{
                vault        : v3,
                who          : v0,
                owners       : false,
                period_start : v1,
            };
            0x2::event::emit<VaultPeriodRolled>(v5);
        };
        assert!(v4.spent + arg2 <= v4.max_per_period, 21);
        assert!(arg2 <= v4.max_lifetime && v4.lifetime_spent <= v4.max_lifetime - arg2, 60);
        v4.lifetime_spent = v4.lifetime_spent + arg2;
        v4.spent = v4.spent + arg2;
        pay_out<T0>(arg0, arg2, arg3, arg5);
        let v6 = VaultSpent{
            vault  : v3,
            who    : v0,
            amount : arg2,
            to     : arg3,
            spent  : v4.spent,
        };
        0x2::event::emit<VaultSpent>(v6);
    }

    public fun spend_ceiling_owner(arg0: &SpendCeiling) : address {
        arg0.owner
    }

    public fun spent(arg0: &AffiliateBudget) : u64 {
        arg0.spent
    }

    public fun status(arg0: &Actor) : &0x1::string::String {
        &arg0.status
    }

    public fun strength(arg0: &Path) : u64 {
        arg0.strength
    }

    public fun success_rate(arg0: &Actor) : u64 {
        arg0.success_rate
    }

    public fun take_owner<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: address, arg7: vector<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert_group<T0>(arg0, arg1);
        let v1 = OwnerOfferKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<OwnerOfferKey>(&arg0.id, v1), 42);
        let v2 = OwnerOfferKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::remove<OwnerOfferKey, OwnerOffer>(&mut arg0.id, v2);
        assert!(v3.pk == arg2, 42);
        assert!(0x2::clock::timestamp_ms(arg8) < v3.expires_at, 25);
        assert!(0x2::clock::timestamp_ms(arg8) >= v3.ready_at, 50);
        let v4 = seat_message(b"one:seat:v1", 0x2::object::uid_to_address(&arg0.id), v0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v3.pk, &v4), 42);
        let v5 = if (v3.keep_tx == arg4) {
            if (v3.keep_period == arg5) {
                v3.by == arg6
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 48);
        let v6 = if (arg0.owner == v3.by) {
            if (is_active_owner<T0>(arg0, v3.by)) {
                is_member(arg1, v3.by, 0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 42);
        assert!(arg0.vault_state == 0, 22);
        assert!(v0 != @0x0, 29);
        assert!(v0 != v3.by, 30);
        assert!(!0x2::vec_map::contains<address, Signer>(&arg0.signers, &v0) || 0x2::vec_map::get<address, Signer>(&arg0.signers, &v0).signer_state == 2, 30);
        assert!(active_owner_weight<T0>(arg0) < 2, 27);
        let v7 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v7, v3.by);
        assert!(arg7 == v7 && signer_set_is<T0>(arg0, &arg7), 48);
        assert_pen_in(arg1, v0, 1);
        if (0x2::vec_map::contains<address, Signer>(&arg0.signers, &v0)) {
            let v8 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &v0);
            assert!(v8.signer_state == 2, 30);
            v8.weight = 1;
            v8.signer_state = 0;
            v8.max_per_tx = 0;
            v8.max_per_period = 0;
            v8.life = v8.life + 1;
        } else {
            let v9 = Signer{
                weight         : 1,
                max_per_tx     : 0,
                max_per_period : 0,
                spent          : 0,
                period_start   : 0,
                signer_state   : 0,
                max_lifetime   : 0,
                lifetime_spent : 0,
                life           : 0,
            };
            0x2::vec_map::insert<address, Signer>(&mut arg0.signers, v0, v9);
        };
        let v10 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &v3.by);
        if (v3.keep_tx == 0 && v3.keep_period == 0) {
            v10.signer_state = 2;
            v10.max_per_tx = 0;
            v10.max_per_period = 0;
        } else {
            v10.weight = 0;
            v10.max_per_tx = v3.keep_tx;
            v10.max_per_period = v3.keep_period;
            v10.max_lifetime = 0;
            let v11 = if (v3.keep_tx == 0 || v3.keep_period == 0) {
                1
            } else {
                0
            };
            v10.signer_state = v11;
            v10.life = v10.life + 1;
        };
        arg0.owner = v0;
        if (arg0.paper != @0x0) {
            arg0.paper = @0x0;
            let v12 = WaitSet{
                vault   : 0x2::object::uid_to_address(&arg0.id),
                wait_ms : arg0.wait_ms,
                paper   : @0x0,
            };
            0x2::event::emit<WaitSet>(v12);
        };
        clear_grant_signers<T0>(arg0, v0);
        emit_signer<T0>(arg0, v0);
        emit_signer<T0>(arg0, v3.by);
        let v13 = VaultOwnerTransferred{
            vault          : 0x2::object::uid_to_address(&arg0.id),
            previous_owner : v3.by,
            new_owner      : v0,
        };
        0x2::event::emit<VaultOwnerTransferred>(v13);
    }

    public fun take_seat(arg0: &mut Group, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!is_personal(arg0), 44);
        let v1 = SeatKey{pk: arg1};
        assert!(0x2::dynamic_field::exists_<SeatKey>(&arg0.id, v1), 42);
        let v2 = 0x2::dynamic_field::remove<SeatKey, Seat>(&mut arg0.id, v1);
        assert!(0x2::clock::timestamp_ms(arg3) < v2.expires_at, 25);
        assert!(0x2::clock::timestamp_ms(arg3) >= v2.ready_at, 50);
        let v3 = seat_message(b"one:seat:v1", 0x2::object::uid_to_address(&arg0.id), v0);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v1.pk, &v3), 42);
        assert!(!is_member(arg0, v0, 0), 30);
        assert!(is_member(arg0, v2.by, 2) && is_member(arg0, v2.by, v2.rung), 42);
        if (v2.rung == 3) {
            assert!(live_owner_approvals(arg0, &v2.approvals) >= owner_need(arg0), 27);
        };
        if (v2.hand_over) {
            assert!(arg0.owners < 2, 27);
        };
        set_row(arg0, v0, v2.rung, 0);
        if (v2.hand_over && is_member(arg0, v2.by, 3)) {
            set_row(arg0, v2.by, 1, 0);
        };
        if (v2.hand_over && arg0.paper != @0x0) {
            arg0.paper = @0x0;
            let v4 = GroupWaitSet{
                group   : 0x2::object::uid_to_address(&arg0.id),
                wait_ms : arg0.wait_ms,
                paper   : @0x0,
            };
            0x2::event::emit<GroupWaitSet>(v4);
        };
        let v5 = SeatTaken{
            group   : 0x2::object::uid_to_address(&arg0.id),
            seat_pk : v1.pk,
            who     : v0,
            rung    : v2.rung,
        };
        0x2::event::emit<SeatTaken>(v5);
    }

    public fun target(arg0: &Path) : address {
        arg0.target
    }

    public fun target_ref(arg0: &Highway) : &0x1::string::String {
        &arg0.target_ref
    }

    public fun task_name(arg0: &SignalObj) : &0x1::string::String {
        &arg0.task_name
    }

    public fun tidy_signer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_group<T0>(arg0, arg1);
        if (!0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg2)) {
            return
        };
        let v0 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2);
        if (v0.signer_state == 2) {
            return
        };
        if (admitted(arg1, arg2, v0.weight)) {
            return
        };
        if (v0.weight > 0 && v0.signer_state == 0) {
            if (active_owner_weight<T0>(arg0) <= v0.weight) {
                return
            };
        };
        do_remove_signer<T0>(arg0, arg2, arg3);
    }

    public fun timestamp(arg0: &SignalObj) : u64 {
        arg0.timestamp
    }

    public fun total_budget(arg0: &AffiliateBudget) : u64 {
        arg0.total_budget
    }

    public fun total_spend(arg0: &SpendCeiling) : u64 {
        arg0.total_spend
    }

    fun touches_owner<T0>(arg0: &Vault<T0>, arg1: u8, arg2: address, arg3: u64) : bool {
        if (arg1 == 1) {
            return arg3 > 0
        };
        if (arg1 != 2 && arg1 != 5) {
            return false
        };
        0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg2) && 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg2).weight > 0
    }

    public fun treasury(arg0: &Group) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun unindex_change(arg0: &mut Group, arg1: address, arg2: GroupChangeKey) {
        let v0 = ChangesByKey{by: arg1};
        if (!0x2::dynamic_field::exists_<ChangesByKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<ChangesByKey, vector<GroupChangeKey>>(&mut arg0.id, v0);
        let (v2, v3) = 0x1::vector::index_of<GroupChangeKey>(v1, &arg2);
        if (v2) {
            0x1::vector::remove<GroupChangeKey>(v1, v3);
        };
    }

    public fun update_spend_ceiling(arg0: &mut SpendCeiling, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 14);
        arg0.max_per_tx = arg1;
        arg0.max_total = arg2;
        let v0 = SpendCeilingUpdated{
            spend_ceiling : 0x2::object::uid_to_address(&arg0.id),
            max_per_tx    : arg0.max_per_tx,
            max_total     : arg0.max_total,
        };
        0x2::event::emit<SpendCeilingUpdated>(v0);
    }

    public fun vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun vault_id<T0>(arg0: &Vault<T0>) : &0x1::string::String {
        &arg0.vault_id
    }

    public fun vault_owner<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun vault_state<T0>(arg0: &Vault<T0>) : u64 {
        arg0.vault_state
    }

    public fun velocity_cap(arg0: &AffiliateBudget) : u64 {
        arg0.velocity_cap
    }

    fun votes<T0>(arg0: &Vault<T0>, arg1: &Group, arg2: address, arg3: u64) : bool {
        if (is_active_owner<T0>(arg0, arg2)) {
            if (life_of<T0>(arg0, arg2) == arg3) {
                pen_ok(arg1, arg2, 1)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun wait_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.wait_ms
    }

    public fun wallet_id(arg0: &ScopedWallet) : &0x1::string::String {
        &arg0.wallet_id
    }

    public fun wallet_state(arg0: &ScopedWallet) : u64 {
        arg0.wallet_state
    }

    public fun warn_path(arg0: &mut Path, arg1: &WorkerCap, arg2: u64) {
        let v0 = if (arg2 > 10000) {
            10000
        } else {
            arg2
        };
        arg0.resistance = arg0.resistance + v0;
        let v1 = Warned{
            path       : 0x2::object::uid_to_address(&arg0.id),
            amount     : v0,
            resistance : arg0.resistance,
        };
        0x2::event::emit<Warned>(v1);
    }

    fun weight_of<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).weight
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_group<T0>(arg0, arg1);
        assert!(arg0.vault_state == 0, 22);
        assert_owner<T0>(arg0, v0);
        assert_pen<T0>(arg0, arg1, v0);
        assert!(arg2 > 0, 29);
        roll_owner_period<T0>(arg0, 0x2::clock::timestamp_ms(arg4));
        assert!(may_sign<T0>(arg0, v0, arg2) == 1, 23);
        arg0.owner_spent = arg0.owner_spent + arg2;
        pay_out<T0>(arg0, arg2, arg3, arg5);
        let v1 = VaultWithdrawn{
            vault     : 0x2::object::uid_to_address(&arg0.id),
            who       : v0,
            amount    : arg2,
            to        : arg3,
            approvers : vector[],
        };
        0x2::event::emit<VaultWithdrawn>(v1);
    }

    public fun withdraw_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = grant_signers_pending_by<T0>(arg0, arg1);
        assert!(v1 != @0x0, 37);
        assert!(v0 == v1 || is_active_owner<T0>(arg0, v0), 39);
        let (_, _) = grant_signers_pending_take<T0>(arg0, arg1);
        let v4 = VaultGrantSignerWithdrawn{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            who    : arg1,
            sender : v0,
        };
        0x2::event::emit<VaultGrantSignerWithdrawn>(v4);
    }

    public fun withdraw_owner_offer<T0>(arg0: &mut Vault<T0>, arg1: &Group, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner_in<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
        let v0 = OwnerOfferKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<OwnerOfferKey>(&arg0.id, v0), 51);
        let v1 = OwnerOfferKey{dummy_field: false};
        0x2::dynamic_field::remove<OwnerOfferKey, OwnerOffer>(&mut arg0.id, v1);
    }

    public fun withdraw_seat(arg0: &mut Group, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SeatKey{pk: arg1};
        assert!(0x2::dynamic_field::exists_<SeatKey>(&arg0.id, v1), 42);
        let v2 = 0x2::dynamic_field::remove<SeatKey, Seat>(&mut arg0.id, v1);
        assert!(v0 == v2.by || is_member(arg0, v0, 3), 41);
        let v3 = SeatWithdrawn{
            group   : 0x2::object::uid_to_address(&arg0.id),
            seat_pk : v1.pk,
            sender  : v0,
        };
        0x2::event::emit<SeatWithdrawn>(v3);
    }

    public fun worker(arg0: &Escrow) : address {
        arg0.worker
    }

    // decompiled from Move bytecode v7
}

