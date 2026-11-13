module 0xe930eb52b047d3387202a8f245ae7a2125da0b883ae5df9231a07887409ea957::substrate {
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
        signers: 0x2::vec_map::VecMap<address, Signer>,
        pause_epoch: u64,
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

    struct Membership has key {
        id: 0x2::object::UID,
        group: address,
        member: address,
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

    struct MembershipCreated has copy, drop {
        membership: address,
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
        line: u64,
        quorum_move: u64,
        quorum_signers: u64,
        approvals: vector<address>,
        approval_lives: vector<u64>,
        approved_weight: u64,
        expires_at: u64,
        proposal_state: u64,
        pause_epoch: u64,
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

    struct VaultSealedHashSet has copy, drop {
        vault: address,
        sealed_hash: vector<u8>,
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

    public fun accept_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, _) = grant_signers_pending_take<T0>(arg0, v0);
        assert!(v1, 37);
        assert!(!0x1::vector::contains<address>(&arg0.grant_signers, &v0), 30);
        0x1::vector::push_back<address>(&mut arg0.grant_signers, v0);
        let v3 = VaultGrantSignersSet{
            vault         : 0x2::object::uid_to_address(&arg0.id),
            who           : v0,
            added         : true,
            sender        : v0,
            grant_signers : arg0.grant_signers,
        };
        0x2::event::emit<VaultGrantSignersSet>(v3);
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

    public fun add_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.grant_signers, &v0), 32);
        assert!(arg1 != @0x0, 29);
        assert!(!0x1::vector::contains<address>(&arg0.grant_signers, &arg1), 30);
        assert!(grant_signers_pending_by<T0>(arg0, arg1) == @0x0, 30);
        let v1 = grant_signers_pending<T0>(arg0);
        assert!(0x1::vector::length<address>(&v1) < 8, 38);
        grant_signers_pending_push<T0>(arg0, arg1, v0);
        let v2 = VaultGrantSignerProposed{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            who    : arg1,
            sender : v0,
        };
        0x2::event::emit<VaultGrantSignerProposed>(v2);
    }

    public fun add_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_owner<T0>(arg0, v0);
        assert_pause_rule<T0>(arg0, 1);
        assert!(quorum_of<T0>(arg0, 1, arg1, arg2) <= weight_of<T0>(arg0, v0), 27);
        do_add_signer<T0>(arg0, arg1, arg2, arg3, arg4);
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

    public fun approve<T0>(arg0: &mut Vault<T0>, arg1: &mut Proposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.vault == 0x2::object::uid_to_address(&arg0.id), 29);
        assert!(arg1.proposal_state == 0, 26);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.expires_at, 25);
        assert!(arg1.kind != 4 || arg1.pause_epoch == arg0.pause_epoch, 25);
        assert_owner<T0>(arg0, v0);
        let v1 = life_of<T0>(arg0, v0);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg1.approvals, &v0);
        if (v2) {
            assert!(*0x1::vector::borrow<u64>(&arg1.approval_lives, v3) != v1, 26);
            *0x1::vector::borrow_mut<u64>(&mut arg1.approval_lives, v3) = v1;
        } else {
            0x1::vector::push_back<address>(&mut arg1.approvals, v0);
            0x1::vector::push_back<u64>(&mut arg1.approval_lives, v1);
        };
        arg1.approved_weight = approved_weight_of<T0>(arg0, &arg1.approvals, &arg1.approval_lives);
        let v4 = arg1.approved_weight >= proposal_quorum<T0>(arg0, arg1);
        if (v4) {
            execute<T0>(arg0, arg1, arg3);
            arg1.proposal_state = 1;
        };
        let v5 = VaultApproved{
            vault           : 0x2::object::uid_to_address(&arg0.id),
            proposal        : 0x2::object::uid_to_address(&arg1.id),
            who             : v0,
            approved_weight : arg1.approved_weight,
            executed        : v4,
        };
        0x2::event::emit<VaultApproved>(v5);
    }

    fun approved_weight_of<T0>(arg0: &Vault<T0>, arg1: &vector<address>, arg2: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            let v2 = *0x1::vector::borrow<address>(arg1, v1);
            if (is_active_owner<T0>(arg0, v2) && life_of<T0>(arg0, v2) == *0x1::vector::borrow<u64>(arg2, v1)) {
                v0 = v0 + weight_of<T0>(arg0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun assert_owner<T0>(arg0: &Vault<T0>, arg1: address) {
        assert!(is_active_owner<T0>(arg0, arg1), 24);
    }

    fun assert_pause_rule<T0>(arg0: &Vault<T0>, arg1: u8) {
        if (arg1 == 4) {
            assert!(arg0.vault_state == 1, 30);
        } else if (arg1 != 2 && arg1 != 5) {
            assert!(arg0.vault_state == 0, 22);
        };
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

    public fun cancel_grant_signers_reset<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_owner<T0>(arg0, v0);
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

    public fun create_group(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Group{
            id         : 0x2::object::new(arg5),
            gid        : arg0,
            name       : arg1,
            group_type : arg2,
            status     : arg3,
            treasury   : 0x2::balance::zero<0x2::sui::SUI>(),
            fade_rate  : arg4,
        };
        let v1 = GroupCreated{group: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<GroupCreated>(v1);
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

    public fun create_membership(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Membership{
            id     : 0x2::object::new(arg2),
            group  : arg0,
            member : arg1,
        };
        let v1 = MembershipCreated{membership: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<MembershipCreated>(v1);
        0x2::transfer::share_object<Membership>(v0);
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

    public fun create_vault<T0>(arg0: 0x1::string::String, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg4 > 0, 29);
        assert!(arg4 >= arg3, 27);
        assert!(arg1 != @0x0, 29);
        let v0 = Vault<T0>{
            id                 : 0x2::object::new(arg5),
            vault_id           : arg0,
            owner              : arg1,
            line               : arg2,
            quorum_move        : arg3,
            quorum_signers     : arg4,
            balance            : 0x2::balance::zero<T0>(),
            vault_state        : 0,
            owner_spent        : 0,
            owner_period_start : 0,
            grant_signers      : 0x1::vector::empty<address>(),
            readers            : 0x1::vector::empty<address>(),
            sealed_hash        : 0x1::vector::empty<u8>(),
            signers            : 0x2::vec_map::empty<address, Signer>(),
            pause_epoch        : 0,
        };
        let v1 = Signer{
            weight         : 1,
            max_per_tx     : 0,
            max_per_period : 0,
            spent          : 0,
            period_start   : 0,
            signer_state   : 0,
            life           : 0,
        };
        0x2::vec_map::insert<address, Signer>(&mut v0.signers, arg1, v1);
        let v2 = VaultCreated{
            vault          : 0x2::object::uid_to_address(&v0.id),
            coin           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            owner          : v0.owner,
            line           : v0.line,
            quorum_move    : v0.quorum_move,
            quorum_signers : v0.quorum_signers,
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0>>(v0);
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

    fun do_add_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1 != @0x0, 29);
        assert!(arg2 <= 1, 29);
        let v0 = 0;
        if (0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1)) {
            assert!(0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).signer_state == 2, 30);
            v0 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).life + 1;
            let (_, _) = 0x2::vec_map::remove<address, Signer>(&mut arg0.signers, &arg1);
        };
        let v3 = Signer{
            weight         : arg2,
            max_per_tx     : arg3,
            max_per_period : arg4,
            spent          : 0,
            period_start   : 0,
            signer_state   : 0,
            life           : v0,
        };
        0x2::vec_map::insert<address, Signer>(&mut arg0.signers, arg1, v3);
        emit_signer<T0>(arg0, arg1);
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

    fun do_set_ceiling<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: u64) {
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        let v0 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &arg1);
        assert!(v0.signer_state != 2, 20);
        if (arg2 > v0.max_per_tx || arg3 > v0.max_per_period) {
            assert!(!(arg0.vault_state != 0), 22);
        };
        let v1 = arg2 == 0 || arg3 == 0;
        let v2 = if (v1) {
            if (v0.signer_state == 0) {
                v0.weight > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            assert!(active_owner_weight<T0>(arg0) > v0.weight, 28);
        };
        if (!v1 && v0.signer_state == 1) {
            v0.life = v0.life + 1;
        };
        v0.max_per_tx = arg2;
        v0.max_per_period = arg3;
        let v3 = if (v1) {
            1
        } else {
            0
        };
        v0.signer_state = v3;
        emit_signer<T0>(arg0, arg1);
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

    fun execute<T0>(arg0: &mut Vault<T0>, arg1: &Proposal, arg2: &mut 0x2::tx_context::TxContext) {
        assert_pause_rule<T0>(arg0, arg1.kind);
        if (arg1.kind == 0) {
            assert!(arg1.amount > 0, 29);
            let v0 = live_approvers<T0>(arg0, &arg1.approvals, &arg1.approval_lives);
            pay_out<T0>(arg0, arg1.amount, arg1.to, arg2);
            let v1 = VaultWithdrawn{
                vault     : 0x2::object::uid_to_address(&arg0.id),
                who       : 0x2::tx_context::sender(arg2),
                amount    : arg1.amount,
                to        : arg1.to,
                approvers : v0,
            };
            0x2::event::emit<VaultWithdrawn>(v1);
        } else if (arg1.kind == 1) {
            do_add_signer<T0>(arg0, arg1.to, arg1.weight, arg1.max_per_tx, arg1.max_per_period);
        } else if (arg1.kind == 2) {
            do_remove_signer<T0>(arg0, arg1.to, arg2);
        } else if (arg1.kind == 3) {
            do_set_line<T0>(arg0, arg1.line, arg1.quorum_move, arg1.quorum_signers);
        } else if (arg1.kind == 5) {
            do_set_ceiling<T0>(arg0, arg1.to, arg1.max_per_tx, arg1.max_per_period);
        } else {
            arg0.vault_state = 0;
            let v2 = VaultPaused{
                vault  : 0x2::object::uid_to_address(&arg0.id),
                paused : false,
            };
            0x2::event::emit<VaultPaused>(v2);
        };
    }

    public fun execute_grant_signers_reset<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner<T0>(arg0, v0);
        let v1 = GrantSignersResetKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v1), 35);
        let v2 = GrantSignersResetKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg1) >= *0x2::dynamic_field::borrow<GrantSignersResetKey, u64>(&arg0.id, v2), 36);
        clear_grant_signers<T0>(arg0, v0);
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

    public fun follow_path(arg0: &Path, arg1: &WorkerCap) {
        let v0 = Followed{path: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<Followed>(v0);
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

    fun grant_signers_pending_push<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: address) {
        let v0 = GrantSignersPendingKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<GrantSignersPendingKey>(&arg0.id, v0)) {
            let v1 = GrantSignersPendingKey{dummy_field: false};
            0x2::dynamic_field::add<GrantSignersPendingKey, vector<GrantSignersPending>>(&mut arg0.id, v1, 0x1::vector::empty<GrantSignersPending>());
        };
        let v2 = GrantSignersPendingKey{dummy_field: false};
        let v3 = GrantSignersPending{
            who : arg1,
            by  : arg2,
        };
        0x1::vector::push_back<GrantSignersPending>(0x2::dynamic_field::borrow_mut<GrantSignersPendingKey, vector<GrantSignersPending>>(&mut arg0.id, v2), v3);
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

    public fun group(arg0: &Membership) : address {
        arg0.group
    }

    public fun group_name(arg0: &Group) : &0x1::string::String {
        &arg0.name
    }

    public fun group_status(arg0: &Group) : &0x1::string::String {
        &arg0.status
    }

    public fun group_type(arg0: &Group) : &0x1::string::String {
        &arg0.group_type
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

    public fun is_signer<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1) && 0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1).signer_state != 2
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

    fun live_approvers<T0>(arg0: &Vault<T0>, arg1: &vector<address>, arg2: &vector<u64>) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            let v2 = *0x1::vector::borrow<address>(arg1, v1);
            if (is_active_owner<T0>(arg0, v2) && life_of<T0>(arg0, v2) == *0x1::vector::borrow<u64>(arg2, v1)) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
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

    public fun member(arg0: &Membership) : address {
        arg0.member
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

    public fun owner(arg0: &Actor) : &0x1::string::String {
        &arg0.owner
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

    public fun owner_spent<T0>(arg0: &Vault<T0>) : u64 {
        arg0.owner_spent
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

    public fun pause<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg1));
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

    public fun proposal_state(arg0: &Proposal) : u64 {
        arg0.proposal_state
    }

    public fun proposal_to(arg0: &Proposal) : address {
        arg0.to
    }

    public fun proposal_vault(arg0: &Proposal) : address {
        arg0.vault
    }

    public fun propose<T0>(arg0: &Vault<T0>, arg1: u8, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(arg1 <= 5, 29);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &v0), 20);
        assert!(0x2::vec_map::get<address, Signer>(&arg0.signers, &v0).signer_state == 0, 20);
        assert_pause_rule<T0>(arg0, arg1);
        let v1 = Proposal{
            id              : 0x2::object::new(arg11),
            vault           : 0x2::object::uid_to_address(&arg0.id),
            kind            : arg1,
            to              : arg2,
            amount          : arg3,
            weight          : arg4,
            max_per_tx      : arg5,
            max_per_period  : arg6,
            line            : arg7,
            quorum_move     : arg8,
            quorum_signers  : arg9,
            approvals       : vector[],
            approval_lives  : vector[],
            approved_weight : 0,
            expires_at      : 0x2::clock::timestamp_ms(arg10) + 86400000,
            proposal_state  : 0,
            pause_epoch     : arg0.pause_epoch,
        };
        let v2 = VaultProposed{
            vault    : 0x2::object::uid_to_address(&arg0.id),
            proposal : 0x2::object::uid_to_address(&v1.id),
            kind     : arg1,
            who      : v0,
        };
        0x2::event::emit<VaultProposed>(v2);
        0x2::transfer::share_object<Proposal>(v1);
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
        if (touches_owner<T0>(arg0, arg1, arg2, arg3)) {
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

    public fun remove_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner<T0>(arg0, v0);
        assert!(quorum_of<T0>(arg0, 2, arg1, 0) <= weight_of<T0>(arg0, v0), 27);
        do_remove_signer<T0>(arg0, arg1, arg2);
    }

    public fun request_grant_signers_reset<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner<T0>(arg0, v0);
        let v1 = GrantSignersResetKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v1), 34);
        let v2 = 0x2::clock::timestamp_ms(arg1) + 604800000;
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

    public fun resistance(arg0: &Path) : u64 {
        arg0.resistance
    }

    public fun resume<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_owner<T0>(arg0, v0);
        assert!(arg0.vault_state == 1, 30);
        assert!(quorum_for<T0>(arg0, 0) <= weight_of<T0>(arg0, v0), 27);
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

    public fun set_ceiling<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_owner<T0>(arg0, v0);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1), 20);
        let v1 = *0x2::vec_map::get<address, Signer>(&arg0.signers, &arg1);
        if (arg2 > v1.max_per_tx || arg3 > v1.max_per_period || v1.weight > 0) {
            assert!(quorum_of<T0>(arg0, 5, arg1, 0) <= weight_of<T0>(arg0, v0), 27);
        };
        do_set_ceiling<T0>(arg0, arg1, arg2, arg3);
    }

    public fun set_first_grant_signer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_owner<T0>(arg0, v0);
        assert!(0x1::vector::is_empty<address>(&arg0.grant_signers), 33);
        let v1 = grant_signers_pending<T0>(arg0);
        assert!(0x1::vector::is_empty<address>(&v1), 38);
        assert!(arg1 != @0x0, 29);
        grant_signers_pending_push<T0>(arg0, arg1, v0);
        let v2 = VaultGrantSignerProposed{
            vault  : 0x2::object::uid_to_address(&arg0.id),
            who    : arg1,
            sender : v0,
        };
        0x2::event::emit<VaultGrantSignerProposed>(v2);
        let v3 = GrantSignersResetKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<GrantSignersResetKey>(&arg0.id, v3)) {
            let v4 = GrantSignersResetKey{dummy_field: false};
            0x2::dynamic_field::remove<GrantSignersResetKey, u64>(&mut arg0.id, v4);
            let v5 = VaultGrantSignersResetCancelled{
                vault  : 0x2::object::uid_to_address(&arg0.id),
                sender : v0,
            };
            0x2::event::emit<VaultGrantSignersResetCancelled>(v5);
        };
    }

    public fun set_line<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_owner<T0>(arg0, v0);
        assert_pause_rule<T0>(arg0, 3);
        assert!(line_quorum<T0>(arg0, arg1, arg2, arg3) <= weight_of<T0>(arg0, v0), 27);
        do_set_line<T0>(arg0, arg1, arg2, arg3);
    }

    public fun set_readers<T0>(arg0: &mut Vault<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            assert!(v1 != @0x0, 29);
            let (_, v3) = 0x1::vector::index_of<address>(&arg1, &v1);
            assert!(v3 == v0, 30);
            v0 = v0 + 1;
        };
        arg0.readers = arg1;
        let v4 = VaultReadersSet{
            vault   : 0x2::object::uid_to_address(&arg0.id),
            readers : arg0.readers,
        };
        0x2::event::emit<VaultReadersSet>(v4);
    }

    public fun set_sealed_hash<T0>(arg0: &mut Vault<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x1::vector::length<u8>(&arg1) == 32, 31);
        arg0.sealed_hash = arg1;
        let v0 = VaultSealedHashSet{
            vault       : 0x2::object::uid_to_address(&arg0.id),
            sealed_hash : arg0.sealed_hash,
        };
        0x2::event::emit<VaultSealedHashSet>(v0);
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

    public fun spend<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.vault_state == 0, 22);
        assert!(0x2::vec_map::contains<address, Signer>(&arg0.signers, &v0), 20);
        assert!(arg1 > 0, 29);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::vec_map::get<address, Signer>(&arg0.signers, &v0);
        assert!(v2.signer_state != 2, 20);
        assert!(v2.signer_state == 0, 22);
        assert!(may_sign<T0>(arg0, v0, arg1) == 0, 21);
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
        assert!(v4.spent + arg1 <= v4.max_per_period, 21);
        v4.spent = v4.spent + arg1;
        pay_out<T0>(arg0, arg1, arg2, arg4);
        let v6 = VaultSpent{
            vault  : v3,
            who    : v0,
            amount : arg1,
            to     : arg2,
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

    public fun target(arg0: &Path) : address {
        arg0.target
    }

    public fun target_ref(arg0: &Highway) : &0x1::string::String {
        &arg0.target_ref
    }

    public fun task_name(arg0: &SignalObj) : &0x1::string::String {
        &arg0.task_name
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

    public fun transfer_owner<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 24);
        assert_owner<T0>(arg0, v0);
        assert!(arg0.vault_state == 0, 22);
        assert!(arg1 != @0x0, 29);
        assert!(arg1 != v0, 30);
        if (0x2::vec_map::contains<address, Signer>(&arg0.signers, &arg1)) {
            let v1 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &arg1);
            assert!(v1.signer_state == 2, 30);
            v1.weight = 1;
            v1.signer_state = 0;
            v1.life = v1.life + 1;
        } else {
            let v2 = Signer{
                weight         : 1,
                max_per_tx     : 0,
                max_per_period : 0,
                spent          : 0,
                period_start   : 0,
                signer_state   : 0,
                life           : 0,
            };
            0x2::vec_map::insert<address, Signer>(&mut arg0.signers, arg1, v2);
        };
        assert!(active_owner_weight<T0>(arg0) < 2, 27);
        let v3 = 0x2::vec_map::get_mut<address, Signer>(&mut arg0.signers, &v0);
        v3.signer_state = 2;
        v3.max_per_tx = 0;
        v3.max_per_period = 0;
        arg0.owner = arg1;
        clear_grant_signers<T0>(arg0, v0);
        emit_signer<T0>(arg0, arg1);
        emit_signer<T0>(arg0, v0);
        let v4 = VaultOwnerTransferred{
            vault          : 0x2::object::uid_to_address(&arg0.id),
            previous_owner : v0,
            new_owner      : arg1,
        };
        0x2::event::emit<VaultOwnerTransferred>(v4);
    }

    public fun treasury(arg0: &Group) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
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

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.vault_state == 0, 22);
        assert_owner<T0>(arg0, v0);
        assert!(arg1 > 0, 29);
        roll_owner_period<T0>(arg0, 0x2::clock::timestamp_ms(arg3));
        assert!(may_sign<T0>(arg0, v0, arg1) == 1, 23);
        arg0.owner_spent = arg0.owner_spent + arg1;
        pay_out<T0>(arg0, arg1, arg2, arg4);
        let v1 = VaultWithdrawn{
            vault     : 0x2::object::uid_to_address(&arg0.id),
            who       : v0,
            amount    : arg1,
            to        : arg2,
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

    public fun worker(arg0: &Escrow) : address {
        arg0.worker
    }

    // decompiled from Move bytecode v7
}

