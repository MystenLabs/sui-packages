module 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group {
    struct PermissionsAdmin has drop {
        dummy_field: bool,
    }

    struct ExtensionPermissionsAdmin has drop {
        dummy_field: bool,
    }

    struct ObjectAdmin has drop {
        dummy_field: bool,
    }

    struct GroupDeleter has drop {
        dummy_field: bool,
    }

    struct PermissionedGroup<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        permissions: 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::PermissionsTable,
        permissions_admin_count: u64,
        creator: address,
    }

    struct PausedMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct GroupCreated<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        creator: address,
    }

    struct GroupDerived<phantom T0, T1: copy + drop> has copy, drop {
        group_id: 0x2::object::ID,
        creator: address,
        parent_id: 0x2::object::ID,
        derivation_key: T1,
    }

    struct MemberAdded<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        member: address,
    }

    struct MemberRemoved<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        member: address,
    }

    struct PermissionsGranted<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        member: address,
        permissions: vector<0x1::type_name::TypeName>,
    }

    struct PermissionsRevoked<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        member: address,
        permissions: vector<0x1::type_name::TypeName>,
    }

    struct GroupDeleted<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        deleter: address,
    }

    struct GroupPaused<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        paused_by: address,
    }

    struct GroupUnpaused<phantom T0> has copy, drop {
        group_id: 0x2::object::ID,
        unpaused_by: address,
    }

    public fun delete<T0: drop>(arg0: PermissionedGroup<T0>, arg1: &0x2::tx_context::TxContext) : (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::PermissionsTable, u64, address) {
        assert!(!is_paused<T0>(&arg0), 4);
        assert!(has_permission<T0, GroupDeleter>(&arg0, 0x2::tx_context::sender(arg1)), 0);
        let PermissionedGroup {
            id                      : v0,
            permissions             : v1,
            permissions_admin_count : v2,
            creator                 : v3,
        } = arg0;
        let v4 = v0;
        let v5 = GroupDeleted<T0>{
            group_id : 0x2::object::uid_to_inner(&v4),
            deleter  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<GroupDeleted<T0>>(v5);
        0x2::object::delete(v4);
        (v1, v2, v3)
    }

    public fun new<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : PermissionedGroup<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = GroupCreated<T0>{
            group_id : 0x2::object::uid_to_inner(&v0),
            creator  : v1,
        };
        0x2::event::emit<GroupCreated<T0>>(v2);
        let v3 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v3, 0x1::type_name::with_original_ids<PermissionsAdmin>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v3, 0x1::type_name::with_original_ids<ExtensionPermissionsAdmin>());
        let v4 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::new_derived(&mut v0, 0x1::string::utf8(b"permissions_table"));
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::add_member(&mut v4, v1, v3);
        let v5 = PermissionedGroup<T0>{
            id                      : v0,
            permissions             : v4,
            permissions_admin_count : 1,
            creator                 : v1,
        };
        let v6 = MemberAdded<T0>{
            group_id : 0x2::object::id<PermissionedGroup<T0>>(&v5),
            member   : v1,
        };
        0x2::event::emit<MemberAdded<T0>>(v6);
        let v7 = PermissionsGranted<T0>{
            group_id    : 0x2::object::id<PermissionedGroup<T0>>(&v5),
            member      : v1,
            permissions : 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v3),
        };
        0x2::event::emit<PermissionsGranted<T0>>(v7);
        v5
    }

    public fun creator<T0: drop>(arg0: &PermissionedGroup<T0>) : address {
        arg0.creator
    }

    public fun grant_permission<T0: drop, T1: drop>(arg0: &mut PermissionedGroup<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_paused<T0>(arg0), 4);
        if (is_core_permission<T1>()) {
            assert!(has_permission<T0, PermissionsAdmin>(arg0, 0x2::tx_context::sender(arg2)), 0);
        } else {
            assert!(has_permission<T0, ExtensionPermissionsAdmin>(arg0, 0x2::tx_context::sender(arg2)), 0);
        };
        internal_grant_permission<T0, T1>(arg0, arg1);
    }

    public fun has_permission<T0: drop, T1: drop>(arg0: &PermissionedGroup<T0>, arg1: address) : bool {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::has_permission(&arg0.permissions, arg1, &v0)
    }

    fun internal_grant_permission<T0: drop, T1: drop>(arg0: &mut PermissionedGroup<T0>, arg1: address) {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        if (is_member<T0>(arg0, arg1)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::add_permission(&mut arg0.permissions, arg1, v0);
        } else {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::add_member(&mut arg0.permissions, arg1, 0x2::vec_set::singleton<0x1::type_name::TypeName>(v0));
            let v1 = MemberAdded<T0>{
                group_id : 0x2::object::id<PermissionedGroup<T0>>(arg0),
                member   : arg1,
            };
            0x2::event::emit<MemberAdded<T0>>(v1);
        };
        if (v0 == 0x1::type_name::with_original_ids<PermissionsAdmin>()) {
            arg0.permissions_admin_count = arg0.permissions_admin_count + 1;
        };
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, v0);
        let v3 = PermissionsGranted<T0>{
            group_id    : 0x2::object::id<PermissionedGroup<T0>>(arg0),
            member      : arg1,
            permissions : v2,
        };
        0x2::event::emit<PermissionsGranted<T0>>(v3);
    }

    fun internal_revoke_permission<T0: drop, T1: drop>(arg0: &mut PermissionedGroup<T0>, arg1: address) {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        if (v0 == 0x1::type_name::with_original_ids<PermissionsAdmin>()) {
            safe_decrement_permissions_admin_count<T0>(arg0, arg1);
        };
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::with_original_ids<T1>());
        let v2 = PermissionsRevoked<T0>{
            group_id    : 0x2::object::id<PermissionedGroup<T0>>(arg0),
            member      : arg1,
            permissions : v1,
        };
        0x2::event::emit<PermissionsRevoked<T0>>(v2);
        if (0x2::vec_set::is_empty<0x1::type_name::TypeName>(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::remove_permission(&mut arg0.permissions, arg1, &v0))) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::remove_member(&mut arg0.permissions, arg1);
            let v3 = MemberRemoved<T0>{
                group_id : 0x2::object::id<PermissionedGroup<T0>>(arg0),
                member   : arg1,
            };
            0x2::event::emit<MemberRemoved<T0>>(v3);
        };
    }

    fun is_core_permission<T0: drop>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (v0 == 0x1::type_name::with_original_ids<PermissionsAdmin>()) {
            true
        } else if (v0 == 0x1::type_name::with_original_ids<ExtensionPermissionsAdmin>()) {
            true
        } else if (v0 == 0x1::type_name::with_original_ids<ObjectAdmin>()) {
            true
        } else {
            v0 == 0x1::type_name::with_original_ids<GroupDeleter>()
        }
    }

    public fun is_member<T0: drop>(arg0: &PermissionedGroup<T0>, arg1: address) : bool {
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::is_member(&arg0.permissions, arg1)
    }

    public fun is_paused<T0: drop>(arg0: &PermissionedGroup<T0>) : bool {
        let v0 = PausedMarker{dummy_field: false};
        0x2::dynamic_field::exists_<PausedMarker>(&arg0.id, v0)
    }

    public fun member_count<T0: drop>(arg0: &PermissionedGroup<T0>) : u64 {
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::length(&arg0.permissions)
    }

    public fun new_derived<T0: drop, T1: copy + drop + store>(arg0: T0, arg1: &mut 0x2::object::UID, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) : PermissionedGroup<T0> {
        assert!(!0x2::derived_object::exists<T1>(arg1, arg2), 3);
        let v0 = 0x2::derived_object::claim<T1>(arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = GroupDerived<T0, T1>{
            group_id       : 0x2::object::uid_to_inner(&v0),
            creator        : v1,
            parent_id      : 0x2::object::uid_to_inner(arg1),
            derivation_key : arg2,
        };
        0x2::event::emit<GroupDerived<T0, T1>>(v2);
        let v3 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v3, 0x1::type_name::with_original_ids<PermissionsAdmin>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v3, 0x1::type_name::with_original_ids<ExtensionPermissionsAdmin>());
        let v4 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::new_derived(&mut v0, 0x1::string::utf8(b"permissions_table"));
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::add_member(&mut v4, v1, v3);
        let v5 = PermissionedGroup<T0>{
            id                      : v0,
            permissions             : v4,
            permissions_admin_count : 1,
            creator                 : v1,
        };
        let v6 = MemberAdded<T0>{
            group_id : 0x2::object::id<PermissionedGroup<T0>>(&v5),
            member   : v1,
        };
        0x2::event::emit<MemberAdded<T0>>(v6);
        let v7 = PermissionsGranted<T0>{
            group_id    : 0x2::object::id<PermissionedGroup<T0>>(&v5),
            member      : v1,
            permissions : 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v3),
        };
        0x2::event::emit<PermissionsGranted<T0>>(v7);
        v5
    }

    public fun object_grant_permission<T0: drop, T1: drop>(arg0: &mut PermissionedGroup<T0>, arg1: &0x2::object::UID, arg2: address) {
        assert!(!is_paused<T0>(arg0), 4);
        if (is_core_permission<T1>()) {
            assert!(has_permission<T0, PermissionsAdmin>(arg0, 0x2::object::uid_to_address(arg1)), 0);
        } else {
            assert!(has_permission<T0, ExtensionPermissionsAdmin>(arg0, 0x2::object::uid_to_address(arg1)), 0);
        };
        internal_grant_permission<T0, T1>(arg0, arg2);
    }

    public fun object_remove_member<T0: drop>(arg0: &mut PermissionedGroup<T0>, arg1: &0x2::object::UID, arg2: address) {
        assert!(!is_paused<T0>(arg0), 4);
        assert!(has_permission<T0, PermissionsAdmin>(arg0, 0x2::object::uid_to_address(arg1)), 0);
        assert!(is_member<T0>(arg0, arg2), 1);
        safe_decrement_permissions_admin_count<T0>(arg0, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::remove_member(&mut arg0.permissions, arg2);
        let v0 = MemberRemoved<T0>{
            group_id : 0x2::object::id<PermissionedGroup<T0>>(arg0),
            member   : arg2,
        };
        0x2::event::emit<MemberRemoved<T0>>(v0);
    }

    public fun object_revoke_permission<T0: drop, T1: drop>(arg0: &mut PermissionedGroup<T0>, arg1: &0x2::object::UID, arg2: address) {
        assert!(!is_paused<T0>(arg0), 4);
        if (is_core_permission<T1>()) {
            assert!(has_permission<T0, PermissionsAdmin>(arg0, 0x2::object::uid_to_address(arg1)), 0);
        } else {
            assert!(has_permission<T0, ExtensionPermissionsAdmin>(arg0, 0x2::object::uid_to_address(arg1)), 0);
        };
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::is_member(&arg0.permissions, arg2), 1);
        internal_revoke_permission<T0, T1>(arg0, arg2);
    }

    public fun object_uid<T0: drop>(arg0: &PermissionedGroup<T0>, arg1: &0x2::object::UID) : &0x2::object::UID {
        assert!(!is_paused<T0>(arg0), 4);
        assert!(has_permission<T0, ObjectAdmin>(arg0, 0x2::object::uid_to_address(arg1)), 0);
        &arg0.id
    }

    public fun object_uid_mut<T0: drop>(arg0: &mut PermissionedGroup<T0>, arg1: &0x2::object::UID) : &mut 0x2::object::UID {
        assert!(!is_paused<T0>(arg0), 4);
        assert!(has_permission<T0, ObjectAdmin>(arg0, 0x2::object::uid_to_address(arg1)), 0);
        &mut arg0.id
    }

    public fun pause<T0: drop>(arg0: &mut PermissionedGroup<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::unpause_cap::UnpauseCap<T0> {
        assert!(has_permission<T0, PermissionsAdmin>(arg0, 0x2::tx_context::sender(arg1)), 0);
        assert!(!is_paused<T0>(arg0), 5);
        let v0 = PausedMarker{dummy_field: false};
        0x2::dynamic_field::add<PausedMarker, bool>(&mut arg0.id, v0, true);
        let v1 = GroupPaused<T0>{
            group_id  : 0x2::object::id<PermissionedGroup<T0>>(arg0),
            paused_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<GroupPaused<T0>>(v1);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::unpause_cap::new<T0>(0x2::object::id<PermissionedGroup<T0>>(arg0), arg1)
    }

    public fun permissions_admin_count<T0: drop>(arg0: &PermissionedGroup<T0>) : u64 {
        arg0.permissions_admin_count
    }

    public fun remove_member<T0: drop>(arg0: &mut PermissionedGroup<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_paused<T0>(arg0), 4);
        assert!(has_permission<T0, PermissionsAdmin>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(is_member<T0>(arg0, arg1), 1);
        safe_decrement_permissions_admin_count<T0>(arg0, arg1);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::remove_member(&mut arg0.permissions, arg1);
        let v0 = MemberRemoved<T0>{
            group_id : 0x2::object::id<PermissionedGroup<T0>>(arg0),
            member   : arg1,
        };
        0x2::event::emit<MemberRemoved<T0>>(v0);
    }

    public fun revoke_permission<T0: drop, T1: drop>(arg0: &mut PermissionedGroup<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_paused<T0>(arg0), 4);
        if (is_core_permission<T1>()) {
            assert!(has_permission<T0, PermissionsAdmin>(arg0, 0x2::tx_context::sender(arg2)), 0);
        } else {
            assert!(has_permission<T0, ExtensionPermissionsAdmin>(arg0, 0x2::tx_context::sender(arg2)), 0);
        };
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::is_member(&arg0.permissions, arg1), 1);
        internal_revoke_permission<T0, T1>(arg0, arg1);
    }

    fun safe_decrement_permissions_admin_count<T0: drop>(arg0: &mut PermissionedGroup<T0>, arg1: address) {
        let v0 = 0x1::type_name::with_original_ids<PermissionsAdmin>();
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table::has_permission(&arg0.permissions, arg1, &v0)) {
            assert!(arg0.permissions_admin_count > 1, 2);
            arg0.permissions_admin_count = arg0.permissions_admin_count - 1;
        };
    }

    public fun unpause<T0: drop>(arg0: &mut PermissionedGroup<T0>, arg1: 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::unpause_cap::UnpauseCap<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::unpause_cap::group_id<T0>(&arg1) == 0x2::object::id<PermissionedGroup<T0>>(arg0), 6);
        let v0 = PausedMarker{dummy_field: false};
        0x2::dynamic_field::remove<PausedMarker, bool>(&mut arg0.id, v0);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::unpause_cap::delete<T0>(arg1);
        let v1 = GroupUnpaused<T0>{
            group_id    : 0x2::object::id<PermissionedGroup<T0>>(arg0),
            unpaused_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GroupUnpaused<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

