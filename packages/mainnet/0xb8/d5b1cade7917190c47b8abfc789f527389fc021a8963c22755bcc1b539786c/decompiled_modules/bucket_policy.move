module 0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::bucket_policy {
    struct WalrusConsole has drop {
        dummy_field: bool,
    }

    struct BucketAdmin has drop {
        dummy_field: bool,
    }

    struct BucketViewer has drop {
        dummy_field: bool,
    }

    struct BucketEditor has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BucketRegistry has store, key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        paused: bool,
        versioning: 0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::Versioning,
    }

    struct BucketDerivationKey has copy, drop, store {
        bucket_id: vector<u8>,
        creator: address,
    }

    struct BucketGroupCreated has copy, drop {
        group_id: 0x2::object::ID,
        creator: address,
        bucket_id: vector<u8>,
    }

    struct ProtocolPaused has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct ProtocolUnpaused has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct VersionEnabled has copy, drop {
        registry_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabled has copy, drop {
        registry_id: 0x2::object::ID,
        version: u64,
    }

    struct AdminCapTransferred has copy, drop {
        admin_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct BUCKET_POLICY has drop {
        dummy_field: bool,
    }

    public fun is_paused(arg0: &BucketRegistry) : bool {
        arg0.paused
    }

    entry fun add_admin(arg0: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>, arg1: &BucketRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::assert_version_allowed(&arg1.versioning);
        assert!(!arg1.paused, 7);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketAdmin>(arg0, arg2);
        let v1 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, arg2);
        assert!(!v0 || !v1, 3);
        if (!v0) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, BucketAdmin>(arg0, arg2, arg3);
        };
        if (!v1) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, arg2, arg3);
        };
    }

    entry fun add_editor(arg0: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>, arg1: &BucketRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::assert_version_allowed(&arg1.versioning);
        assert!(!arg1.paused, 7);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(!0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketEditor>(arg0, arg2), 3);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, BucketEditor>(arg0, arg2, arg3);
    }

    entry fun add_owner(arg0: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>, arg1: &BucketRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::assert_version_allowed(&arg1.versioning);
        assert!(!arg1.paused, 7);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketAdmin>(arg0, arg2);
        let v1 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, arg2);
        let v2 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, arg2);
        let v3 = if (!v0) {
            true
        } else if (!v1) {
            true
        } else {
            !v2
        };
        assert!(v3, 3);
        if (!v0) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, BucketAdmin>(arg0, arg2, arg3);
        };
        if (!v1) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, arg2, arg3);
        };
        if (!v2) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, arg2, arg3);
        };
    }

    entry fun add_viewer(arg0: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>, arg1: &BucketRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::assert_version_allowed(&arg1.versioning);
        assert!(!arg1.paused, 7);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(!0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketViewer>(arg0, arg2), 3);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, BucketViewer>(arg0, arg2, arg3);
    }

    public fun allowed_versions(arg0: &BucketRegistry) : vector<u64> {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::allowed_versions(&arg0.versioning)
    }

    entry fun create_and_share_bucket_group(arg0: &mut BucketRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>>(create_bucket_group(arg0, arg1, arg2));
    }

    public fun create_bucket_group(arg0: &mut BucketRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole> {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::assert_version_allowed(&arg0.versioning);
        assert!(!arg0.paused, 7);
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 > 0 && v0 <= 64, 8);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = WalrusConsole{dummy_field: false};
        let v3 = BucketDerivationKey{
            bucket_id : arg1,
            creator   : v1,
        };
        let v4 = 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::new_derived<WalrusConsole, BucketDerivationKey>(v2, &mut arg0.id, v3, arg2);
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::grant_permission<WalrusConsole, BucketAdmin>(&mut v4, v1, arg2);
        let v5 = BucketGroupCreated{
            group_id  : 0x2::object::id<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>>(&v4),
            creator   : v1,
            bucket_id : arg1,
        };
        0x2::event::emit<BucketGroupCreated>(v5);
        v4
    }

    public fun disable_version(arg0: &mut BucketRegistry, arg1: &AdminCap, arg2: u64) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 6);
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::disable(&mut arg0.versioning, arg2);
        let v0 = VersionDisabled{
            registry_id : 0x2::object::id<BucketRegistry>(arg0),
            version     : arg2,
        };
        0x2::event::emit<VersionDisabled>(v0);
    }

    public fun enable_version(arg0: &mut BucketRegistry, arg1: &AdminCap, arg2: u64) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 6);
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::enable(&mut arg0.versioning, arg2);
        let v0 = VersionEnabled{
            registry_id : 0x2::object::id<BucketRegistry>(arg0),
            version     : arg2,
        };
        0x2::event::emit<VersionEnabled>(v0);
    }

    fun init(arg0: BUCKET_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BUCKET_POLICY>(arg0, arg1);
        let (v0, v1) = new_registry(0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::new(), arg1);
        0x2::transfer::public_share_object<BucketRegistry>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun namespace(arg0: &0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>) : vector<u8> {
        let v0 = 0x2::object::id<0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>>(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    fun new_registry(arg0: 0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::Versioning, arg1: &mut 0x2::tx_context::TxContext) : (BucketRegistry, AdminCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = AdminCapKey{dummy_field: false};
        let v2 = AdminCap{id: 0x2::derived_object::claim<AdminCapKey>(&mut v0, v1)};
        let v3 = BucketRegistry{
            id           : v0,
            admin_cap_id : 0x2::object::id<AdminCap>(&v2),
            paused       : false,
            versioning   : arg0,
        };
        (v3, v2)
    }

    public fun pause(arg0: &mut BucketRegistry, arg1: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 6);
        arg0.paused = true;
        let v0 = ProtocolPaused{registry_id: 0x2::object::id<BucketRegistry>(arg0)};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    entry fun revoke_all_permissions(arg0: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>, arg1: &BucketRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::assert_version_allowed(&arg1.versioning);
        assert!(!arg1.paused, 7);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, 0x2::tx_context::sender(arg3)), 0);
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, arg2)) {
            assert!(0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::permissions_admin_count<WalrusConsole>(arg0) > 1, 1);
        };
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketAdmin>(arg0, arg2)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::revoke_permission<WalrusConsole, BucketAdmin>(arg0, arg2, arg3);
        };
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketEditor>(arg0, arg2)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::revoke_permission<WalrusConsole, BucketEditor>(arg0, arg2, arg3);
        };
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketViewer>(arg0, arg2)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::revoke_permission<WalrusConsole, BucketViewer>(arg0, arg2, arg3);
        };
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::GroupDeleter>(arg0, arg2)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::revoke_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::GroupDeleter>(arg0, arg2, arg3);
        };
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ObjectAdmin>(arg0, arg2)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::revoke_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ObjectAdmin>(arg0, arg2, arg3);
        };
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, arg2)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::revoke_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::ExtensionPermissionsAdmin>(arg0, arg2, arg3);
        };
        if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, arg2)) {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::revoke_permission<WalrusConsole, 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionsAdmin>(arg0, arg2, arg3);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &BucketRegistry, arg2: &0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<WalrusConsole>, arg3: &0x2::tx_context::TxContext) {
        0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::versioning::assert_version_allowed(&arg1.versioning);
        assert!(!arg1.paused, 7);
        assert!(0xb8d5b1cade7917190c47b8abfc789f527389fc021a8963c22755bcc1b539786c::utils::is_prefix(namespace(arg2), arg0), 2);
        assert!(!0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::is_paused<WalrusConsole>(arg2), 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketViewer>(arg2, v0)) {
            true
        } else if (0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketEditor>(arg2, v0)) {
            true
        } else {
            0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::has_permission<WalrusConsole, BucketAdmin>(arg2, v0)
        };
        assert!(v1, 0);
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        assert!(arg1 != @0x0, 10);
        let v0 = AdminCapTransferred{
            admin_cap_id : 0x2::object::id<AdminCap>(&arg0),
            recipient    : arg1,
        };
        0x2::event::emit<AdminCapTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun unpause(arg0: &mut BucketRegistry, arg1: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 6);
        arg0.paused = false;
        let v0 = ProtocolUnpaused{registry_id: 0x2::object::id<BucketRegistry>(arg0)};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    // decompiled from Move bytecode v7
}

