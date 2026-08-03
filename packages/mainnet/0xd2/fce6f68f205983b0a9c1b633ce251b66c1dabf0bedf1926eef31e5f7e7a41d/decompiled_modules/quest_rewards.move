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

    fun assert_admin(arg0: &QuestPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
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

    public fun has_position(arg0: &QuestPool, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, VestingPosition>(&arg0.positions, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
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

    public fun quest_total_claimed(arg0: &QuestPool, arg1: vector<u8>) : u64 {
        borrow_quest(arg0, arg1).total_claimed
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

    public fun signer_pubkey(arg0: &QuestPool) : vector<u8> {
        arg0.signer_pubkey
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

