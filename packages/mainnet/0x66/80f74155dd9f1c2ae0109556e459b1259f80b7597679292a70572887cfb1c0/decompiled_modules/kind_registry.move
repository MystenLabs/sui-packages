module 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry {
    struct KindDescriptor has copy, drop, store {
        version: u64,
        kind: u32,
        name: 0x1::string::String,
        op_mask: u64,
        read_mode_mask: u64,
        has_active_binding: bool,
        requires_download_policy: bool,
        default_grant_scope_mask: u64,
        deprecated: bool,
    }

    struct KindRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        next_kind: u32,
        kinds: 0x2::table::Table<u32, KindDescriptor>,
        name_to_kind: 0x2::table::Table<0x1::string::String, u32>,
    }

    struct KindAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KindRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct KindRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        kind: u32,
        name: 0x1::string::String,
        op_mask: u64,
        read_mode_mask: u64,
        has_active_binding: bool,
        requires_download_policy: bool,
        default_grant_scope_mask: u64,
    }

    struct KindDeprecated has copy, drop {
        registry_id: 0x2::object::ID,
        kind: u32,
        name: 0x1::string::String,
    }

    struct KindReactivated has copy, drop {
        registry_id: 0x2::object::ID,
        kind: u32,
        name: 0x1::string::String,
    }

    fun assert_descriptor_well_formed(arg0: u64, arg1: u64, arg2: bool, arg3: bool, arg4: u64) {
        assert!(arg0 & 15 == arg0, 8);
        assert!(arg1 & 15 == arg1, 9);
        assert!(arg1 != 0, 10);
        assert!(arg1 & 1 != 0, 11);
        assert!(arg0 & 8 != 0 == arg2, 12);
        if (arg1 & 8 != 0) {
            assert!(arg3, 13);
        } else {
            assert!(!arg3, 14);
        };
        assert_valid_default_grant_scope(arg4, arg1);
    }

    public(friend) fun assert_kind_active(arg0: &KindRegistry, arg1: u32) {
        assert!(0x2::table::contains<u32, KindDescriptor>(&arg0.kinds, arg1), 3);
        assert!(!0x2::table::borrow<u32, KindDescriptor>(&arg0.kinds, arg1).deprecated, 4);
    }

    fun assert_valid_default_grant_scope(arg0: u64, arg1: u64) {
        if (!(arg1 & (2 | 4) != 0)) {
            assert!(arg0 == 0, 5);
        } else {
            assert!(arg0 != 0, 5);
            assert!(arg0 & (0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_seal() | 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_memory() | 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_skills() | 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_assets()) == arg0, 5);
            assert!(is_single_bit(arg0), 5);
        };
    }

    fun assert_valid_kind_name(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 >= 1 && v1 <= 32, 6);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = v3 >= 97 && v3 <= 122;
            let v5 = v3 >= 48 && v3 <= 57;
            let v6 = if (v4) {
                true
            } else if (v5) {
                true
            } else if (v3 == 95) {
                true
            } else {
                v3 == 45
            };
            assert!(v6, 7);
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 1);
    }

    public fun borrow_descriptor(arg0: &KindRegistry, arg1: u32) : &KindDescriptor {
        assert!(0x2::table::contains<u32, KindDescriptor>(&arg0.kinds, arg1), 3);
        0x2::table::borrow<u32, KindDescriptor>(&arg0.kinds, arg1)
    }

    public fun contains_kind(arg0: &KindRegistry, arg1: u32) : bool {
        0x2::table::contains<u32, KindDescriptor>(&arg0.kinds, arg1)
    }

    public fun contains_name(arg0: &KindRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, u32>(&arg0.name_to_kind, arg1)
    }

    public fun deprecate_kind(arg0: &mut KindRegistry, arg1: &KindAdminCap, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u32, KindDescriptor>(&arg0.kinds, arg2), 3);
        let v0 = 0x2::table::borrow_mut<u32, KindDescriptor>(&mut arg0.kinds, arg2);
        assert!(!v0.deprecated, 4);
        v0.deprecated = true;
        let v1 = KindDeprecated{
            registry_id : 0x2::object::id<KindRegistry>(arg0),
            kind        : arg2,
            name        : v0.name,
        };
        0x2::event::emit<KindDeprecated>(v1);
    }

    public fun descriptor_default_grant_scope_mask(arg0: &KindDescriptor) : u64 {
        arg0.default_grant_scope_mask
    }

    public fun descriptor_deprecated(arg0: &KindDescriptor) : bool {
        arg0.deprecated
    }

    public fun descriptor_has_active_binding(arg0: &KindDescriptor) : bool {
        arg0.has_active_binding
    }

    public fun descriptor_kind(arg0: &KindDescriptor) : u32 {
        arg0.kind
    }

    public fun descriptor_name(arg0: &KindDescriptor) : &0x1::string::String {
        &arg0.name
    }

    public fun descriptor_op_mask(arg0: &KindDescriptor) : u64 {
        arg0.op_mask
    }

    public fun descriptor_read_mode_mask(arg0: &KindDescriptor) : u64 {
        arg0.read_mode_mask
    }

    public fun descriptor_requires_download_policy(arg0: &KindDescriptor) : bool {
        arg0.requires_download_policy
    }

    public fun descriptor_version(arg0: &KindDescriptor) : u64 {
        arg0.version
    }

    public fun first_custom_kind() : u32 {
        16
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KindRegistry{
            id           : 0x2::object::new(arg0),
            version      : 1,
            next_kind    : 16,
            kinds        : 0x2::table::new<u32, KindDescriptor>(arg0),
            name_to_kind : 0x2::table::new<0x1::string::String, u32>(arg0),
        };
        let v1 = &mut v0;
        insert_descriptor_unchecked(v1, 0, 0x1::string::utf8(b"soul_doc"), 0, 1 | 2, false, false, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_seal());
        let v2 = &mut v0;
        insert_descriptor_unchecked(v2, 1, 0x1::string::utf8(b"memory"), 1 | 2 | 4, 1 | 2, false, false, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_memory());
        let v3 = &mut v0;
        insert_descriptor_unchecked(v3, 2, 0x1::string::utf8(b"skill"), 1 | 2 | 4, 1 | 2, false, false, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_skills());
        let v4 = &mut v0;
        insert_descriptor_unchecked(v4, 3, 0x1::string::utf8(b"sprite"), 1 | 2 | 4 | 8, 1 | 2 | 4 | 8, true, true, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_assets());
        let v5 = &mut v0;
        insert_descriptor_unchecked(v5, 4, 0x1::string::utf8(b"audio"), 1 | 2 | 4 | 8, 1 | 2 | 4 | 8, true, true, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::scope_assets());
        let v6 = KindAdminCap{id: 0x2::object::new(arg0)};
        let v7 = KindRegistryCreated{
            registry_id  : 0x2::object::id<KindRegistry>(&v0),
            admin_cap_id : 0x2::object::id<KindAdminCap>(&v6),
        };
        0x2::event::emit<KindRegistryCreated>(v7);
        0x2::transfer::share_object<KindRegistry>(v0);
        0x2::transfer::transfer<KindAdminCap>(v6, 0x2::tx_context::sender(arg0));
    }

    fun insert_descriptor_unchecked(arg0: &mut KindRegistry, arg1: u32, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64) {
        assert_descriptor_well_formed(arg3, arg4, arg5, arg6, arg7);
        let v0 = KindDescriptor{
            version                  : 1,
            kind                     : arg1,
            name                     : arg2,
            op_mask                  : arg3,
            read_mode_mask           : arg4,
            has_active_binding       : arg5,
            requires_download_policy : arg6,
            default_grant_scope_mask : arg7,
            deprecated               : false,
        };
        0x2::table::add<u32, KindDescriptor>(&mut arg0.kinds, arg1, v0);
        0x2::table::add<0x1::string::String, u32>(&mut arg0.name_to_kind, arg2, arg1);
        let v1 = KindRegistered{
            registry_id              : 0x2::object::id<KindRegistry>(arg0),
            kind                     : arg1,
            name                     : arg2,
            op_mask                  : arg3,
            read_mode_mask           : arg4,
            has_active_binding       : arg5,
            requires_download_policy : arg6,
            default_grant_scope_mask : arg7,
        };
        0x2::event::emit<KindRegistered>(v1);
    }

    fun is_single_bit(arg0: u64) : bool {
        arg0 != 0 && arg0 & arg0 - 1 == 0
    }

    public fun kind_audio() : u32 {
        4
    }

    public fun kind_for_name(arg0: &KindRegistry, arg1: 0x1::string::String) : u32 {
        assert!(0x2::table::contains<0x1::string::String, u32>(&arg0.name_to_kind, arg1), 3);
        *0x2::table::borrow<0x1::string::String, u32>(&arg0.name_to_kind, arg1)
    }

    public fun kind_memory() : u32 {
        1
    }

    public fun kind_skill() : u32 {
        2
    }

    public fun kind_soul_doc() : u32 {
        0
    }

    public fun kind_sprite() : u32 {
        3
    }

    public fun next_kind(arg0: &KindRegistry) : u32 {
        arg0.next_kind
    }

    public fun op_active_bind() : u64 {
        8
    }

    public fun op_append() : u64 {
        1
    }

    public fun op_delete() : u64 {
        2
    }

    public fun op_purge() : u64 {
        4
    }

    public fun protocol_version() : u64 {
        1
    }

    public fun reactivate_kind(arg0: &mut KindRegistry, arg1: &KindAdminCap, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u32, KindDescriptor>(&arg0.kinds, arg2), 3);
        let v0 = 0x2::table::borrow_mut<u32, KindDescriptor>(&mut arg0.kinds, arg2);
        v0.deprecated = false;
        let v1 = KindReactivated{
            registry_id : 0x2::object::id<KindRegistry>(arg0),
            kind        : arg2,
            name        : v0.name,
        };
        0x2::event::emit<KindReactivated>(v1);
    }

    public fun read_grant() : u64 {
        2
    }

    public fun read_owner() : u64 {
        1
    }

    public fun read_paid() : u64 {
        4
    }

    public fun read_public() : u64 {
        8
    }

    public fun register_kind(arg0: &mut KindRegistry, arg1: &KindAdminCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : u32 {
        assert_valid_kind_name(&arg2);
        assert!(!0x2::table::contains<0x1::string::String, u32>(&arg0.name_to_kind, arg2), 2);
        let v0 = arg0.next_kind;
        arg0.next_kind = v0 + 1;
        insert_descriptor_unchecked(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7);
        v0
    }

    public fun registry_id(arg0: &KindRegistry) : 0x2::object::ID {
        0x2::object::id<KindRegistry>(arg0)
    }

    public fun registry_version(arg0: &KindRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

