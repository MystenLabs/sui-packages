module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::access_mgmt {
    struct InteractionPolicy has copy, drop, store {
        reach: u8,
        payment: u8,
    }

    struct PassGrant has copy, drop, store {
        hash: vector<u8>,
        memory_tier: u8,
        expires_at_ms: u64,
    }

    struct ManagerScope has copy, drop, store {
        edit_persona: bool,
        set_pricing_mode: bool,
        manage_passwords: bool,
        post_content: bool,
        adjust_reserve: bool,
    }

    struct PassBook has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        policy: InteractionPolicy,
        grants: vector<PassGrant>,
    }

    struct ManagerWhitelist has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        managers: vector<address>,
        scopes: vector<ManagerScope>,
    }

    struct AccessManagementCreated has copy, drop {
        pass_book_id: 0x2::object::ID,
        manager_whitelist_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct InteractionPolicyUpdated has copy, drop {
        pass_book_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        actor: address,
        reach: u8,
        payment: u8,
        timestamp_ms: u64,
    }

    struct PassGrantIssued has copy, drop {
        pass_book_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        actor: address,
        pass_hash: vector<u8>,
        memory_tier: u8,
        expires_at_ms: u64,
        timestamp_ms: u64,
    }

    struct PassGrantRevoked has copy, drop {
        pass_book_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        actor: address,
        pass_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct ManagerUpdated has copy, drop {
        manager_whitelist_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        manager: address,
        active: bool,
        timestamp_ms: u64,
    }

    fun assert_bound(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0) == arg1, 250);
    }

    public fun assert_manager_scope(arg0: &ManagerWhitelist, arg1: address, arg2: u8) {
        assert_manager_scope_fields(&arg0.managers, &arg0.scopes, arg1, arg2);
    }

    fun assert_manager_scope_fields(arg0: &vector<address>, arg1: &vector<ManagerScope>, arg2: address, arg3: u8) {
        let (v0, v1) = find_manager_fields(arg0, arg2);
        assert!(v0, 253);
        let v2 = 0x1::vector::borrow<ManagerScope>(arg1, v1);
        assert!(arg3 == 0 && v2.edit_persona || arg3 == 1 && v2.set_pricing_mode || arg3 == 2 && v2.manage_passwords || arg3 == 3 && v2.post_content || arg3 == 4 && v2.adjust_reserve, 253);
    }

    fun assert_owner_or_scope(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ManagerWhitelist, arg2: address, arg3: u8) {
        if (0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::owner(arg0) == arg2) {
            return
        };
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 250);
        assert_manager_scope(arg1, arg2, arg3);
    }

    fun assert_valid_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 255);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 256);
    }

    fun assert_valid_policy(arg0: u8, arg1: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 254);
        let v1 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v1, 254);
    }

    public fun check_interaction(arg0: &PassBook, arg1: address, arg2: address, arg3: vector<u8>, arg4: bool, arg5: &0x2::clock::Clock) : u8 {
        check_interaction_fields(&arg0.policy, &arg0.grants, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5))
    }

    fun check_interaction_fields(arg0: &InteractionPolicy, arg1: &vector<PassGrant>, arg2: address, arg3: address, arg4: vector<u8>, arg5: bool, arg6: u64) : u8 {
        let v0 = if (arg0.reach == 0) {
            0
        } else if (arg0.reach == 2) {
            assert!(arg2 == arg3, 251);
            255
        } else {
            assert_valid_hash(&arg4);
            let (v1, v2) = find_active_pass(arg1, &arg4, arg6);
            assert!(v1, 251);
            v2
        };
        if (arg0.payment == 2) {
            assert!(arg5, 252);
        };
        v0
    }

    entry fun create_access_management(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: u8, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_valid_policy(arg1, arg2);
        let v0 = InteractionPolicy{
            reach   : arg1,
            payment : arg2,
        };
        let v1 = PassBook{
            id           : 0x2::object::new(arg4),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            policy       : v0,
            grants       : 0x1::vector::empty<PassGrant>(),
        };
        let v2 = ManagerWhitelist{
            id           : 0x2::object::new(arg4),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            managers     : vector[],
            scopes       : 0x1::vector::empty<ManagerScope>(),
        };
        let v3 = AccessManagementCreated{
            pass_book_id         : 0x2::object::uid_to_inner(&v1.id),
            manager_whitelist_id : 0x2::object::uid_to_inner(&v2.id),
            character_id         : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                : 0x2::tx_context::sender(arg4),
            timestamp_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AccessManagementCreated>(v3);
        0x2::transfer::share_object<PassBook>(v1);
        0x2::transfer::share_object<ManagerWhitelist>(v2);
    }

    fun find_active_pass(arg0: &vector<PassGrant>, arg1: &vector<u8>, arg2: u64) : (bool, u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PassGrant>(arg0)) {
            let v1 = 0x1::vector::borrow<PassGrant>(arg0, v0);
            if (&v1.hash == arg1 && (v1.expires_at_ms == 0 || arg2 < v1.expires_at_ms)) {
                return (true, v1.memory_tier)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_manager(arg0: &ManagerWhitelist, arg1: address) : (bool, u64) {
        find_manager_fields(&arg0.managers, arg1)
    }

    fun find_manager_fields(arg0: &vector<address>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    entry fun grant_manager(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ManagerWhitelist, arg2: address, arg3: ManagerScope, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_bound(arg0, arg1.character_id);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg5));
        let (v0, v1) = find_manager(arg1, arg2);
        if (v0) {
            *0x1::vector::borrow_mut<ManagerScope>(&mut arg1.scopes, v1) = arg3;
        } else {
            0x1::vector::push_back<address>(&mut arg1.managers, arg2);
            0x1::vector::push_back<ManagerScope>(&mut arg1.scopes, arg3);
        };
        let v2 = ManagerUpdated{
            manager_whitelist_id : 0x2::object::uid_to_inner(&arg1.id),
            character_id         : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                : 0x2::tx_context::sender(arg5),
            manager              : arg2,
            active               : true,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ManagerUpdated>(v2);
    }

    entry fun grant_manager_scope(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ManagerWhitelist, arg2: address, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = ManagerScope{
            edit_persona     : arg3,
            set_pricing_mode : arg4,
            manage_passwords : arg5,
            post_content     : arg6,
            adjust_reserve   : arg7,
        };
        grant_manager(arg0, arg1, arg2, v0, arg8, arg9);
    }

    entry fun issue_pass(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ManagerWhitelist, arg2: &mut PassBook, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_bound(arg0, arg2.character_id);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 250);
        assert_owner_or_scope(arg0, arg1, 0x2::tx_context::sender(arg7), 2);
        assert_valid_hash(&arg3);
        let v0 = PassGrant{
            hash          : arg3,
            memory_tier   : arg4,
            expires_at_ms : arg5,
        };
        0x1::vector::push_back<PassGrant>(&mut arg2.grants, v0);
        let v1 = PassGrantIssued{
            pass_book_id  : 0x2::object::uid_to_inner(&arg2.id),
            character_id  : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            actor         : 0x2::tx_context::sender(arg7),
            pass_hash     : arg3,
            memory_tier   : arg4,
            expires_at_ms : arg5,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<PassGrantIssued>(v1);
    }

    public fun manager_count(arg0: &ManagerWhitelist) : u64 {
        0x1::vector::length<address>(&arg0.managers)
    }

    public fun pass_count(arg0: &PassBook) : u64 {
        0x1::vector::length<PassGrant>(&arg0.grants)
    }

    public fun pay_off() : u8 {
        0
    }

    public fun pay_optional() : u8 {
        1
    }

    public fun pay_required() : u8 {
        2
    }

    public fun policy_payment(arg0: &PassBook) : u8 {
        arg0.policy.payment
    }

    public fun policy_reach(arg0: &PassBook) : u8 {
        arg0.policy.reach
    }

    public fun reach_anyone() : u8 {
        0
    }

    public fun reach_gated() : u8 {
        1
    }

    public fun reach_owner() : u8 {
        2
    }

    entry fun revoke_manager(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ManagerWhitelist, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_bound(arg0, arg1.character_id);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg4));
        let (v0, v1) = find_manager(arg1, arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.managers, v1);
            0x1::vector::remove<ManagerScope>(&mut arg1.scopes, v1);
        };
        let v2 = ManagerUpdated{
            manager_whitelist_id : 0x2::object::uid_to_inner(&arg1.id),
            character_id         : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                : 0x2::tx_context::sender(arg4),
            manager              : arg2,
            active               : false,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ManagerUpdated>(v2);
    }

    entry fun revoke_pass(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ManagerWhitelist, arg2: &mut PassBook, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_bound(arg0, arg2.character_id);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 250);
        assert_owner_or_scope(arg0, arg1, 0x2::tx_context::sender(arg5), 2);
        assert_valid_hash(&arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<PassGrant>(&arg2.grants)) {
            if (0x1::vector::borrow<PassGrant>(&arg2.grants, v0).hash == arg3) {
                0x1::vector::remove<PassGrant>(&mut arg2.grants, v0);
                let v1 = PassGrantRevoked{
                    pass_book_id : 0x2::object::uid_to_inner(&arg2.id),
                    character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
                    actor        : 0x2::tx_context::sender(arg5),
                    pass_hash    : arg3,
                    timestamp_ms : 0x2::clock::timestamp_ms(arg4),
                };
                0x2::event::emit<PassGrantRevoked>(v1);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun scope_passwords() : u8 {
        2
    }

    public fun scope_pricing() : u8 {
        1
    }

    entry fun set_interaction_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ManagerWhitelist, arg2: &mut PassBook, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_bound(arg0, arg2.character_id);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 250);
        assert_valid_policy(arg3, arg4);
        assert_owner_or_scope(arg0, arg1, 0x2::tx_context::sender(arg6), 1);
        let v0 = InteractionPolicy{
            reach   : arg3,
            payment : arg4,
        };
        arg2.policy = v0;
        let v1 = InteractionPolicyUpdated{
            pass_book_id : 0x2::object::uid_to_inner(&arg2.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            actor        : 0x2::tx_context::sender(arg6),
            reach        : arg3,
            payment      : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<InteractionPolicyUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

