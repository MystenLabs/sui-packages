module 0x44f3638b550df5d93c68b836e441da5a3d818f783f4b4222b29fc8acf9e53cac::deed {
    struct Deed has key {
        id: 0x2::object::UID,
        tier: u8,
        minted_at: u64,
        version: u64,
    }

    struct Commitment has drop, store {
        user: address,
        tier: u8,
        commit_amount: u64,
        remaining_amount: u64,
        committed_at: u64,
        purchased: bool,
        inviter: address,
    }

    struct DeedContract has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        pending_owner: address,
        total_minted: u64,
        total_burned: u64,
        current_phase: u8,
        phase_start_time: u64,
        commit_period_duration: u64,
        purchase_period_duration: u64,
        refund_period_duration: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        commitments: 0x2::table::Table<address, Commitment>,
        total_commits_per_tier: vector<u64>,
        total_purchases_per_tier: vector<u64>,
        commits_per_inviter: 0x2::table::Table<address, u64>,
        purchases_per_inviter: 0x2::table::Table<address, u64>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        contract_id: address,
    }

    struct PhaseStarted has copy, drop {
        phase: u8,
        start_time: u64,
    }

    struct CommitMade has copy, drop {
        user: address,
        tier: u8,
        amount: u64,
        inviter: address,
        timestamp: u64,
    }

    struct PurchaseCompleted has copy, drop {
        user: address,
        tier: u8,
        amount: u64,
        deed_id: address,
        timestamp: u64,
    }

    struct RefundIssued has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct DeedBurned has copy, drop {
        deed_id: address,
        tier: u8,
        timestamp: u64,
    }

    struct OwnershipTransferInitiated has copy, drop {
        current_owner: address,
        pending_owner: address,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct EmergencyWithdrawal has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    public entry fun accept_ownership(arg0: &mut DeedContract, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.pending_owner, 2);
        arg0.owner = v0;
        arg0.pending_owner = @0x0;
        let v1 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : v0,
        };
        0x2::event::emit<OwnershipTransferred>(v1);
    }

    public entry fun burn_deed(arg0: &mut DeedContract, arg1: Deed, arg2: &0x2::clock::Clock) {
        arg0.total_burned = arg0.total_burned + 1;
        let v0 = DeedBurned{
            deed_id   : 0x2::object::uid_to_address(&arg1.id),
            tier      : arg1.tier,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DeedBurned>(v0);
        let Deed {
            id        : v1,
            tier      : _,
            minted_at : _,
            version   : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    fun calculate_commit_amount(arg0: u8) : u64 {
        get_tier_price(arg0) * 10 / 100
    }

    fun calculate_remaining_amount(arg0: u8) : u64 {
        get_tier_price(arg0) * 90 / 100
    }

    fun commit_internal(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_phase_active(arg0, arg4, arg2), 9);
        assert!(!0x2::table::contains<address, Commitment>(&arg0.commitments, v0), 7);
        assert!(arg0.total_minted < 100000, 13);
        let v1 = calculate_commit_amount(arg2);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= v1, 5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v2 = Commitment{
            user             : v0,
            tier             : arg2,
            commit_amount    : v1,
            remaining_amount : calculate_remaining_amount(arg2),
            committed_at     : 0x2::clock::timestamp_ms(arg4),
            purchased        : false,
            inviter          : arg3,
        };
        0x2::table::add<address, Commitment>(&mut arg0.commitments, v0, v2);
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_commits_per_tier, (arg2 as u64) - 1);
        *v3 = *v3 + 1;
        if (0x2::table::contains<address, u64>(&arg0.commits_per_inviter, arg3)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.commits_per_inviter, arg3);
            *v4 = *v4 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.commits_per_inviter, arg3, 1);
        };
        let v5 = CommitMade{
            user      : v0,
            tier      : arg2,
            amount    : v1,
            inviter   : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CommitMade>(v5);
    }

    public entry fun commit_private_tier_1(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        commit_internal(arg0, arg1, 1, arg2, arg3, arg4);
    }

    public entry fun commit_private_tier_2(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        commit_internal(arg0, arg1, 2, arg2, arg3, arg4);
    }

    public entry fun commit_private_tier_3(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        commit_internal(arg0, arg1, 3, arg2, arg3, arg4);
    }

    public entry fun commit_public(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        commit_internal(arg0, arg1, 4, arg2, arg3, arg4);
    }

    public entry fun emergency_withdraw(arg0: &mut DeedContract, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance);
        assert!(v0 > 0, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v0, arg2), arg0.owner);
        let v1 = EmergencyWithdrawal{
            amount    : v0,
            timestamp : 0,
        };
        0x2::event::emit<EmergencyWithdrawal>(v1);
    }

    public fun get_balance(arg0: &DeedContract) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun get_commitment(arg0: &DeedContract, arg1: address) : (bool, u8, u64, u64, bool) {
        if (0x2::table::contains<address, Commitment>(&arg0.commitments, arg1)) {
            let v5 = 0x2::table::borrow<address, Commitment>(&arg0.commitments, arg1);
            (true, v5.tier, v5.commit_amount, v5.remaining_amount, v5.purchased)
        } else {
            (false, 0, 0, 0, false)
        }
    }

    public fun get_contract_info(arg0: &DeedContract) : (u64, u64, u64, u8, u64) {
        (arg0.version, arg0.total_minted, arg0.total_burned, arg0.current_phase, arg0.phase_start_time)
    }

    public fun get_inviter_stats(arg0: &DeedContract, arg1: address) : (u64, u64) {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.commits_per_inviter, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.commits_per_inviter, arg1)
        } else {
            0
        };
        let v1 = if (0x2::table::contains<address, u64>(&arg0.purchases_per_inviter, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.purchases_per_inviter, arg1)
        } else {
            0
        };
        (v0, v1)
    }

    public fun get_supply_info(arg0: &DeedContract) : (u64, u64, u64) {
        (arg0.total_minted, arg0.total_burned, 100000)
    }

    public fun get_tier_price(arg0: u8) : u64 {
        if (arg0 == 1) {
            179000000
        } else if (arg0 == 2) {
            239000000
        } else if (arg0 == 3) {
            290000000
        } else {
            assert!(arg0 == 4, 4);
            359000000
        }
    }

    public fun get_tier_prices() : (u64, u64, u64, u64) {
        (179000000, 239000000, 290000000, 359000000)
    }

    public fun get_tier_stats(arg0: &DeedContract) : (vector<u64>, vector<u64>) {
        (arg0.total_commits_per_tier, arg0.total_purchases_per_tier)
    }

    public fun get_time_periods(arg0: &DeedContract) : (u64, u64, u64) {
        (arg0.commit_period_duration, arg0.purchase_period_duration, arg0.refund_period_duration)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeedContract{
            id                       : 0x2::object::new(arg0),
            version                  : 1,
            owner                    : 0x2::tx_context::sender(arg0),
            pending_owner            : @0x0,
            total_minted             : 0,
            total_burned             : 0,
            current_phase            : 0,
            phase_start_time         : 0,
            commit_period_duration   : 604800000,
            purchase_period_duration : 1209600000,
            refund_period_duration   : 2592000000,
            balance                  : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            commitments              : 0x2::table::new<address, Commitment>(arg0),
            total_commits_per_tier   : vector[0, 0, 0, 0],
            total_purchases_per_tier : vector[0, 0, 0, 0],
            commits_per_inviter      : 0x2::table::new<address, u64>(arg0),
            purchases_per_inviter    : 0x2::table::new<address, u64>(arg0),
        };
        let v1 = AdminCap{
            id          : 0x2::object::new(arg0),
            contract_id : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::transfer::share_object<DeedContract>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_phase_active(arg0: &DeedContract, arg1: &0x2::clock::Clock, arg2: u8) : bool {
        if (arg0.current_phase != arg2) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg2 == 0) {
            return false
        };
        v0 >= arg0.phase_start_time && v0 <= arg0.phase_start_time + arg0.commit_period_duration
    }

    fun is_purchase_period_active(arg0: &DeedContract, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.phase_start_time + arg0.commit_period_duration;
        v0 > v1 && v0 <= v1 + arg0.purchase_period_duration
    }

    fun is_refund_period_active(arg0: &DeedContract, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.phase_start_time + arg0.commit_period_duration;
        v0 > v1 && v0 <= v1 + arg0.refund_period_duration
    }

    public entry fun purchase(arg0: &mut DeedContract, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_purchase_period_active(arg0, arg2), 11);
        assert!(0x2::table::contains<address, Commitment>(&arg0.commitments, v0), 6);
        let v1 = 0x2::table::borrow_mut<address, Commitment>(&mut arg0.commitments, v0);
        assert!(!v1.purchased, 8);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= v1.remaining_amount, 5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        v1.purchased = true;
        let v2 = Deed{
            id        : 0x2::object::new(arg3),
            tier      : v1.tier,
            minted_at : 0x2::clock::timestamp_ms(arg2),
            version   : arg0.version,
        };
        arg0.total_minted = arg0.total_minted + 1;
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_purchases_per_tier, (v1.tier as u64) - 1);
        *v3 = *v3 + 1;
        if (0x2::table::contains<address, u64>(&arg0.purchases_per_inviter, v1.inviter)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.purchases_per_inviter, v1.inviter);
            *v4 = *v4 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.purchases_per_inviter, v1.inviter, 1);
        };
        let v5 = PurchaseCompleted{
            user      : v0,
            tier      : v1.tier,
            amount    : v1.remaining_amount,
            deed_id   : 0x2::object::uid_to_address(&v2.id),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PurchaseCompleted>(v5);
        0x2::transfer::transfer<Deed>(v2, v0);
    }

    public entry fun request_refund(arg0: &mut DeedContract, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_refund_period_active(arg0, arg1), 12);
        assert!(0x2::table::contains<address, Commitment>(&arg0.commitments, v0), 6);
        let v1 = 0x2::table::borrow<address, Commitment>(&arg0.commitments, v0);
        assert!(!v1.purchased, 14);
        let v2 = v1.commit_amount;
        0x2::table::remove<address, Commitment>(&mut arg0.commitments, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v2, arg2), v0);
        let v3 = RefundIssued{
            user      : v0,
            amount    : v2,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RefundIssued>(v3);
    }

    public entry fun start_phase(arg0: &mut DeedContract, arg1: &AdminCap, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else if (arg2 == 3) {
            true
        } else {
            arg2 == 4
        };
        assert!(v0, 3);
        arg0.current_phase = arg2;
        arg0.phase_start_time = 0x2::clock::timestamp_ms(arg3);
        let v1 = PhaseStarted{
            phase      : arg2,
            start_time : arg0.phase_start_time,
        };
        0x2::event::emit<PhaseStarted>(v1);
    }

    public entry fun stop_phase(arg0: &mut DeedContract, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.current_phase = 0;
    }

    public entry fun transfer_ownership(arg0: &mut DeedContract, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.pending_owner = arg2;
        let v0 = OwnershipTransferInitiated{
            current_owner : arg0.owner,
            pending_owner : arg2,
        };
        0x2::event::emit<OwnershipTransferInitiated>(v0);
    }

    public entry fun update_time_periods(arg0: &mut DeedContract, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        arg0.commit_period_duration = arg2;
        arg0.purchase_period_duration = arg3;
        arg0.refund_period_duration = arg4;
    }

    // decompiled from Move bytecode v6
}

