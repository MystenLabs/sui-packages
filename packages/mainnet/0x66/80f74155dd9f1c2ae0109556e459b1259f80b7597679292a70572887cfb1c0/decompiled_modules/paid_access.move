module 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::paid_access {
    struct KindPaidConfig has copy, drop, store {
        version: u64,
        price_atomic: u64,
        scope_mask: u64,
        duration_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct KindPaidEntry has copy, drop, store {
        version: u64,
        scope_mask: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct SoulPaidAccessList has key {
        id: 0x2::object::UID,
        version: u64,
        soul_id: 0x2::object::ID,
        creator: address,
        kind_configs: 0x2::table::Table<u32, KindPaidConfig>,
        entries: 0x2::table::Table<address, 0x2::table::Table<u32, KindPaidEntry>>,
    }

    struct SoulPaidAccessListCreated has copy, drop {
        paid_access_list_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        creator: address,
    }

    struct SoulPaidAccessKindConfigured has copy, drop {
        soul_id: 0x2::object::ID,
        paid_access_list_id: 0x2::object::ID,
        kind: u32,
        price_atomic: u64,
        scope_mask: u64,
        duration_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct SoulPaidAccessKindUpdated has copy, drop {
        soul_id: 0x2::object::ID,
        paid_access_list_id: 0x2::object::ID,
        kind: u32,
        old_price_atomic: u64,
        new_price_atomic: u64,
        old_scope_mask: u64,
        new_scope_mask: u64,
        old_duration_ms: 0x1::option::Option<u64>,
        new_duration_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct SoulPaidAccessKindDeleted has copy, drop {
        soul_id: 0x2::object::ID,
        paid_access_list_id: 0x2::object::ID,
        kind: u32,
    }

    struct SoulPaidAccessGranted has copy, drop {
        soul_id: 0x2::object::ID,
        paid_access_list_id: 0x2::object::ID,
        grantee: address,
        kind: u32,
        scope_mask: u64,
        price_paid_atomic: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        ownership_epoch_snapshot: u64,
    }

    struct SoulPaidAccessRevoked has copy, drop {
        soul_id: 0x2::object::ID,
        paid_access_list_id: 0x2::object::ID,
        grantee: address,
        kind: u32,
    }

    public fun add_access(arg0: &mut SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: address, arg4: u32, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::current_owner(arg1), 1);
        assert_paid_access_list_matches_state(arg0, arg1);
        assert_kind_supports_paid_with_scope(arg2, arg4, arg5);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::assert_valid_scope_mask(arg5);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1);
        if (!0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg3)) {
            0x2::table::add<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg3, 0x2::table::new<u32, KindPaidEntry>(arg8));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg3);
        if (0x2::table::contains<u32, KindPaidEntry>(v1, arg4)) {
            let v2 = 0x2::table::borrow<u32, KindPaidEntry>(v1, arg4);
            if (v2.ownership_epoch_snapshot != v0) {
                0x2::table::remove<u32, KindPaidEntry>(v1, arg4);
            } else {
                assert!(0x1::option::is_some<u64>(&v2.expires_at_ms), 2);
                0x2::table::remove<u32, KindPaidEntry>(v1, arg4);
            };
        };
        let v3 = KindPaidEntry{
            version                  : 1,
            scope_mask               : arg5,
            expires_at_ms            : arg6,
            ownership_epoch_snapshot : v0,
        };
        0x2::table::add<u32, KindPaidEntry>(0x2::table::borrow_mut<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg3), arg4, v3);
        let v4 = SoulPaidAccessGranted{
            soul_id                  : arg0.soul_id,
            paid_access_list_id      : 0x2::object::id<SoulPaidAccessList>(arg0),
            grantee                  : arg3,
            kind                     : arg4,
            scope_mask               : arg5,
            price_paid_atomic        : 0,
            expires_at_ms            : arg6,
            ownership_epoch_snapshot : v0,
        };
        0x2::event::emit<SoulPaidAccessGranted>(v4);
    }

    fun assert_kind_supports_paid_with_scope(arg0: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg1: u32, arg2: u64) {
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg0, arg1);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_read_mode_mask(v0) & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_paid() != 0, 11);
        assert!(arg2 == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_default_grant_scope_mask(v0), 9);
    }

    public fun assert_paid_access_list_matches_state(arg0: &SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState) {
        assert!(arg0.soul_id == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg1), 5);
        let v0 = 0x2::object::id<SoulPaidAccessList>(arg0);
        assert!(0x1::option::contains<0x2::object::ID>(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::access_list_id(arg1), &v0), 5);
    }

    public fun cleanup_stale_entries(arg0: &mut SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: vector<address>, arg3: vector<u32>, arg4: &0x2::tx_context::TxContext) {
        assert_paid_access_list_matches_state(arg0, arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u32>(&arg3), 13);
        0x1::vector::reverse<address>(&mut arg2);
        0x1::vector::reverse<u32>(&mut arg3);
        while (!0x1::vector::is_empty<address>(&arg2) && !0x1::vector::is_empty<u32>(&arg3)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x1::vector::pop_back<u32>(&mut arg3);
            if (0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, v0)) {
                let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, v0);
                if (0x2::table::contains<u32, KindPaidEntry>(v2, v1)) {
                    if (0x2::table::borrow<u32, KindPaidEntry>(v2, v1).ownership_epoch_snapshot != 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1)) {
                        0x2::table::remove<u32, KindPaidEntry>(v2, v1);
                    };
                };
                drop_empty_buyer_row(arg0, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u32>(arg3);
    }

    fun compute_expires_at_ms(arg0: 0x1::option::Option<u64>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<u64>(&arg0)) {
            0x1::option::some<u64>(arg1 + *0x1::option::borrow<u64>(&arg0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun configure_paid_access_kind(arg0: &mut SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: u32, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::current_owner(arg1), 1);
        assert_paid_access_list_matches_state(arg0, arg1);
        assert!(!0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg3), 8);
        assert_kind_supports_paid_with_scope(arg2, arg3, arg5);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::assert_valid_scope_mask(arg5);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1);
        let v1 = KindPaidConfig{
            version                  : 1,
            price_atomic             : arg4,
            scope_mask               : arg5,
            duration_ms              : arg6,
            ownership_epoch_snapshot : v0,
        };
        0x2::table::add<u32, KindPaidConfig>(&mut arg0.kind_configs, arg3, v1);
        let v2 = SoulPaidAccessKindConfigured{
            soul_id                  : arg0.soul_id,
            paid_access_list_id      : 0x2::object::id<SoulPaidAccessList>(arg0),
            kind                     : arg3,
            price_atomic             : arg4,
            scope_mask               : arg5,
            duration_ms              : arg6,
            ownership_epoch_snapshot : v0,
        };
        0x2::event::emit<SoulPaidAccessKindConfigured>(v2);
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : SoulPaidAccessList {
        let v0 = SoulPaidAccessList{
            id           : 0x2::object::new(arg2),
            version      : 1,
            soul_id      : arg0,
            creator      : arg1,
            kind_configs : 0x2::table::new<u32, KindPaidConfig>(arg2),
            entries      : 0x2::table::new<address, 0x2::table::Table<u32, KindPaidEntry>>(arg2),
        };
        let v1 = SoulPaidAccessListCreated{
            paid_access_list_id : 0x2::object::id<SoulPaidAccessList>(&v0),
            soul_id             : arg0,
            creator             : arg1,
        };
        0x2::event::emit<SoulPaidAccessListCreated>(v1);
        v0
    }

    public fun creator(arg0: &SoulPaidAccessList) : address {
        arg0.creator
    }

    public fun delete_paid_access_kind(arg0: &mut SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::current_owner(arg1), 1);
        assert_paid_access_list_matches_state(arg0, arg1);
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg2), 7);
        0x2::table::remove<u32, KindPaidConfig>(&mut arg0.kind_configs, arg2);
        let v0 = SoulPaidAccessKindDeleted{
            soul_id             : arg0.soul_id,
            paid_access_list_id : 0x2::object::id<SoulPaidAccessList>(arg0),
            kind                : arg2,
        };
        0x2::event::emit<SoulPaidAccessKindDeleted>(v0);
    }

    fun drop_empty_buyer_row(arg0: &mut SoulPaidAccessList, arg1: address) {
        if (!0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1)) {
            return
        };
        if (0x2::table::is_empty<u32, KindPaidEntry>(0x2::table::borrow<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1))) {
            0x2::table::destroy_empty<u32, KindPaidEntry>(0x2::table::remove<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg1));
        };
    }

    public fun has_access(arg0: &SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: address, arg3: u32, arg4: u64, arg5: &0x2::clock::Clock) : bool {
        assert_paid_access_list_matches_state(arg0, arg1);
        if (!0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg2)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg2);
        if (!0x2::table::contains<u32, KindPaidEntry>(v0, arg3)) {
            return false
        };
        let v1 = 0x2::table::borrow<u32, KindPaidEntry>(v0, arg3);
        if (v1.scope_mask & arg4 != arg4) {
            return false
        };
        if (v1.ownership_epoch_snapshot != 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1)) {
            return false
        };
        if (0x1::option::is_some<u64>(&v1.expires_at_ms)) {
            if (0x2::clock::timestamp_ms(arg5) >= *0x1::option::borrow<u64>(&v1.expires_at_ms)) {
                return false
            };
        };
        true
    }

    public fun has_buyer_row(arg0: &SoulPaidAccessList, arg1: address) : bool {
        0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1)
    }

    public fun has_kind_config(arg0: &SoulPaidAccessList, arg1: u32) : bool {
        0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg1)
    }

    public fun has_kind_entry(arg0: &SoulPaidAccessList, arg1: address, arg2: u32) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1)) {
            return false
        };
        0x2::table::contains<u32, KindPaidEntry>(0x2::table::borrow<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1), arg2)
    }

    public fun kind_config_duration_ms(arg0: &SoulPaidAccessList, arg1: u32) : 0x1::option::Option<u64> {
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg1), 7);
        0x2::table::borrow<u32, KindPaidConfig>(&arg0.kind_configs, arg1).duration_ms
    }

    public fun kind_config_ownership_epoch_snapshot(arg0: &SoulPaidAccessList, arg1: u32) : u64 {
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg1), 7);
        0x2::table::borrow<u32, KindPaidConfig>(&arg0.kind_configs, arg1).ownership_epoch_snapshot
    }

    public fun kind_config_price_atomic(arg0: &SoulPaidAccessList, arg1: u32) : u64 {
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg1), 7);
        0x2::table::borrow<u32, KindPaidConfig>(&arg0.kind_configs, arg1).price_atomic
    }

    public fun kind_config_scope_mask(arg0: &SoulPaidAccessList, arg1: u32) : u64 {
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg1), 7);
        0x2::table::borrow<u32, KindPaidConfig>(&arg0.kind_configs, arg1).scope_mask
    }

    public fun kind_config_version(arg0: &SoulPaidAccessList, arg1: u32) : u64 {
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg1), 7);
        0x2::table::borrow<u32, KindPaidConfig>(&arg0.kind_configs, arg1).version
    }

    public fun kind_entry_expires_at_ms(arg0: &SoulPaidAccessList, arg1: address, arg2: u32) : 0x1::option::Option<u64> {
        if (!has_kind_entry(arg0, arg1, arg2)) {
            return 0x1::option::none<u64>()
        };
        0x2::table::borrow<u32, KindPaidEntry>(0x2::table::borrow<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1), arg2).expires_at_ms
    }

    public fun kind_entry_scope_mask(arg0: &SoulPaidAccessList, arg1: address, arg2: u32) : u64 {
        assert!(has_kind_entry(arg0, arg1, arg2), 3);
        0x2::table::borrow<u32, KindPaidEntry>(0x2::table::borrow<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1), arg2).scope_mask
    }

    public fun kind_entry_version(arg0: &SoulPaidAccessList, arg1: address, arg2: u32) : u64 {
        assert!(has_kind_entry(arg0, arg1, arg2), 3);
        0x2::table::borrow<u32, KindPaidEntry>(0x2::table::borrow<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg1), arg2).version
    }

    public fun paid_access_list_version(arg0: &SoulPaidAccessList) : u64 {
        arg0.version
    }

    public fun protocol_version() : u64 {
        1
    }

    public(friend) fun record_purchase(arg0: &mut SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: address, arg3: u32, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_paid_access_list_matches_state(arg0, arg1);
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg3), 7);
        let v0 = 0x2::table::borrow<u32, KindPaidConfig>(&arg0.kind_configs, arg3);
        let v1 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1);
        assert!(v0.ownership_epoch_snapshot == v1, 12);
        let v2 = v0.scope_mask;
        let v3 = v0.duration_ms;
        let v4 = 0x1::option::none<u64>();
        if (!0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg2)) {
            0x2::table::add<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg2, 0x2::table::new<u32, KindPaidEntry>(arg6));
        };
        let v5 = 0x2::table::borrow_mut<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg2);
        if (0x2::table::contains<u32, KindPaidEntry>(v5, arg3)) {
            let v6 = 0x2::table::borrow<u32, KindPaidEntry>(v5, arg3);
            if (v6.ownership_epoch_snapshot != v1) {
                0x2::table::remove<u32, KindPaidEntry>(v5, arg3);
            } else {
                assert!(0x1::option::is_some<u64>(&v6.expires_at_ms), 2);
                v4 = 0x1::option::some<u64>(*0x1::option::borrow<u64>(&v6.expires_at_ms));
                0x2::table::remove<u32, KindPaidEntry>(v5, arg3);
            };
        };
        let v7 = compute_expires_at_ms(v3, renewal_base_ms(0x2::clock::timestamp_ms(arg5), v4));
        let v8 = KindPaidEntry{
            version                  : 1,
            scope_mask               : v2,
            expires_at_ms            : v7,
            ownership_epoch_snapshot : v1,
        };
        0x2::table::add<u32, KindPaidEntry>(0x2::table::borrow_mut<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg2), arg3, v8);
        let v9 = SoulPaidAccessGranted{
            soul_id                  : arg0.soul_id,
            paid_access_list_id      : 0x2::object::id<SoulPaidAccessList>(arg0),
            grantee                  : arg2,
            kind                     : arg3,
            scope_mask               : v2,
            price_paid_atomic        : arg4,
            expires_at_ms            : v7,
            ownership_epoch_snapshot : v1,
        };
        0x2::event::emit<SoulPaidAccessGranted>(v9);
    }

    fun renewal_base_ms(arg0: u64, arg1: 0x1::option::Option<u64>) : u64 {
        if (0x1::option::is_some<u64>(&arg1)) {
            let v0 = *0x1::option::borrow<u64>(&arg1);
            if (v0 > arg0) {
                return v0
            };
        };
        arg0
    }

    public fun revoke_access(arg0: &mut SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: address, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::current_owner(arg1), 1);
        assert_paid_access_list_matches_state(arg0, arg1);
        assert!(0x2::table::contains<address, 0x2::table::Table<u32, KindPaidEntry>>(&arg0.entries, arg2), 3);
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<u32, KindPaidEntry>>(&mut arg0.entries, arg2);
        assert!(0x2::table::contains<u32, KindPaidEntry>(v0, arg3), 3);
        0x2::table::remove<u32, KindPaidEntry>(v0, arg3);
        drop_empty_buyer_row(arg0, arg2);
        let v1 = SoulPaidAccessRevoked{
            soul_id             : arg0.soul_id,
            paid_access_list_id : 0x2::object::id<SoulPaidAccessList>(arg0),
            grantee             : arg2,
            kind                : arg3,
        };
        0x2::event::emit<SoulPaidAccessRevoked>(v1);
    }

    public fun seal_approve_content_paid_access(arg0: vector<u8>, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &SoulPaidAccessList, arg3: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::content::SoulContent, arg4: u32, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_paid_access_list_matches_state(arg2, arg1);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::content::assert_valid_content_seal_request(arg0, arg1, arg3, arg4, arg5, arg6);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::content::assert_slot_paid_read_allowed(arg3, arg4, arg5, arg6);
        assert!(v0 != 0, 6);
        assert!(has_access(arg2, arg1, 0x2::tx_context::sender(arg8), arg4, v0, arg7), 4);
    }

    public(friend) fun share_paid_access_list(arg0: SoulPaidAccessList) {
        0x2::transfer::share_object<SoulPaidAccessList>(arg0);
    }

    public fun soul_id(arg0: &SoulPaidAccessList) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun update_paid_access_kind(arg0: &mut SoulPaidAccessList, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: u32, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::current_owner(arg1), 1);
        assert_paid_access_list_matches_state(arg0, arg1);
        assert!(0x2::table::contains<u32, KindPaidConfig>(&arg0.kind_configs, arg3), 7);
        assert_kind_supports_paid_with_scope(arg2, arg3, arg5);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::assert_valid_scope_mask(arg5);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1);
        let v1 = 0x2::table::borrow_mut<u32, KindPaidConfig>(&mut arg0.kind_configs, arg3);
        v1.price_atomic = arg4;
        v1.scope_mask = arg5;
        v1.duration_ms = arg6;
        v1.ownership_epoch_snapshot = v0;
        let v2 = SoulPaidAccessKindUpdated{
            soul_id                  : arg0.soul_id,
            paid_access_list_id      : 0x2::object::id<SoulPaidAccessList>(arg0),
            kind                     : arg3,
            old_price_atomic         : v1.price_atomic,
            new_price_atomic         : arg4,
            old_scope_mask           : v1.scope_mask,
            new_scope_mask           : arg5,
            old_duration_ms          : v1.duration_ms,
            new_duration_ms          : arg6,
            ownership_epoch_snapshot : v0,
        };
        0x2::event::emit<SoulPaidAccessKindUpdated>(v2);
    }

    // decompiled from Move bytecode v7
}

