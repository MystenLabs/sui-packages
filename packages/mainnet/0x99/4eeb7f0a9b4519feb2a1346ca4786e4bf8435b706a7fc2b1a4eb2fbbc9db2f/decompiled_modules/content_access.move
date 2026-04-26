module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access {
    struct ContentAccessEntry has copy, drop, store {
        scope_mask: u64,
        price_paid_atomic: u64,
        granted_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct ContentAccessList has key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        creator: address,
        price_atomic: u64,
        default_scope_mask: u64,
        default_access_duration_ms: 0x1::option::Option<u64>,
        entries: 0x2::table::Table<address, ContentAccessEntry>,
        entry_count: u64,
    }

    struct ContentAccessListCreated has copy, drop {
        access_list_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        creator: address,
        price_atomic: u64,
        default_scope_mask: u64,
        default_access_duration_ms: 0x1::option::Option<u64>,
    }

    struct ContentAccessGranted has copy, drop {
        soul_id: 0x2::object::ID,
        access_list_id: 0x2::object::ID,
        grantee: address,
        scope_mask: u64,
        price_paid_atomic: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct ContentAccessRevoked has copy, drop {
        soul_id: 0x2::object::ID,
        access_list_id: 0x2::object::ID,
        grantee: address,
    }

    struct ContentAccessPriceUpdated has copy, drop {
        soul_id: 0x2::object::ID,
        access_list_id: 0x2::object::ID,
        old_price_atomic: u64,
        new_price_atomic: u64,
    }

    struct ContentAccessDurationUpdated has copy, drop {
        soul_id: 0x2::object::ID,
        access_list_id: 0x2::object::ID,
        old_duration_ms: 0x1::option::Option<u64>,
        new_duration_ms: 0x1::option::Option<u64>,
    }

    public fun add_access(arg0: &mut ContentAccessList, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: address, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_owner(arg1), 1);
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ownership_epoch(arg1);
        if (0x2::table::contains<address, ContentAccessEntry>(&arg0.entries, arg2)) {
            let v1 = 0x2::table::borrow<address, ContentAccessEntry>(&arg0.entries, arg2);
            if (v1.ownership_epoch_snapshot != v0) {
                0x2::table::remove<address, ContentAccessEntry>(&mut arg0.entries, arg2);
                arg0.entry_count = arg0.entry_count - 1;
            } else {
                assert!(0x1::option::is_some<u64>(&v1.expires_at_ms), 2);
                assert!(0x2::clock::timestamp_ms(arg5) >= *0x1::option::borrow<u64>(&v1.expires_at_ms), 2);
                0x2::table::remove<address, ContentAccessEntry>(&mut arg0.entries, arg2);
                arg0.entry_count = arg0.entry_count - 1;
            };
        };
        let v2 = ContentAccessEntry{
            scope_mask               : arg3,
            price_paid_atomic        : 0,
            granted_at_ms            : 0x2::clock::timestamp_ms(arg5),
            expires_at_ms            : arg4,
            ownership_epoch_snapshot : v0,
        };
        0x2::table::add<address, ContentAccessEntry>(&mut arg0.entries, arg2, v2);
        arg0.entry_count = arg0.entry_count + 1;
        let v3 = ContentAccessGranted{
            soul_id                  : arg0.soul_id,
            access_list_id           : 0x2::object::id<ContentAccessList>(arg0),
            grantee                  : arg2,
            scope_mask               : arg3,
            price_paid_atomic        : 0,
            expires_at_ms            : arg4,
            ownership_epoch_snapshot : v0,
        };
        0x2::event::emit<ContentAccessGranted>(v3);
    }

    fun compute_expires_at_ms(arg0: 0x1::option::Option<u64>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<u64>(&arg0)) {
            0x1::option::some<u64>(arg1 + *0x1::option::borrow<u64>(&arg0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : ContentAccessList {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_valid_scope_mask(arg3);
        let v0 = ContentAccessList{
            id                         : 0x2::object::new(arg5),
            soul_id                    : arg0,
            creator                    : arg1,
            price_atomic               : arg2,
            default_scope_mask         : arg3,
            default_access_duration_ms : arg4,
            entries                    : 0x2::table::new<address, ContentAccessEntry>(arg5),
            entry_count                : 0,
        };
        let v1 = ContentAccessListCreated{
            access_list_id             : 0x2::object::id<ContentAccessList>(&v0),
            soul_id                    : arg0,
            creator                    : arg1,
            price_atomic               : arg2,
            default_scope_mask         : arg3,
            default_access_duration_ms : arg4,
        };
        0x2::event::emit<ContentAccessListCreated>(v1);
        v0
    }

    public fun creator(arg0: &ContentAccessList) : address {
        arg0.creator
    }

    public fun default_access_duration_ms(arg0: &ContentAccessList) : 0x1::option::Option<u64> {
        arg0.default_access_duration_ms
    }

    public fun entry_count(arg0: &ContentAccessList) : u64 {
        arg0.entry_count
    }

    public fun entry_expires_at_ms(arg0: &ContentAccessList, arg1: address) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<address, ContentAccessEntry>(&arg0.entries, arg1)) {
            return 0x1::option::none<u64>()
        };
        0x2::table::borrow<address, ContentAccessEntry>(&arg0.entries, arg1).expires_at_ms
    }

    public fun has_access(arg0: &ContentAccessList, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) : bool {
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        if (!0x2::table::contains<address, ContentAccessEntry>(&arg0.entries, arg2)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, ContentAccessEntry>(&arg0.entries, arg2);
        if (v0.scope_mask & arg3 != arg3) {
            return false
        };
        if (v0.ownership_epoch_snapshot != 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ownership_epoch(arg1)) {
            return false
        };
        if (0x1::option::is_some<u64>(&v0.expires_at_ms)) {
            if (0x2::clock::timestamp_ms(arg4) >= *0x1::option::borrow<u64>(&v0.expires_at_ms)) {
                return false
            };
        };
        true
    }

    public fun price_atomic(arg0: &ContentAccessList) : u64 {
        arg0.price_atomic
    }

    public(friend) fun record_purchase(arg0: &mut ContentAccessList, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ownership_epoch(arg1);
        if (0x2::table::contains<address, ContentAccessEntry>(&arg0.entries, arg2)) {
            let v1 = 0x2::table::borrow<address, ContentAccessEntry>(&arg0.entries, arg2);
            if (v1.ownership_epoch_snapshot != v0) {
                0x2::table::remove<address, ContentAccessEntry>(&mut arg0.entries, arg2);
                arg0.entry_count = arg0.entry_count - 1;
            } else {
                assert!(0x1::option::is_some<u64>(&v1.expires_at_ms), 2);
                assert!(0x2::clock::timestamp_ms(arg4) >= *0x1::option::borrow<u64>(&v1.expires_at_ms), 2);
                0x2::table::remove<address, ContentAccessEntry>(&mut arg0.entries, arg2);
                arg0.entry_count = arg0.entry_count - 1;
            };
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = compute_expires_at_ms(arg0.default_access_duration_ms, v2);
        let v4 = ContentAccessEntry{
            scope_mask               : arg0.default_scope_mask,
            price_paid_atomic        : arg3,
            granted_at_ms            : v2,
            expires_at_ms            : v3,
            ownership_epoch_snapshot : v0,
        };
        0x2::table::add<address, ContentAccessEntry>(&mut arg0.entries, arg2, v4);
        arg0.entry_count = arg0.entry_count + 1;
        let v5 = ContentAccessGranted{
            soul_id                  : arg0.soul_id,
            access_list_id           : 0x2::object::id<ContentAccessList>(arg0),
            grantee                  : arg2,
            scope_mask               : arg0.default_scope_mask,
            price_paid_atomic        : arg3,
            expires_at_ms            : v3,
            ownership_epoch_snapshot : v0,
        };
        0x2::event::emit<ContentAccessGranted>(v5);
    }

    public fun revoke_access(arg0: &mut ContentAccessList, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_owner(arg1), 1);
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        assert!(0x2::table::contains<address, ContentAccessEntry>(&arg0.entries, arg2), 3);
        0x2::table::remove<address, ContentAccessEntry>(&mut arg0.entries, arg2);
        arg0.entry_count = arg0.entry_count - 1;
        let v0 = ContentAccessRevoked{
            soul_id        : arg0.soul_id,
            access_list_id : 0x2::object::id<ContentAccessList>(arg0),
            grantee        : arg2,
        };
        0x2::event::emit<ContentAccessRevoked>(v0);
    }

    entry fun seal_approve_asset_allowlisted(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &ContentAccessList, arg3: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::SoulAssets, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg2.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::assert_valid_asset_seal_request(arg0, arg1, arg3, arg4, arg5);
        assert!(has_access(arg2, arg1, 0x2::tx_context::sender(arg7), 8, arg6), 4);
    }

    entry fun seal_approve_skill_allowlisted(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &ContentAccessList, arg3: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::skills::SoulSkills, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg2.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::skills::assert_valid_skill_seal_request(arg0, arg1, arg3, arg4, arg5);
        assert!(has_access(arg2, arg1, 0x2::tx_context::sender(arg7), 4, arg6), 4);
    }

    public fun set_content_access_duration(arg0: &mut ContentAccessList, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::option::Option<u64>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_owner(arg1), 1);
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        arg0.default_access_duration_ms = arg2;
        let v0 = ContentAccessDurationUpdated{
            soul_id         : arg0.soul_id,
            access_list_id  : 0x2::object::id<ContentAccessList>(arg0),
            old_duration_ms : arg0.default_access_duration_ms,
            new_duration_ms : arg2,
        };
        0x2::event::emit<ContentAccessDurationUpdated>(v0);
    }

    public fun set_content_price(arg0: &mut ContentAccessList, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_owner(arg1), 1);
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 5);
        arg0.price_atomic = arg2;
        let v0 = ContentAccessPriceUpdated{
            soul_id          : arg0.soul_id,
            access_list_id   : 0x2::object::id<ContentAccessList>(arg0),
            old_price_atomic : arg0.price_atomic,
            new_price_atomic : arg2,
        };
        0x2::event::emit<ContentAccessPriceUpdated>(v0);
    }

    public(friend) fun share_access_list(arg0: ContentAccessList) {
        0x2::transfer::share_object<ContentAccessList>(arg0);
    }

    public fun soul_id(arg0: &ContentAccessList) : 0x2::object::ID {
        arg0.soul_id
    }

    // decompiled from Move bytecode v7
}

