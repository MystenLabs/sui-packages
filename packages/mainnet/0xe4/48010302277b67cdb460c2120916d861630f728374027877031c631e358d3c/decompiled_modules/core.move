module 0xe448010302277b67cdb460c2120916d861630f728374027877031c631e358d3c::core {
    struct SolvencyRegistry has key {
        id: 0x2::object::UID,
        total_users: u64,
    }

    struct UserProfile has key {
        id: 0x2::object::UID,
        wallet: address,
        handle: 0x1::string::String,
        memwal_account_id: address,
        safe_floor_usdc: u64,
        contacts: 0x2::vec_map::VecMap<address, 0x1::string::String>,
        registered_at_ms: u64,
    }

    struct CooldownVault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        locked_balance: 0x2::balance::Balance<T0>,
        unlock_time_ms: u64,
        trigger_memory_namespace: 0x1::string::String,
    }

    struct ParticipantShare has copy, drop, store {
        debtor: address,
        amount_owed: u64,
        requires_upfront_escrow: bool,
        is_funded: bool,
        is_settled: bool,
        settled_at_ms: u64,
    }

    struct GroupSplitEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        total_bill_amount: u64,
        creator_share: u64,
        escrowed_balance: 0x2::balance::Balance<T0>,
        participants: 0x2::vec_map::VecMap<address, ParticipantShare>,
        pending_upfront: u64,
        is_active: bool,
        is_cancelled: bool,
        created_at_ms: u64,
        funding_deadline_ms: u64,
    }

    struct UserRegisteredEvent has copy, drop {
        wallet: address,
        profile_id: 0x2::object::ID,
        handle: 0x1::string::String,
        memwal_account_id: address,
        safe_floor_usdc: u64,
    }

    struct UserProfileUpdatedEvent has copy, drop {
        wallet: address,
        profile_id: 0x2::object::ID,
        handle: 0x1::string::String,
        memwal_account_id: address,
        safe_floor_usdc: u64,
    }

    struct SplitCreatedEvent has copy, drop {
        split_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        total_amount: u64,
        created_at_ms: u64,
    }

    struct ShareSettledEvent has copy, drop {
        split_id: 0x2::object::ID,
        payer: address,
        recipient: address,
        amount: u64,
        was_escrow_enforced: bool,
        settled_at_ms: u64,
    }

    struct EscrowFundedEvent has copy, drop {
        split_id: 0x2::object::ID,
        payer: address,
        amount: u64,
    }

    struct SplitActivatedEvent has copy, drop {
        split_id: 0x2::object::ID,
        activated_at_ms: u64,
    }

    struct EscrowRefundedEvent has copy, drop {
        split_id: 0x2::object::ID,
        payer: address,
        amount: u64,
    }

    struct CooldownLockedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        unlock_time_ms: u64,
        namespace: 0x1::string::String,
    }

    public fun activate_group_split<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut GroupSplitEscrow<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg4), true);
        assert!(0x2::tx_context::sender(arg4) == arg2.creator, 102);
        let v0 = if (!arg2.is_active) {
            if (!arg2.is_cancelled) {
                if (arg2.pending_upfront == 0) {
                    0x2::clock::timestamp_ms(arg3) <= arg2.funding_deadline_ms
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 108);
        let v1 = 0x2::object::id<GroupSplitEscrow<T0>>(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0x2::vec_map::keys<address, ParticipantShare>(&arg2.participants);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v3)) {
            let v5 = *0x1::vector::borrow<address>(&v3, v4);
            let v6 = 0x2::vec_map::get_mut<address, ParticipantShare>(&mut arg2.participants, &v5);
            if (v6.is_funded) {
                v6.is_settled = true;
                v6.settled_at_ms = v2;
                let v7 = ShareSettledEvent{
                    split_id            : v1,
                    payer               : v5,
                    recipient           : arg2.creator,
                    amount              : v6.amount_owed,
                    was_escrow_enforced : true,
                    settled_at_ms       : v2,
                };
                0x2::event::emit<ShareSettledEvent>(v7);
            };
            v4 = v4 + 1;
        };
        arg2.is_active = true;
        let v8 = 0x2::balance::withdraw_all<T0>(&mut arg2.escrowed_balance);
        if (0x2::balance::value<T0>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg4), arg2.creator);
        } else {
            0x2::balance::destroy_zero<T0>(v8);
        };
        let v9 = SplitActivatedEvent{
            split_id        : v1,
            activated_at_ms : v2,
        };
        0x2::event::emit<SplitActivatedEvent>(v9);
    }

    public fun add_contact(arg0: &mut UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg4), true);
        put_contact(arg0, arg2, arg3);
    }

    fun assert_memory_owner(arg0: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg1: address, arg2: bool) {
        assert!(0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::owner(arg0) == arg1, 112);
        if (arg2) {
            assert!(0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::is_active(arg0) && !0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::is_admin_quarantined(arg0), 112);
        };
    }

    fun assert_onboarded(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: address, arg3: bool) {
        assert!(arg0.wallet == arg2, 102);
        assert_memory_owner(arg1, arg2, arg3);
        assert!(arg0.memwal_account_id == 0x2::object::id_address<0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount>(arg1), 112);
    }

    fun assert_usdc<T0>() {
        assert!(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 110);
    }

    public fun cancel_group_split<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut GroupSplitEscrow<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg3), false);
        assert!(0x2::tx_context::sender(arg3) == arg2.creator, 102);
        assert!(!arg2.is_active, 108);
        arg2.is_cancelled = true;
    }

    public fun create_group_split<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: 0x1::string::String, arg3: u64, arg4: vector<address>, arg5: vector<u64>, arg6: vector<bool>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg8), true);
        valid_text(&arg2, 120);
        let v0 = 0x1::vector::length<address>(&arg4);
        let v1 = if (v0 > 0) {
            if (v0 <= 64) {
                if (0x1::vector::length<u64>(&arg5) == v0) {
                    0x1::vector::length<bool>(&arg6) == v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 106);
        let v2 = 0x2::vec_map::empty<address, ParticipantShare>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < v0) {
            let v6 = *0x1::vector::borrow<address>(&arg4, v3);
            let v7 = *0x1::vector::borrow<u64>(&arg5, v3);
            let v8 = if (v6 != 0x2::tx_context::sender(arg8)) {
                if (v6 != @0x0) {
                    !0x2::vec_map::contains<address, ParticipantShare>(&v2, &v6)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v8, 106);
            assert!(v7 > 0 && v7 <= arg3, 103);
            v4 = v4 + v7;
            if (*0x1::vector::borrow<bool>(&arg6, v3)) {
                v5 = v5 + 1;
            };
            let v9 = ParticipantShare{
                debtor                  : v6,
                amount_owed             : v7,
                requires_upfront_escrow : *0x1::vector::borrow<bool>(&arg6, v3),
                is_funded               : false,
                is_settled              : false,
                settled_at_ms           : 0,
            };
            0x2::vec_map::insert<address, ParticipantShare>(&mut v2, v6, v9);
            v3 = v3 + 1;
        };
        assert!(arg3 > v4, 103);
        let v10 = 0x2::clock::timestamp_ms(arg7);
        let v11 = GroupSplitEscrow<T0>{
            id                  : 0x2::object::new(arg8),
            creator             : 0x2::tx_context::sender(arg8),
            title               : arg2,
            total_bill_amount   : arg3,
            creator_share       : arg3 - v4,
            escrowed_balance    : 0x2::balance::zero<T0>(),
            participants        : v2,
            pending_upfront     : v5,
            is_active           : v5 == 0,
            is_cancelled        : false,
            created_at_ms       : v10,
            funding_deadline_ms : v10 + 86400000,
        };
        let v12 = SplitCreatedEvent{
            split_id      : 0x2::object::id<GroupSplitEscrow<T0>>(&v11),
            creator       : 0x2::tx_context::sender(arg8),
            title         : arg2,
            total_amount  : arg3,
            created_at_ms : v10,
        };
        0x2::event::emit<SplitCreatedEvent>(v12);
        0x2::transfer::share_object<GroupSplitEscrow<T0>>(v11);
    }

    public fun fund_split_share<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut GroupSplitEscrow<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg5), true);
        let v0 = if (!arg2.is_active) {
            if (!arg2.is_cancelled) {
                0x2::clock::timestamp_ms(arg4) <= arg2.funding_deadline_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 108);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::vec_map::get_mut<address, ParticipantShare>(&mut arg2.participants, &v1);
        let v3 = if (v2.requires_upfront_escrow) {
            if (!v2.is_funded) {
                !v2.is_settled
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 108);
        let v4 = v2.amount_owed;
        assert!(0x2::coin::value<T0>(&arg3) == v4, 103);
        v2.is_funded = true;
        arg2.pending_upfront = arg2.pending_upfront - 1;
        0x2::balance::join<T0>(&mut arg2.escrowed_balance, 0x2::coin::into_balance<T0>(arg3));
        let v5 = EscrowFundedEvent{
            split_id : 0x2::object::id<GroupSplitEscrow<T0>>(arg2),
            payer    : v1,
            amount   : v4,
        };
        0x2::event::emit<EscrowFundedEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SolvencyRegistry{
            id          : 0x2::object::new(arg0),
            total_users : 0,
        };
        0x2::transfer::share_object<SolvencyRegistry>(v0);
    }

    public fun lock_in_cooldown_vault<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        let v0 = 0x2::tx_context::sender(arg6);
        assert_onboarded(arg0, arg1, v0, true);
        assert!(0x2::coin::value<T0>(&arg3) >= arg0.safe_floor_usdc, 109);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 103);
        valid_text(&arg4, 128);
        let v1 = 0x2::clock::timestamp_ms(arg5) + 86400000;
        let v2 = CooldownVault<T0>{
            id                       : 0x2::object::new(arg6),
            owner                    : v0,
            locked_balance           : 0x2::coin::into_balance<T0>(arg2),
            unlock_time_ms           : v1,
            trigger_memory_namespace : arg4,
        };
        let v3 = CooldownLockedEvent{
            vault_id       : 0x2::object::id<CooldownVault<T0>>(&v2),
            owner          : v0,
            amount         : 0x2::coin::value<T0>(&arg2),
            unlock_time_ms : v1,
            namespace      : arg4,
        };
        0x2::event::emit<CooldownLockedEvent>(v3);
        0x2::transfer::transfer<CooldownVault<T0>>(v2, v0);
    }

    fun put_contact(arg0: &mut UserProfile, arg1: address, arg2: 0x1::string::String) {
        assert!(arg1 != arg0.wallet && arg1 != @0x0, 106);
        valid_text(&arg2, 64);
        if (0x2::vec_map::contains<address, 0x1::string::String>(&arg0.contacts, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x1::string::String>(&mut arg0.contacts, &arg1);
        };
        0x2::vec_map::insert<address, 0x1::string::String>(&mut arg0.contacts, arg1, arg2);
    }

    public fun refund_escrow<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut GroupSplitEscrow<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg4), false);
        assert!(!arg2.is_active && (arg2.is_cancelled || 0x2::clock::timestamp_ms(arg3) > arg2.funding_deadline_ms), 108);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::vec_map::get_mut<address, ParticipantShare>(&mut arg2.participants, &v0);
        assert!(v1.is_funded && !v1.is_settled, 108);
        let v2 = v1.amount_owed;
        v1.is_funded = false;
        arg2.pending_upfront = arg2.pending_upfront + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.escrowed_balance, v2), arg4), v0);
        let v3 = EscrowRefundedEvent{
            split_id : 0x2::object::id<GroupSplitEscrow<T0>>(arg2),
            payer    : v0,
            amount   : v2,
        };
        0x2::event::emit<EscrowRefundedEvent>(v3);
    }

    public fun register_user(arg0: &mut SolvencyRegistry, arg1: 0x1::string::String, arg2: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg3: u64, arg4: vector<address>, arg5: vector<0x1::string::String>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        valid_text(&arg1, 64);
        let v0 = 0x2::tx_context::sender(arg7);
        assert_memory_owner(arg2, v0, true);
        assert!(!0x2::dynamic_field::exists<address>(&arg0.id, v0), 113);
        assert!(0x1::vector::length<address>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 106);
        let v1 = 0x2::object::id_address<0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount>(arg2);
        let v2 = UserProfile{
            id                : 0x2::object::new(arg7),
            wallet            : v0,
            handle            : arg1,
            memwal_account_id : v1,
            safe_floor_usdc   : arg3,
            contacts          : 0x2::vec_map::empty<address, 0x1::string::String>(),
            registered_at_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg4)) {
            let v4 = *0x1::vector::borrow<address>(&arg4, v3);
            assert!(!0x2::vec_map::contains<address, 0x1::string::String>(&v2.contacts, &v4), 106);
            let v5 = &mut v2;
            put_contact(v5, v4, *0x1::vector::borrow<0x1::string::String>(&arg5, v3));
            v3 = v3 + 1;
        };
        let v6 = 0x2::object::id<UserProfile>(&v2);
        0x2::dynamic_field::add<address, 0x2::object::ID>(&mut arg0.id, v0, v6);
        arg0.total_users = arg0.total_users + 1;
        let v7 = UserRegisteredEvent{
            wallet            : v0,
            profile_id        : v6,
            handle            : arg1,
            memwal_account_id : v1,
            safe_floor_usdc   : arg3,
        };
        0x2::event::emit<UserRegisteredEvent>(v7);
        0x2::transfer::transfer<UserProfile>(v2, v0);
    }

    public fun remove_contact(arg0: &mut UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg3), true);
        if (0x2::vec_map::contains<address, 0x1::string::String>(&arg0.contacts, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x1::string::String>(&mut arg0.contacts, &arg2);
        };
    }

    public fun settle_split_share<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut GroupSplitEscrow<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg5), true);
        assert!(arg2.is_active && !arg2.is_cancelled, 107);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::vec_map::get_mut<address, ParticipantShare>(&mut arg2.participants, &v0);
        assert!(!v1.is_settled, 104);
        assert!(0x2::coin::value<T0>(&arg3) == v1.amount_owed, 103);
        v1.is_settled = true;
        v1.settled_at_ms = 0x2::clock::timestamp_ms(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg2.creator);
        let v2 = ShareSettledEvent{
            split_id            : 0x2::object::id<GroupSplitEscrow<T0>>(arg2),
            payer               : v0,
            recipient           : arg2.creator,
            amount              : v1.amount_owed,
            was_escrow_enforced : v1.requires_upfront_escrow,
            settled_at_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ShareSettledEvent>(v2);
    }

    public fun unlock_cooldown_vault<T0>(arg0: &UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: CooldownVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert_onboarded(arg0, arg1, 0x2::tx_context::sender(arg4), false);
        let CooldownVault {
            id                       : v0,
            owner                    : v1,
            locked_balance           : v2,
            unlock_time_ms           : v3,
            trigger_memory_namespace : _,
        } = arg2;
        assert!(0x2::tx_context::sender(arg4) == v1, 102);
        assert!(0x2::clock::timestamp_ms(arg3) >= v3, 101);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg4), v1);
    }

    public fun update_profile(arg0: &mut UserProfile, arg1: 0x1::string::String, arg2: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.wallet == 0x2::tx_context::sender(arg4), 102);
        assert_memory_owner(arg2, 0x2::tx_context::sender(arg4), true);
        valid_text(&arg1, 64);
        arg0.handle = arg1;
        arg0.memwal_account_id = 0x2::object::id_address<0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount>(arg2);
        arg0.safe_floor_usdc = arg3;
        let v0 = UserProfileUpdatedEvent{
            wallet            : 0x2::tx_context::sender(arg4),
            profile_id        : 0x2::object::id<UserProfile>(arg0),
            handle            : arg1,
            memwal_account_id : arg0.memwal_account_id,
            safe_floor_usdc   : arg3,
        };
        0x2::event::emit<UserProfileUpdatedEvent>(v0);
    }

    fun valid_text(arg0: &0x1::string::String, arg1: u64) {
        assert!(0x1::string::length(arg0) > 0 && 0x1::string::length(arg0) <= arg1, 111);
    }

    // decompiled from Move bytecode v7
}

