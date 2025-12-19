module 0x301f28ce09bc26efeb96c72820cf89c3886b5beb0f1affe3515229864a98ea2c::locker {
    struct MultisigConfig has key {
        id: 0x2::object::UID,
        signers: 0x2::vec_set::VecSet<address>,
        required_signatures: u64,
    }

    struct EmergencyProposal has key {
        id: 0x2::object::UID,
        enable_emergency: bool,
        signatures: 0x2::vec_set::VecSet<address>,
        created_at: u64,
        timelock_end: u64,
        executed: bool,
    }

    struct TreasuryProposal has key {
        id: 0x2::object::UID,
        new_treasury: address,
        signatures: 0x2::vec_set::VecSet<address>,
        created_at: u64,
        timelock_end: u64,
        executed: bool,
    }

    struct LockerConfig has key {
        id: 0x2::object::UID,
        base_service_fee: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        tier_1_discount: u64,
        tier_2_discount: u64,
        tier_3_discount: u64,
        tier_4_discount: u64,
        total_locks_created: u64,
        total_value_locked: u64,
        active_locks: u64,
        emergency_mode: bool,
        emergency_activated_at: u64,
        treasury: address,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LiquidityLock<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        locked_balance: 0x2::balance::Balance<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>,
        unlock_timestamp: u64,
        created_at: u64,
        initial_amount: u64,
        pool_id: 0x2::object::ID,
        owner: address,
        allow_partial_unlock: bool,
        description: vector<u8>,
        times_extended: u64,
        last_extended_at: u64,
    }

    struct LockReceipt has store, key {
        id: 0x2::object::UID,
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        unlock_timestamp: u64,
        created_at: u64,
    }

    struct LiquidityLocked has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        unlock_timestamp: u64,
        fee_paid: u64,
        duration: u64,
        discount_applied: u64,
    }

    struct LiquidityUnlocked has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        timestamp: u64,
        was_partial: bool,
        was_emergency: bool,
    }

    struct LockExtended has copy, drop {
        lock_id: 0x2::object::ID,
        old_unlock_timestamp: u64,
        new_unlock_timestamp: u64,
        extension_duration: u64,
        fee_paid: u64,
    }

    struct LockTransferred has copy, drop {
        lock_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct FeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct DiscountTiersUpdated has copy, drop {
        tier_1: u64,
        tier_2: u64,
        tier_3: u64,
        tier_4: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct EmergencyProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        enable_emergency: bool,
        created_at: u64,
        timelock_end: u64,
        created_by: address,
    }

    struct EmergencyProposalSigned has copy, drop {
        proposal_id: 0x2::object::ID,
        signer: address,
        current_signatures: u64,
        required_signatures: u64,
    }

    struct EmergencyProposalExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        emergency_enabled: bool,
        executed_at: u64,
        executed_by: address,
    }

    struct EmergencyProposalCancelled has copy, drop {
        proposal_id: 0x2::object::ID,
        cancelled_at: u64,
    }

    struct MultisigSignerAdded has copy, drop {
        signer: address,
        total_signers: u64,
    }

    struct MultisigSignerRemoved has copy, drop {
        signer: address,
        total_signers: u64,
    }

    struct MultisigThresholdUpdated has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
    }

    struct TreasuryProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        new_treasury: address,
        created_at: u64,
        timelock_end: u64,
        created_by: address,
    }

    struct TreasuryProposalSigned has copy, drop {
        proposal_id: 0x2::object::ID,
        signer: address,
        current_signatures: u64,
        required_signatures: u64,
    }

    struct TreasuryProposalExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        old_treasury: address,
        new_treasury: address,
        executed_at: u64,
        executed_by: address,
    }

    struct TreasuryProposalCancelled has copy, drop {
        proposal_id: 0x2::object::ID,
        cancelled_at: u64,
    }

    public entry fun add_signer(arg0: &AdminCap, arg1: &mut MultisigConfig, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg1.signers, &arg2), 109);
        assert!(0x2::vec_set::length<address>(&arg1.signers) < 10, 108);
        0x2::vec_set::insert<address>(&mut arg1.signers, arg2);
        let v0 = MultisigSignerAdded{
            signer        : arg2,
            total_signers : 0x2::vec_set::length<address>(&arg1.signers),
        };
        0x2::event::emit<MultisigSignerAdded>(v0);
    }

    public fun calculate_fee(arg0: &LockerConfig, arg1: u64) : (u64, u64) {
        let v0 = arg0.base_service_fee;
        let v1 = get_discount_for_duration(arg0, arg1);
        (v0 - v0 * v1 / 10000, v1)
    }

    public entry fun cancel_expired_proposal(arg0: EmergencyProposal, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.executed || v0 >= arg0.timelock_end + 604800000, 104);
        let EmergencyProposal {
            id               : v1,
            enable_emergency : _,
            signatures       : _,
            created_at       : _,
            timelock_end     : _,
            executed         : _,
        } = arg0;
        0x2::object::delete(v1);
        let v7 = EmergencyProposalCancelled{
            proposal_id  : 0x2::object::id<EmergencyProposal>(&arg0),
            cancelled_at : v0,
        };
        0x2::event::emit<EmergencyProposalCancelled>(v7);
    }

    public entry fun cancel_expired_treasury_proposal(arg0: TreasuryProposal, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.executed || v0 >= arg0.timelock_end + 604800000, 104);
        let TreasuryProposal {
            id           : v1,
            new_treasury : _,
            signatures   : _,
            created_at   : _,
            timelock_end : _,
            executed     : _,
        } = arg0;
        0x2::object::delete(v1);
        let v7 = TreasuryProposalCancelled{
            proposal_id  : 0x2::object::id<TreasuryProposal>(&arg0),
            cancelled_at : v0,
        };
        0x2::event::emit<TreasuryProposalCancelled>(v7);
    }

    public entry fun create_config(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LockerConfig{
            id                     : 0x2::object::new(arg3),
            base_service_fee       : arg1,
            fee_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            tier_1_discount        : 500,
            tier_2_discount        : 1000,
            tier_3_discount        : 1500,
            tier_4_discount        : 2500,
            total_locks_created    : 0,
            total_value_locked     : 0,
            active_locks           : 0,
            emergency_mode         : false,
            emergency_activated_at : 0,
            treasury               : arg2,
            admin                  : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<LockerConfig>(v0);
    }

    public entry fun create_emergency_proposal(arg0: &MultisigConfig, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.signers, &v0), 100);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + 172800000;
        let v3 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v3, v0);
        let v4 = EmergencyProposal{
            id               : 0x2::object::new(arg3),
            enable_emergency : arg1,
            signatures       : v3,
            created_at       : v1,
            timelock_end     : v2,
            executed         : false,
        };
        let v5 = 0x2::object::id<EmergencyProposal>(&v4);
        let v6 = EmergencyProposalCreated{
            proposal_id      : v5,
            enable_emergency : arg1,
            created_at       : v1,
            timelock_end     : v2,
            created_by       : v0,
        };
        0x2::event::emit<EmergencyProposalCreated>(v6);
        let v7 = EmergencyProposalSigned{
            proposal_id         : v5,
            signer              : v0,
            current_signatures  : 1,
            required_signatures : arg0.required_signatures,
        };
        0x2::event::emit<EmergencyProposalSigned>(v7);
        0x2::transfer::share_object<EmergencyProposal>(v4);
    }

    public entry fun create_multisig_config(arg0: &AdminCap, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 >= 2, 108);
        assert!(v0 <= 10, 108);
        assert!(arg2 >= 2, 108);
        assert!(arg2 <= v0, 108);
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            assert!(!0x2::vec_set::contains<address>(&v1, &v3), 109);
            0x2::vec_set::insert<address>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = MultisigConfig{
            id                  : 0x2::object::new(arg3),
            signers             : v1,
            required_signatures : arg2,
        };
        0x2::transfer::share_object<MultisigConfig>(v4);
    }

    public entry fun create_treasury_proposal(arg0: &MultisigConfig, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.signers, &v0), 100);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + 172800000;
        let v3 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v3, v0);
        let v4 = TreasuryProposal{
            id           : 0x2::object::new(arg3),
            new_treasury : arg1,
            signatures   : v3,
            created_at   : v1,
            timelock_end : v2,
            executed     : false,
        };
        let v5 = 0x2::object::id<TreasuryProposal>(&v4);
        let v6 = TreasuryProposalCreated{
            proposal_id  : v5,
            new_treasury : arg1,
            created_at   : v1,
            timelock_end : v2,
            created_by   : v0,
        };
        0x2::event::emit<TreasuryProposalCreated>(v6);
        let v7 = TreasuryProposalSigned{
            proposal_id         : v5,
            signer              : v0,
            current_signatures  : 1,
            required_signatures : arg0.required_signatures,
        };
        0x2::event::emit<TreasuryProposalSigned>(v7);
        0x2::transfer::share_object<TreasuryProposal>(v4);
    }

    public entry fun execute_emergency_proposal(arg0: &MultisigConfig, arg1: &mut LockerConfig, arg2: &mut EmergencyProposal, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.signers, &v0), 100);
        assert!(!arg2.executed, 103);
        assert!(v1 >= arg2.timelock_end, 105);
        assert!(v1 < arg2.timelock_end + 604800000, 103);
        assert!(0x2::vec_set::length<address>(&arg2.signatures) >= arg0.required_signatures, 102);
        arg2.executed = true;
        arg1.emergency_mode = arg2.enable_emergency;
        if (arg2.enable_emergency) {
            arg1.emergency_activated_at = v1;
        } else {
            arg1.emergency_activated_at = 0;
        };
        let v2 = EmergencyProposalExecuted{
            proposal_id       : 0x2::object::id<EmergencyProposal>(arg2),
            emergency_enabled : arg2.enable_emergency,
            executed_at       : v1,
            executed_by       : v0,
        };
        0x2::event::emit<EmergencyProposalExecuted>(v2);
    }

    public entry fun execute_treasury_proposal(arg0: &MultisigConfig, arg1: &mut LockerConfig, arg2: &mut TreasuryProposal, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.signers, &v0), 100);
        assert!(!arg2.executed, 103);
        assert!(v1 >= arg2.timelock_end, 105);
        assert!(v1 < arg2.timelock_end + 604800000, 103);
        assert!(0x2::vec_set::length<address>(&arg2.signatures) >= arg0.required_signatures, 102);
        arg2.executed = true;
        arg1.treasury = arg2.new_treasury;
        let v2 = TreasuryProposalExecuted{
            proposal_id  : 0x2::object::id<TreasuryProposal>(arg2),
            old_treasury : arg1.treasury,
            new_treasury : arg2.new_treasury,
            executed_at  : v1,
            executed_by  : v0,
        };
        0x2::event::emit<TreasuryProposalExecuted>(v2);
    }

    public entry fun extend_lock<T0, T1>(arg0: &mut LockerConfig, arg1: &mut LiquidityLock<T0, T1>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 4);
        assert!(arg3 >= 86400000, 5);
        let v0 = arg1.unlock_timestamp + arg3;
        assert!(v0 - 0x2::clock::timestamp_ms(arg4) <= 126144000000, 1);
        let (v1, _) = calculate_fee(arg0, arg3);
        let v3 = v1 / 2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 0);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        if (v4 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4 - v3, arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.unlock_timestamp = v0;
        arg1.times_extended = arg1.times_extended + 1;
        arg1.last_extended_at = 0x2::clock::timestamp_ms(arg4);
        let v5 = LockExtended{
            lock_id              : 0x2::object::id<LiquidityLock<T0, T1>>(arg1),
            old_unlock_timestamp : arg1.unlock_timestamp,
            new_unlock_timestamp : v0,
            extension_duration   : arg3,
            fee_paid             : v3,
        };
        0x2::event::emit<LockExtended>(v5);
    }

    public fun get_config_info(arg0: &LockerConfig) : (u64, u64, u64, u64, bool, u64, address) {
        (arg0.base_service_fee, arg0.total_locks_created, arg0.total_value_locked, arg0.active_locks, arg0.emergency_mode, arg0.emergency_activated_at, arg0.treasury)
    }

    fun get_discount_for_duration(arg0: &LockerConfig, arg1: u64) : u64 {
        if (arg1 >= 31536000000) {
            arg0.tier_4_discount
        } else if (arg1 >= 15552000000) {
            arg0.tier_3_discount
        } else if (arg1 >= 7776000000) {
            arg0.tier_2_discount
        } else if (arg1 >= 2592000000) {
            arg0.tier_1_discount
        } else {
            0
        }
    }

    public fun get_fee_balance(arg0: &LockerConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    public fun get_lock_info<T0, T1>(arg0: &LiquidityLock<T0, T1>) : (u64, u64, u64, 0x2::object::ID, address, bool) {
        (0x2::balance::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(&arg0.locked_balance), arg0.unlock_timestamp, arg0.created_at, arg0.pool_id, arg0.owner, arg0.allow_partial_unlock)
    }

    public fun get_multisig_info(arg0: &MultisigConfig) : (u64, u64) {
        (0x2::vec_set::length<address>(&arg0.signers), arg0.required_signatures)
    }

    public fun get_proposal_info(arg0: &EmergencyProposal) : (bool, u64, u64, bool) {
        (arg0.enable_emergency, 0x2::vec_set::length<address>(&arg0.signatures), arg0.timelock_end, arg0.executed)
    }

    public fun get_remaining_time<T0, T1>(arg0: &LiquidityLock<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.unlock_timestamp) {
            0
        } else {
            arg0.unlock_timestamp - v0
        }
    }

    public fun get_treasury(arg0: &LockerConfig) : address {
        arg0.treasury
    }

    public fun get_treasury_proposal_info(arg0: &TreasuryProposal) : (address, u64, u64, bool) {
        (arg0.new_treasury, 0x2::vec_set::length<address>(&arg0.signatures), arg0.timelock_end, arg0.executed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_signer(arg0: &MultisigConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.signers, &arg1)
    }

    public fun is_unlocked<T0, T1>(arg0: &LiquidityLock<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_timestamp
    }

    public fun lock_liquidity<T0, T1>(arg0: &mut LockerConfig, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: bool, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (LiquidityLock<T0, T1>, LockReceipt) {
        assert!(arg4 >= 86400000, 1);
        assert!(arg4 <= 126144000000, 1);
        assert!(0x2::coin::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(&arg2) > 0, 3);
        let (v0, v1) = calculate_fee(arg0, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        if (v2 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2 - v0, arg8), 0x2::tx_context::sender(arg8));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v3 = 0x2::clock::timestamp_ms(arg7);
        let v4 = v3 + arg4;
        let v5 = 0x2::coin::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(&arg2);
        let v6 = 0x2::tx_context::sender(arg8);
        let v7 = LiquidityLock<T0, T1>{
            id                   : 0x2::object::new(arg8),
            locked_balance       : 0x2::coin::into_balance<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(arg2),
            unlock_timestamp     : v4,
            created_at           : v3,
            initial_amount       : v5,
            pool_id              : arg1,
            owner                : v6,
            allow_partial_unlock : arg5,
            description          : arg6,
            times_extended       : 0,
            last_extended_at     : 0,
        };
        let v8 = 0x2::object::id<LiquidityLock<T0, T1>>(&v7);
        let v9 = LockReceipt{
            id               : 0x2::object::new(arg8),
            lock_id          : v8,
            pool_id          : arg1,
            owner            : v6,
            amount           : v5,
            unlock_timestamp : v4,
            created_at       : v3,
        };
        arg0.total_locks_created = arg0.total_locks_created + 1;
        arg0.total_value_locked = arg0.total_value_locked + v5;
        arg0.active_locks = arg0.active_locks + 1;
        let v10 = LiquidityLocked{
            lock_id          : v8,
            pool_id          : arg1,
            provider         : v6,
            amount           : v5,
            unlock_timestamp : v4,
            fee_paid         : v0,
            duration         : arg4,
            discount_applied : v1,
        };
        0x2::event::emit<LiquidityLocked>(v10);
        (v7, v9)
    }

    public entry fun lock_liquidity_entry<T0, T1>(arg0: &mut LockerConfig, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: bool, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = lock_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<LiquidityLock<T0, T1>>(v0, v2);
        0x2::transfer::public_transfer<LockReceipt>(v1, v2);
    }

    public fun partial_unlock<T0, T1>(arg0: &mut LockerConfig, arg1: &mut LiquidityLock<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>> {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.emergency_mode;
        assert!(arg1.allow_partial_unlock, 7);
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 4);
        if (!v1) {
            assert!(v0 >= arg1.unlock_timestamp, 2);
        };
        assert!(arg2 > 0 && arg2 < 0x2::balance::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(&arg1.locked_balance), 3);
        arg0.total_value_locked = arg0.total_value_locked - arg2;
        let v2 = LiquidityUnlocked{
            lock_id       : 0x2::object::id<LiquidityLock<T0, T1>>(arg1),
            pool_id       : arg1.pool_id,
            provider      : 0x2::tx_context::sender(arg4),
            amount        : arg2,
            timestamp     : v0,
            was_partial   : true,
            was_emergency : v1,
        };
        0x2::event::emit<LiquidityUnlocked>(v2);
        0x2::coin::from_balance<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(0x2::balance::split<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(&mut arg1.locked_balance, arg2), arg4)
    }

    public entry fun partial_unlock_entry<T0, T1>(arg0: &mut LockerConfig, arg1: &mut LiquidityLock<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = partial_unlock<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun remove_signer(arg0: &AdminCap, arg1: &mut MultisigConfig, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg1.signers, &arg2), 110);
        let v0 = 0x2::vec_set::length<address>(&arg1.signers) - 1;
        assert!(v0 >= 2, 111);
        assert!(v0 >= arg1.required_signatures, 108);
        0x2::vec_set::remove<address>(&mut arg1.signers, &arg2);
        let v1 = MultisigSignerRemoved{
            signer        : arg2,
            total_signers : v0,
        };
        0x2::event::emit<MultisigSignerRemoved>(v1);
    }

    public entry fun sign_emergency_proposal(arg0: &MultisigConfig, arg1: &mut EmergencyProposal, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.signers, &v0), 100);
        assert!(!0x2::vec_set::contains<address>(&arg1.signatures, &v0), 101);
        assert!(!arg1.executed, 103);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.timelock_end + 604800000, 103);
        0x2::vec_set::insert<address>(&mut arg1.signatures, v0);
        let v1 = EmergencyProposalSigned{
            proposal_id         : 0x2::object::id<EmergencyProposal>(arg1),
            signer              : v0,
            current_signatures  : 0x2::vec_set::length<address>(&arg1.signatures),
            required_signatures : arg0.required_signatures,
        };
        0x2::event::emit<EmergencyProposalSigned>(v1);
    }

    public entry fun sign_treasury_proposal(arg0: &MultisigConfig, arg1: &mut TreasuryProposal, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.signers, &v0), 100);
        assert!(!0x2::vec_set::contains<address>(&arg1.signatures, &v0), 101);
        assert!(!arg1.executed, 103);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.timelock_end + 604800000, 103);
        0x2::vec_set::insert<address>(&mut arg1.signatures, v0);
        let v1 = TreasuryProposalSigned{
            proposal_id         : 0x2::object::id<TreasuryProposal>(arg1),
            signer              : v0,
            current_signatures  : 0x2::vec_set::length<address>(&arg1.signatures),
            required_signatures : arg0.required_signatures,
        };
        0x2::event::emit<TreasuryProposalSigned>(v1);
    }

    public entry fun transfer_lock<T0, T1>(arg0: &mut LiquidityLock<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        arg0.owner = arg1;
        let v0 = LockTransferred{
            lock_id : 0x2::object::id<LiquidityLock<T0, T1>>(arg0),
            from    : arg0.owner,
            to      : arg1,
        };
        0x2::event::emit<LockTransferred>(v0);
    }

    public fun unlock_liquidity<T0, T1>(arg0: &mut LockerConfig, arg1: LiquidityLock<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.emergency_mode;
        if (!v1) {
            assert!(v0 >= arg1.unlock_timestamp, 2);
        };
        let v2 = 0x2::balance::value<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(&arg1.locked_balance);
        let LiquidityLock {
            id                   : v3,
            locked_balance       : v4,
            unlock_timestamp     : _,
            created_at           : _,
            initial_amount       : _,
            pool_id              : _,
            owner                : _,
            allow_partial_unlock : _,
            description          : _,
            times_extended       : _,
            last_extended_at     : _,
        } = arg1;
        arg0.total_value_locked = arg0.total_value_locked - v2;
        arg0.active_locks = arg0.active_locks - 1;
        let v14 = LiquidityUnlocked{
            lock_id       : 0x2::object::id<LiquidityLock<T0, T1>>(&arg1),
            pool_id       : arg1.pool_id,
            provider      : 0x2::tx_context::sender(arg3),
            amount        : v2,
            timestamp     : v0,
            was_partial   : false,
            was_emergency : v1,
        };
        0x2::event::emit<LiquidityUnlocked>(v14);
        0x2::object::delete(v3);
        0x2::coin::from_balance<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>(v4, arg3)
    }

    public entry fun unlock_liquidity_entry<T0, T1>(arg0: &mut LockerConfig, arg1: LiquidityLock<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = unlock_liquidity<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin::LP<T0, T1>>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_admin(arg0: &AdminCap, arg1: &mut LockerConfig, arg2: address) {
        arg1.admin = arg2;
    }

    public entry fun update_base_fee(arg0: &AdminCap, arg1: &mut LockerConfig, arg2: u64) {
        arg1.base_service_fee = arg2;
        let v0 = FeeUpdated{
            old_fee : arg1.base_service_fee,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public entry fun update_discount_tiers(arg0: &AdminCap, arg1: &mut LockerConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg2 <= 5000, 6);
        assert!(arg3 <= 5000, 6);
        assert!(arg4 <= 5000, 6);
        assert!(arg5 <= 5000, 6);
        arg1.tier_1_discount = arg2;
        arg1.tier_2_discount = arg3;
        arg1.tier_3_discount = arg4;
        arg1.tier_4_discount = arg5;
        let v0 = DiscountTiersUpdated{
            tier_1 : arg2,
            tier_2 : arg3,
            tier_3 : arg4,
            tier_4 : arg5,
        };
        0x2::event::emit<DiscountTiersUpdated>(v0);
    }

    public entry fun update_threshold(arg0: &AdminCap, arg1: &mut MultisigConfig, arg2: u64) {
        assert!(arg2 >= 2, 108);
        assert!(arg2 <= 0x2::vec_set::length<address>(&arg1.signers), 108);
        arg1.required_signatures = arg2;
        let v0 = MultisigThresholdUpdated{
            old_threshold : arg1.required_signatures,
            new_threshold : arg2,
        };
        0x2::event::emit<MultisigThresholdUpdated>(v0);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut LockerConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_balance);
        assert!(v0 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee_balance, v0), arg2), arg1.treasury);
        let v1 = FeesWithdrawn{
            amount    : v0,
            recipient : arg1.treasury,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

