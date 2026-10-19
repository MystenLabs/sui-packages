module 0xd2fce6f68f205983b0a9c1b633ce251b66c1dabf0bedf1926eef31e5f7e7a41d::quest_rewards {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct QuestPool has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: address,
        signer_pubkey: vector<u8>,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        quests: 0x2::table::Table<vector<u8>, QuestConfig>,
        positions: 0x2::table::Table<vector<u8>, VestingPosition>,
    }

    struct QuestConfig has store {
        tiers: vector<QuestTier>,
        max_budget: u64,
        total_claimed: u64,
        paused: bool,
    }

    struct QuestTier has copy, drop, store {
        amount_per_claim: u64,
        schedule: VestingSchedule,
    }

    struct VestingPosition has store {
        total: u64,
        collected: u64,
        start_ms: u64,
        schedule: VestingSchedule,
        next_window: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        admin: address,
    }

    struct QuestRegistered has copy, drop {
        quest_id: vector<u8>,
        tier_count: u64,
        max_budget: u64,
    }

    struct QuestClaimed has copy, drop {
        quest_id: vector<u8>,
        recipient: address,
        tier_id: u8,
        total: u64,
        start_ms: u64,
    }

    struct VestingCollected has copy, drop {
        quest_id: vector<u8>,
        recipient: address,
        amount: u64,
        remaining: u64,
    }

    struct SignerRotated has copy, drop {
        old_pubkey: vector<u8>,
        new_pubkey: vector<u8>,
    }

    struct Deposited has copy, drop {
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct QuestPaused has copy, drop {
        quest_id: vector<u8>,
        paused: bool,
    }

    struct QuestUpdated has copy, drop {
        quest_id: vector<u8>,
        tier_count: u64,
        max_budget: u64,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AdminHandoverProposed has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct VestingSchedule has copy, drop, store {
        tranches: u8,
        interval_ms: u64,
        first_at_claim: bool,
    }

    struct RegistrarCap has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct RegistrarPolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RegistrarManagedKey has copy, drop, store {
        quest_id: vector<u8>,
    }

    struct RegistrarLimits has copy, drop, store {
        max_tiers: u64,
        max_tier_amount: u64,
        max_budget_per_quest: u64,
        id_prefix: vector<u8>,
        max_id_len: u64,
    }

    struct RegistrarPolicy has store {
        active_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        limits: RegistrarLimits,
        remaining_allowance: u64,
    }

    struct RegistrarLimitsChanged has copy, drop {
        pool_id: 0x2::object::ID,
        actor: address,
        initialized: bool,
        limits: RegistrarLimits,
    }

    struct RegistrarAllowanceChanged has copy, drop {
        pool_id: 0x2::object::ID,
        actor: address,
        previous: u64,
        remaining: u64,
        increment: bool,
    }

    struct RegistrarCapIssued has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        actor: address,
        recipient: address,
    }

    struct RegistrarCapRevoked has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        actor: address,
    }

    struct RegistrarQuestAdopted has copy, drop {
        pool_id: 0x2::object::ID,
        quest_id: vector<u8>,
        actor: address,
    }

    struct RegistrarQuestRegistered has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        actor: address,
        quest_id: vector<u8>,
        max_budget: u64,
        remaining_allowance: u64,
    }

    struct RegistrarTiersAppended has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        actor: address,
        quest_id: vector<u8>,
        previous_count: u64,
        tier_count: u64,
    }

    struct RegistrarBudgetRaised has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        actor: address,
        quest_id: vector<u8>,
        previous_budget: u64,
        max_budget: u64,
        remaining_allowance: u64,
    }

    struct RegistrarQuestPaused has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        actor: address,
        quest_id: vector<u8>,
    }

    struct Funded has copy, drop {
        pool_id: 0x2::object::ID,
        from: address,
        amount: u64,
    }

    public fun accept_admin(arg0: &mut QuestPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.pending_admin, 18);
        let v0 = arg0.pending_admin;
        arg0.admin = v0;
        arg0.pending_admin = @0x0;
        let v1 = AdminChanged{
            old_admin : arg0.admin,
            new_admin : v0,
        };
        0x2::event::emit<AdminChanged>(v1);
    }

    public fun admin(arg0: &QuestPool) : address {
        arg0.admin
    }

    public fun adopt_quest_for_registrar(arg0: &mut QuestPool, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(has_registrar_policy(arg0), 19);
        assert!(quest_exists(arg0, arg1), 4);
        assert!(!is_registrar_managed(arg0, arg1), 31);
        let v0 = RegistrarManagedKey{quest_id: arg1};
        0x2::dynamic_field::add<RegistrarManagedKey, bool>(&mut arg0.id, v0, true);
        let v1 = RegistrarQuestAdopted{
            pool_id  : 0x2::object::id<QuestPool>(arg0),
            quest_id : arg1,
            actor    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RegistrarQuestAdopted>(v1);
    }

    public fun append_tiers_as_registrar(arg0: &mut QuestPool, arg1: &RegistrarCap, arg2: vector<u8>, arg3: vector<QuestTier>, arg4: &0x2::tx_context::TxContext) {
        assert_managed_registrar(arg0, arg1, arg2);
        let v0 = registrar_policy(arg0).limits;
        let v1 = borrow_quest_mut(arg0, arg2);
        let v2 = 0x1::vector::length<QuestTier>(&v1.tiers);
        check_registrar_tiers(&v0, &arg3, v2);
        0x1::vector::append<QuestTier>(&mut v1.tiers, arg3);
        let v3 = RegistrarTiersAppended{
            pool_id        : 0x2::object::id<QuestPool>(arg0),
            cap_id         : 0x2::object::id<RegistrarCap>(arg1),
            actor          : 0x2::tx_context::sender(arg4),
            quest_id       : arg2,
            previous_count : v2,
            tier_count     : 0x1::vector::length<QuestTier>(&v1.tiers),
        };
        0x2::event::emit<RegistrarTiersAppended>(v3);
    }

    fun assert_admin(arg0: &QuestPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
    }

    fun assert_managed_registrar(arg0: &QuestPool, arg1: &RegistrarCap, arg2: vector<u8>) {
        assert_registrar(arg0, arg1);
        assert!(is_registrar_managed(arg0, arg2), 30);
    }

    fun assert_registrar(arg0: &QuestPool, arg1: &RegistrarCap) {
        assert!(arg1.pool_id == 0x2::object::id<QuestPool>(arg0), 22);
        let v0 = 0x2::object::id<RegistrarCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&registrar_policy(arg0).active_caps, &v0), 23);
    }

    fun borrow_position(arg0: &QuestPool, arg1: vector<u8>) : &VestingPosition {
        assert!(0x2::table::contains<vector<u8>, VestingPosition>(&arg0.positions, arg1), 4);
        0x2::table::borrow<vector<u8>, VestingPosition>(&arg0.positions, arg1)
    }

    fun borrow_quest(arg0: &QuestPool, arg1: vector<u8>) : &QuestConfig {
        assert!(0x2::table::contains<vector<u8>, QuestConfig>(&arg0.quests, arg1), 4);
        0x2::table::borrow<vector<u8>, QuestConfig>(&arg0.quests, arg1)
    }

    fun borrow_quest_mut(arg0: &mut QuestPool, arg1: vector<u8>) : &mut QuestConfig {
        assert!(0x2::table::contains<vector<u8>, QuestConfig>(&arg0.quests, arg1), 4);
        0x2::table::borrow_mut<vector<u8>, QuestConfig>(&mut arg0.quests, arg1)
    }

    fun borrow_tier(arg0: &QuestConfig, arg1: u8) : &QuestTier {
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<QuestTier>(&arg0.tiers), 5);
        0x1::vector::borrow<QuestTier>(&arg0.tiers, v0)
    }

    fun check_registrar_tiers(arg0: &RegistrarLimits, arg1: &vector<QuestTier>, arg2: u64) {
        assert!(0x1::vector::length<QuestTier>(arg1) > 0, 6);
        assert!(arg2 <= arg0.max_tiers && 0x1::vector::length<QuestTier>(arg1) <= arg0.max_tiers - arg2, 26);
        let v0 = 0;
        while (v0 < 0x1::vector::length<QuestTier>(arg1)) {
            assert!(0x1::vector::borrow<QuestTier>(arg1, v0).amount_per_claim <= arg0.max_tier_amount, 27);
            v0 = v0 + 1;
        };
    }

    fun checked_registrar_limits(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64) : RegistrarLimits {
        assert!(arg0 > 0 && arg0 <= 256, 21);
        assert!(arg1 > 0 && arg2 > 0, 21);
        let v0 = if (0x1::vector::length<u8>(&arg3) > 0) {
            if (0x1::vector::length<u8>(&arg3) <= arg4) {
                arg4 <= 128
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 21);
        RegistrarLimits{
            max_tiers            : arg0,
            max_tier_amount      : arg1,
            max_budget_per_quest : arg2,
            id_prefix            : arg3,
            max_id_len           : arg4,
        }
    }

    public fun claim_amount_message(arg0: vector<u8>, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>) : vector<u8> {
        let v0 = b"YOSO_QUEST_CLAIM_AMT_V1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, arg5);
        v0
    }

    public fun claim_message(arg0: vector<u8>, arg1: address, arg2: u8, arg3: u64, arg4: vector<u8>) : vector<u8> {
        let v0 = b"YOSO_QUEST_CLAIM_V1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, arg4);
        v0
    }

    public fun claim_quest(arg0: &mut QuestPool, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 < arg3, 9);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(verify_claim_signature(arg0.signer_pubkey, claim_message(pool_id_bytes(arg0), v1, arg2, arg3, arg1), arg4), 11);
        create_position(arg0, arg1, arg2, v1, 0x1::option::none<u64>(), v0);
    }

    public fun claim_with_amount(arg0: &mut QuestPool, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 < arg4, 9);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(verify_claim_signature(arg0.signer_pubkey, claim_amount_message(pool_id_bytes(arg0), v1, arg2, arg3, arg4, arg1), arg5), 11);
        create_position(arg0, arg1, arg2, v1, 0x1::option::some<u64>(arg3), v0);
    }

    public fun claimable_at(arg0: &QuestPool, arg1: vector<u8>, arg2: u64) : u64 {
        window_claimable(borrow_position(arg0, arg1), arg2)
    }

    public fun collect(arg0: &mut QuestPool, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = position_key(arg1, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<vector<u8>, VestingPosition>(&arg0.positions, v1), 4);
        let v3 = 0x2::table::borrow_mut<vector<u8>, VestingPosition>(&mut arg0.positions, v1);
        let v4 = window_claimable(v3, v2);
        assert!(v4 > 0, 13);
        v3.next_window = steps_at(v3.start_ms, &v3.schedule, v2) - 1 + 1;
        v3.collected = v3.collected + v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v4), arg3), v0);
        let v5 = VestingCollected{
            quest_id  : arg1,
            recipient : v0,
            amount    : v4,
            remaining : v3.total - v3.collected,
        };
        0x2::event::emit<VestingCollected>(v5);
    }

    fun create_position(arg0: &mut QuestPool, arg1: vector<u8>, arg2: u8, arg3: address, arg4: 0x1::option::Option<u64>, arg5: u64) {
        let v0 = position_key(arg1, arg3);
        assert!(!0x2::table::contains<vector<u8>, VestingPosition>(&arg0.positions, v0), 8);
        let v1 = borrow_quest_mut(arg0, arg1);
        assert!(!v1.paused, 12);
        let v2 = *borrow_tier(v1, arg2);
        let v3 = 0x1::option::destroy_with_default<u64>(arg4, v2.amount_per_claim);
        assert!(v3 > 0, 7);
        assert!(v1.total_claimed + v3 <= v1.max_budget, 10);
        v1.total_claimed = v1.total_claimed + v3;
        let v4 = VestingPosition{
            total       : v3,
            collected   : 0,
            start_ms    : arg5,
            schedule    : v2.schedule,
            next_window : 0,
        };
        0x2::table::add<vector<u8>, VestingPosition>(&mut arg0.positions, v0, v4);
        let v5 = QuestClaimed{
            quest_id  : arg1,
            recipient : arg3,
            tier_id   : arg2,
            total     : v3,
            start_ms  : arg5,
        };
        0x2::event::emit<QuestClaimed>(v5);
    }

    public fun create_quest_pool(arg0: &AdminCap, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 15);
        let v0 = new_pool(arg1, arg2, arg3);
        let v1 = PoolCreated{
            pool_id : 0x2::object::uid_to_address(&v0.id),
            admin   : arg1,
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<QuestPool>(v0);
    }

    public fun deposit(arg0: &mut QuestPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Deposited{amount: v0};
        0x2::event::emit<Deposited>(v1);
    }

    public fun fund(arg0: &mut QuestPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Funded{
            pool_id : 0x2::object::id<QuestPool>(arg0),
            from    : 0x2::tx_context::sender(arg2),
            amount  : v0,
        };
        0x2::event::emit<Funded>(v1);
    }

    public fun has_position(arg0: &QuestPool, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, VestingPosition>(&arg0.positions, arg1)
    }

    public fun has_registrar_policy(arg0: &QuestPool) : bool {
        let v0 = RegistrarPolicyKey{dummy_field: false};
        0x2::dynamic_field::exists<RegistrarPolicyKey>(&arg0.id, v0)
    }

    public fun increase_registrar_allowance(arg0: &mut QuestPool, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 > 0, 7);
        let v0 = registrar_policy_mut(arg0);
        let v1 = v0.remaining_allowance;
        assert!(arg1 <= 18446744073709551615 - v1, 35);
        let v2 = v1 + arg1;
        v0.remaining_allowance = v2;
        let v3 = RegistrarAllowanceChanged{
            pool_id   : 0x2::object::id<QuestPool>(arg0),
            actor     : 0x2::tx_context::sender(arg2),
            previous  : v1,
            remaining : v2,
            increment : true,
        };
        0x2::event::emit<RegistrarAllowanceChanged>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_registrar_policy(arg0: &mut QuestPool, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg6);
        assert!(!has_registrar_policy(arg0), 20);
        let v0 = checked_registrar_limits(arg1, arg2, arg3, arg4, arg5);
        let v1 = RegistrarPolicyKey{dummy_field: false};
        let v2 = RegistrarPolicy{
            active_caps         : 0x2::vec_set::empty<0x2::object::ID>(),
            limits              : v0,
            remaining_allowance : 0,
        };
        0x2::dynamic_field::add<RegistrarPolicyKey, RegistrarPolicy>(&mut arg0.id, v1, v2);
        let v3 = RegistrarLimitsChanged{
            pool_id     : 0x2::object::id<QuestPool>(arg0),
            actor       : 0x2::tx_context::sender(arg6),
            initialized : true,
            limits      : v0,
        };
        0x2::event::emit<RegistrarLimitsChanged>(v3);
    }

    public fun is_registrar_managed(arg0: &QuestPool, arg1: vector<u8>) : bool {
        let v0 = RegistrarManagedKey{quest_id: arg1};
        0x2::dynamic_field::exists<RegistrarManagedKey>(&arg0.id, v0)
    }

    public fun issue_registrar_cap(arg0: &mut QuestPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 34);
        let v0 = 0x2::object::id<QuestPool>(arg0);
        let v1 = registrar_policy_mut(arg0);
        assert!(0x2::vec_set::length<0x2::object::ID>(&v1.active_caps) < 16, 33);
        let v2 = RegistrarCap{
            id      : 0x2::object::new(arg2),
            pool_id : v0,
        };
        let v3 = 0x2::object::id<RegistrarCap>(&v2);
        0x2::vec_set::insert<0x2::object::ID>(&mut v1.active_caps, v3);
        let v4 = RegistrarCapIssued{
            pool_id   : v0,
            cap_id    : v3,
            actor     : 0x2::tx_context::sender(arg2),
            recipient : arg1,
        };
        0x2::event::emit<RegistrarCapIssued>(v4);
        0x2::transfer::transfer<RegistrarCap>(v2, arg1);
    }

    fun new_pool(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : QuestPool {
        QuestPool{
            id            : 0x2::object::new(arg2),
            admin         : arg0,
            pending_admin : @0x0,
            signer_pubkey : arg1,
            vault         : 0x2::balance::zero<0x2::sui::SUI>(),
            quests        : 0x2::table::new<vector<u8>, QuestConfig>(arg2),
            positions     : 0x2::table::new<vector<u8>, VestingPosition>(arg2),
        }
    }

    public fun new_schedule(arg0: u8, arg1: u64, arg2: bool) : VestingSchedule {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 1);
        VestingSchedule{
            tranches       : arg0,
            interval_ms    : arg1,
            first_at_claim : arg2,
        }
    }

    public fun new_tier(arg0: u64, arg1: VestingSchedule) : QuestTier {
        assert!(arg0 > 0, 7);
        QuestTier{
            amount_per_claim : arg0,
            schedule         : arg1,
        }
    }

    public fun pause_quest_as_registrar(arg0: &mut QuestPool, arg1: &RegistrarCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_managed_registrar(arg0, arg1, arg2);
        let v0 = borrow_quest_mut(arg0, arg2);
        assert!(!v0.paused, 32);
        v0.paused = true;
        let v1 = QuestPaused{
            quest_id : arg2,
            paused   : true,
        };
        0x2::event::emit<QuestPaused>(v1);
        let v2 = RegistrarQuestPaused{
            pool_id  : 0x2::object::id<QuestPool>(arg0),
            cap_id   : 0x2::object::id<RegistrarCap>(arg1),
            actor    : 0x2::tx_context::sender(arg3),
            quest_id : arg2,
        };
        0x2::event::emit<RegistrarQuestPaused>(v2);
    }

    public fun pending_admin(arg0: &QuestPool) : address {
        arg0.pending_admin
    }

    public fun pool_id_bytes(arg0: &QuestPool) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun position_collected(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        borrow_position(arg0, arg1).collected
    }

    public fun position_key(arg0: vector<u8>, arg1: address) : vector<u8> {
        let v0 = b"YOSO_QUEST_POSITION_V1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x2::hash::blake2b256(&v0)
    }

    public fun position_next_window(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        borrow_position(arg0, arg1).next_window
    }

    public fun position_start_ms(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        borrow_position(arg0, arg1).start_ms
    }

    public fun position_total(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        borrow_position(arg0, arg1).total
    }

    public fun quest_exists(arg0: &QuestPool, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, QuestConfig>(&arg0.quests, arg1)
    }

    public fun quest_max_budget(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        borrow_quest(arg0, arg1).max_budget
    }

    public fun quest_paused(arg0: &QuestPool, arg1: vector<u8>) : bool {
        borrow_quest(arg0, arg1).paused
    }

    public fun quest_tier_amount(arg0: &QuestPool, arg1: vector<u8>, arg2: u8) : u64 {
        borrow_tier(borrow_quest(arg0, arg1), arg2).amount_per_claim
    }

    public fun quest_tier_count(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        0x1::vector::length<QuestTier>(&borrow_quest(arg0, arg1).tiers)
    }

    public fun quest_tier_schedule(arg0: &QuestPool, arg1: vector<u8>, arg2: u8) : VestingSchedule {
        borrow_tier(borrow_quest(arg0, arg1), arg2).schedule
    }

    public fun quest_total_claimed(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        borrow_quest(arg0, arg1).total_claimed
    }

    public fun raise_budget_as_registrar(arg0: &mut QuestPool, arg1: &RegistrarCap, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_managed_registrar(arg0, arg1, arg2);
        assert!(arg3 > 0, 7);
        let v0 = registrar_policy(arg0).limits.max_budget_per_quest;
        let v1 = borrow_quest(arg0, arg2).max_budget;
        assert!(v1 <= v0 && arg3 <= v0 - v1, 28);
        spend_registrar_allowance(arg0, arg3);
        let v2 = v1 + arg3;
        let v3 = borrow_quest_mut(arg0, arg2);
        v3.max_budget = v2;
        let v4 = RegistrarBudgetRaised{
            pool_id             : 0x2::object::id<QuestPool>(arg0),
            cap_id              : 0x2::object::id<RegistrarCap>(arg1),
            actor               : 0x2::tx_context::sender(arg4),
            quest_id            : arg2,
            previous_budget     : v1,
            max_budget          : v2,
            remaining_allowance : registrar_allowance(arg0),
        };
        0x2::event::emit<RegistrarBudgetRaised>(v4);
    }

    public fun register_quest(arg0: &mut QuestPool, arg1: vector<u8>, arg2: vector<QuestTier>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(0x1::vector::length<QuestTier>(&arg2) > 0, 6);
        assert!(arg3 > 0, 7);
        assert!(!0x2::table::contains<vector<u8>, QuestConfig>(&arg0.quests, arg1), 3);
        let v0 = QuestConfig{
            tiers         : arg2,
            max_budget    : arg3,
            total_claimed : 0,
            paused        : false,
        };
        0x2::table::add<vector<u8>, QuestConfig>(&mut arg0.quests, arg1, v0);
        let v1 = QuestRegistered{
            quest_id   : arg1,
            tier_count : 0x1::vector::length<QuestTier>(&arg2),
            max_budget : arg3,
        };
        0x2::event::emit<QuestRegistered>(v1);
    }

    public fun register_quest_as_registrar(arg0: &mut QuestPool, arg1: &RegistrarCap, arg2: vector<u8>, arg3: vector<QuestTier>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_registrar(arg0, arg1);
        let v0 = registrar_policy(arg0).limits;
        assert!(0x1::vector::length<u8>(&arg2) <= v0.max_id_len, 25);
        assert!(0x1::vector::length<u8>(&arg2) >= 0x1::vector::length<u8>(&v0.id_prefix), 24);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0.id_prefix)) {
            assert!(*0x1::vector::borrow<u8>(&arg2, v1) == *0x1::vector::borrow<u8>(&v0.id_prefix, v1), 24);
            v1 = v1 + 1;
        };
        assert!(!quest_exists(arg0, arg2), 3);
        check_registrar_tiers(&v0, &arg3, 0);
        assert!(arg4 > 0, 7);
        assert!(arg4 <= v0.max_budget_per_quest, 28);
        spend_registrar_allowance(arg0, arg4);
        let v2 = QuestConfig{
            tiers         : arg3,
            max_budget    : arg4,
            total_claimed : 0,
            paused        : false,
        };
        0x2::table::add<vector<u8>, QuestConfig>(&mut arg0.quests, arg2, v2);
        let v3 = RegistrarManagedKey{quest_id: arg2};
        0x2::dynamic_field::add<RegistrarManagedKey, bool>(&mut arg0.id, v3, true);
        let v4 = QuestRegistered{
            quest_id   : arg2,
            tier_count : 0x1::vector::length<QuestTier>(&arg3),
            max_budget : arg4,
        };
        0x2::event::emit<QuestRegistered>(v4);
        let v5 = RegistrarQuestRegistered{
            pool_id             : 0x2::object::id<QuestPool>(arg0),
            cap_id              : 0x2::object::id<RegistrarCap>(arg1),
            actor               : 0x2::tx_context::sender(arg5),
            quest_id            : arg2,
            max_budget          : arg4,
            remaining_allowance : registrar_allowance(arg0),
        };
        0x2::event::emit<RegistrarQuestRegistered>(v5);
    }

    public fun registrar_active_caps(arg0: &QuestPool) : vector<0x2::object::ID> {
        0x2::vec_set::into_keys<0x2::object::ID>(registrar_policy(arg0).active_caps)
    }

    public fun registrar_allowance(arg0: &QuestPool) : u64 {
        registrar_policy(arg0).remaining_allowance
    }

    public fun registrar_cap_is_active(arg0: &QuestPool, arg1: 0x2::object::ID) : bool {
        has_registrar_policy(arg0) && 0x2::vec_set::contains<0x2::object::ID>(&registrar_policy(arg0).active_caps, &arg1)
    }

    public fun registrar_cap_pool(arg0: &RegistrarCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun registrar_limits(arg0: &QuestPool) : (u64, u64, u64, vector<u8>, u64) {
        let v0 = &registrar_policy(arg0).limits;
        (v0.max_tiers, v0.max_tier_amount, v0.max_budget_per_quest, v0.id_prefix, v0.max_id_len)
    }

    fun registrar_policy(arg0: &QuestPool) : &RegistrarPolicy {
        assert!(has_registrar_policy(arg0), 19);
        let v0 = RegistrarPolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow<RegistrarPolicyKey, RegistrarPolicy>(&arg0.id, v0)
    }

    fun registrar_policy_mut(arg0: &mut QuestPool) : &mut RegistrarPolicy {
        assert!(has_registrar_policy(arg0), 19);
        let v0 = RegistrarPolicyKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RegistrarPolicyKey, RegistrarPolicy>(&mut arg0.id, v0)
    }

    public fun revoke_all_registrar_caps(arg0: &mut QuestPool, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = registrar_policy_mut(arg0);
        v0.active_caps = 0x2::vec_set::empty<0x2::object::ID>();
        let v1 = 0x2::vec_set::into_keys<0x2::object::ID>(v0.active_caps);
        0x1::vector::reverse<0x2::object::ID>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = RegistrarCapRevoked{
                pool_id : 0x2::object::id<QuestPool>(arg0),
                cap_id  : 0x1::vector::pop_back<0x2::object::ID>(&mut v1),
                actor   : 0x2::tx_context::sender(arg1),
            };
            0x2::event::emit<RegistrarCapRevoked>(v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
    }

    public fun revoke_registrar_cap(arg0: &mut QuestPool, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = registrar_policy_mut(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v0.active_caps, &arg1), 23);
        0x2::vec_set::remove<0x2::object::ID>(&mut v0.active_caps, &arg1);
        let v1 = RegistrarCapRevoked{
            pool_id : 0x2::object::id<QuestPool>(arg0),
            cap_id  : arg1,
            actor   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RegistrarCapRevoked>(v1);
    }

    public fun rotate_signer_pubkey(arg0: &mut QuestPool, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 15);
        arg0.signer_pubkey = arg1;
        let v0 = SignerRotated{
            old_pubkey : arg0.signer_pubkey,
            new_pubkey : arg1,
        };
        0x2::event::emit<SignerRotated>(v0);
    }

    public fun schedule_first_at_claim(arg0: &VestingSchedule) : bool {
        arg0.first_at_claim
    }

    public fun schedule_interval_ms(arg0: &VestingSchedule) : u64 {
        arg0.interval_ms
    }

    public fun schedule_tranches(arg0: &VestingSchedule) : u8 {
        arg0.tranches
    }

    public fun set_pending_admin(arg0: &mut QuestPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 17);
        arg0.pending_admin = arg1;
        let v0 = AdminHandoverProposed{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminHandoverProposed>(v0);
    }

    public fun set_quest_paused(arg0: &mut QuestPool, arg1: vector<u8>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        borrow_quest_mut(arg0, arg1).paused = arg2;
        let v0 = QuestPaused{
            quest_id : arg1,
            paused   : arg2,
        };
        0x2::event::emit<QuestPaused>(v0);
    }

    public fun set_registrar_allowance(arg0: &mut QuestPool, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = registrar_policy_mut(arg0);
        v0.remaining_allowance = arg1;
        let v1 = RegistrarAllowanceChanged{
            pool_id   : 0x2::object::id<QuestPool>(arg0),
            actor     : 0x2::tx_context::sender(arg2),
            previous  : v0.remaining_allowance,
            remaining : arg1,
            increment : false,
        };
        0x2::event::emit<RegistrarAllowanceChanged>(v1);
    }

    public fun set_registrar_limits(arg0: &mut QuestPool, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg6);
        let v0 = checked_registrar_limits(arg1, arg2, arg3, arg4, arg5);
        let v1 = registrar_policy_mut(arg0);
        v1.limits = v0;
        let v2 = RegistrarLimitsChanged{
            pool_id     : 0x2::object::id<QuestPool>(arg0),
            actor       : 0x2::tx_context::sender(arg6),
            initialized : false,
            limits      : v0,
        };
        0x2::event::emit<RegistrarLimitsChanged>(v2);
    }

    public fun signer_pubkey(arg0: &QuestPool) : vector<u8> {
        arg0.signer_pubkey
    }

    fun spend_registrar_allowance(arg0: &mut QuestPool, arg1: u64) {
        let v0 = registrar_policy_mut(arg0);
        assert!(arg1 <= v0.remaining_allowance, 29);
        v0.remaining_allowance = v0.remaining_allowance - arg1;
    }

    public fun steps_at(arg0: u64, arg1: &VestingSchedule, arg2: u64) : u64 {
        if (arg2 < arg0) {
            return 0
        };
        let v0 = (arg2 - arg0) / arg1.interval_ms;
        let v1 = v0;
        if (arg1.first_at_claim) {
            v1 = v0 + 1;
        };
        v1
    }

    public fun tranche_amount(arg0: u64, arg1: u8, arg2: u64) : u64 {
        let v0 = (arg1 as u64);
        if (arg2 + 1 == v0) {
            arg0 - arg0 / v0 * (v0 - 1)
        } else {
            arg0 / v0
        }
    }

    public fun update_quest(arg0: &mut QuestPool, arg1: vector<u8>, arg2: vector<QuestTier>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(0x1::vector::length<QuestTier>(&arg2) > 0, 6);
        assert!(arg3 > 0, 7);
        let v0 = borrow_quest_mut(arg0, arg1);
        v0.tiers = arg2;
        v0.max_budget = arg3;
        let v1 = QuestUpdated{
            quest_id   : arg1,
            tier_count : 0x1::vector::length<QuestTier>(&arg2),
            max_budget : arg3,
        };
        0x2::event::emit<QuestUpdated>(v1);
    }

    public fun vault_value(arg0: &QuestPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    public fun verify_claim_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(&arg2, &arg0, &arg1)
    }

    fun window_claimable(arg0: &VestingPosition, arg1: u64) : u64 {
        let v0 = steps_at(arg0.start_ms, &arg0.schedule, arg1);
        if (v0 == 0 || v0 > (arg0.schedule.tranches as u64)) {
            return 0
        };
        let v1 = v0 - 1;
        if (v1 < arg0.next_window) {
            return 0
        };
        tranche_amount(arg0.total, arg0.schedule.tranches, v1)
    }

    public fun withdraw(arg0: &mut QuestPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg1 > 0, 7);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.vault), 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg3), arg2);
        let v0 = Withdrawn{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

