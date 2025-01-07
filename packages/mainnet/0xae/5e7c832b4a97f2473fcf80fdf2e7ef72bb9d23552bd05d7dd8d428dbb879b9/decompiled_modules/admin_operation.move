module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation {
    struct CreateRole {
        name: 0x1::ascii::String,
    }

    struct CreateSigner {
        address: address,
    }

    struct GrantRole {
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
        address: address,
    }

    struct RevokeRole {
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
        address: address,
    }

    struct DeleteRole {
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
    }

    struct DeleteSigner {
        address: address,
    }

    struct RenameRole {
        role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
        name: 0x1::ascii::String,
    }

    struct CreatePermission {
        name: 0x1::ascii::String,
        threshold: u64,
        proposer: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
        approver: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
    }

    struct UpdatePermission {
        id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
        name: 0x1::ascii::String,
        threshold: u64,
        proposer: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
        approver: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>,
    }

    struct DeletePermission {
        permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
    }

    struct UpdateAdminPolicy {
        operation_type: 0x1::ascii::String,
        permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
    }

    struct UpdateCoinPolicy {
        coin_type: 0x1::ascii::String,
        stages: vector<u64>,
        permission_ids: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>>,
    }

    struct UpdateObjectPolicy {
        object_id: 0x2::object::ID,
        permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>,
    }

    struct DeleteAdminPolicy {
        operation_type: 0x1::ascii::String,
    }

    struct DeleteCoinPolicy {
        coin_type: 0x1::ascii::String,
    }

    struct DeleteObjectPolicy {
        object_id: 0x2::object::ID,
    }

    struct AllowlistEnable {
        enable: bool,
    }

    struct AllowlistCoinUpdate {
        coin_type: 0x1::ascii::String,
        addresses: vector<address>,
    }

    struct AllowlistObjectUpdate {
        object_id: 0x2::object::ID,
        addresses: vector<address>,
    }

    struct AllowlistDefaultUpdate {
        addresses: vector<address>,
    }

    struct AllowlistCoinDelete {
        coin_type: 0x1::ascii::String,
    }

    struct AllowlistObjectDelete {
        object_id: 0x2::object::ID,
    }

    struct CreateSpendingLimit {
        spender: address,
        coin_type: 0x1::ascii::String,
        start_time_ms: u64,
        period_ms: u64,
        limit: u64,
    }

    struct DeleteSpendingLimit {
        spender: address,
        coin_type: 0x1::ascii::String,
        spending_limit_id: u64,
    }

    struct UpdateMetaInfo {
        name: 0x1::ascii::String,
        uri: 0x1::ascii::String,
    }

    struct UpdateTimelockConfig {
        timelock_duration: u64,
        execution_duration: u64,
    }

    public fun allowlist_coin_delete_destruct(arg0: AllowlistCoinDelete) : 0x1::ascii::String {
        let AllowlistCoinDelete { coin_type: v0 } = arg0;
        v0
    }

    public fun allowlist_coin_update_destruct(arg0: AllowlistCoinUpdate) : (0x1::ascii::String, vector<address>) {
        let AllowlistCoinUpdate {
            coin_type : v0,
            addresses : v1,
        } = arg0;
        (v0, v1)
    }

    public fun allowlist_default_update_destruct(arg0: AllowlistDefaultUpdate) : vector<address> {
        let AllowlistDefaultUpdate { addresses: v0 } = arg0;
        v0
    }

    public fun allowlist_enable_destruct(arg0: AllowlistEnable) : bool {
        let AllowlistEnable { enable: v0 } = arg0;
        v0
    }

    public fun allowlist_object_delete_destruct(arg0: AllowlistObjectDelete) : 0x2::object::ID {
        let AllowlistObjectDelete { object_id: v0 } = arg0;
        v0
    }

    public fun allowlist_object_update_destruct(arg0: AllowlistObjectUpdate) : (0x2::object::ID, vector<address>) {
        let AllowlistObjectUpdate {
            object_id : v0,
            addresses : v1,
        } = arg0;
        (v0, v1)
    }

    public fun create_permission_destruct(arg0: CreatePermission) : (0x1::ascii::String, u64, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>) {
        let CreatePermission {
            name      : v0,
            threshold : v1,
            proposer  : v2,
            approver  : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun create_role_destruct(arg0: CreateRole) : 0x1::ascii::String {
        let CreateRole { name: v0 } = arg0;
        v0
    }

    public fun create_signer_destruct(arg0: CreateSigner) : address {
        let CreateSigner { address: v0 } = arg0;
        v0
    }

    public fun create_spending_limit_destruct(arg0: CreateSpendingLimit) : (address, 0x1::ascii::String, u64, u64, u64) {
        let CreateSpendingLimit {
            spender       : v0,
            coin_type     : v1,
            start_time_ms : v2,
            period_ms     : v3,
            limit         : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public fun delete_admin_policy_destruct(arg0: DeleteAdminPolicy) : 0x1::ascii::String {
        let DeleteAdminPolicy { operation_type: v0 } = arg0;
        v0
    }

    public fun delete_coin_policy_destruct(arg0: DeleteCoinPolicy) : 0x1::ascii::String {
        let DeleteCoinPolicy { coin_type: v0 } = arg0;
        v0
    }

    public fun delete_object_policy_destruct(arg0: DeleteObjectPolicy) : 0x2::object::ID {
        let DeleteObjectPolicy { object_id: v0 } = arg0;
        v0
    }

    public fun delete_permission_destruct(arg0: DeletePermission) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID> {
        let DeletePermission { permission_id: v0 } = arg0;
        v0
    }

    public fun delete_role_destruct(arg0: DeleteRole) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID> {
        let DeleteRole { role_id: v0 } = arg0;
        v0
    }

    public fun delete_signer_destruct(arg0: DeleteSigner) : address {
        let DeleteSigner { address: v0 } = arg0;
        v0
    }

    public fun delete_spending_limit_destruct(arg0: DeleteSpendingLimit) : (address, 0x1::ascii::String, u64) {
        let DeleteSpendingLimit {
            spender           : v0,
            coin_type         : v1,
            spending_limit_id : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun deserialize_allowlist_coin_delete(arg0: vector<u8>) : AllowlistCoinDelete {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        AllowlistCoinDelete{coin_type: 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0))}
    }

    public fun deserialize_allowlist_coin_update(arg0: vector<u8>) : AllowlistCoinUpdate {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        AllowlistCoinUpdate{
            coin_type : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            addresses : 0x2::bcs::peel_vec_address(&mut v0),
        }
    }

    public fun deserialize_allowlist_default_update(arg0: vector<u8>) : AllowlistDefaultUpdate {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        AllowlistDefaultUpdate{addresses: 0x2::bcs::peel_vec_address(&mut v0)}
    }

    public fun deserialize_allowlist_enable(arg0: vector<u8>) : AllowlistEnable {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        AllowlistEnable{enable: 0x2::bcs::peel_bool(&mut v0)}
    }

    public fun deserialize_allowlist_object_delete(arg0: vector<u8>) : AllowlistObjectDelete {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        AllowlistObjectDelete{object_id: 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0))}
    }

    public fun deserialize_allowlist_object_update(arg0: vector<u8>) : AllowlistObjectUpdate {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        AllowlistObjectUpdate{
            object_id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            addresses : 0x2::bcs::peel_vec_address(&mut v0),
        }
    }

    public fun deserialize_create_permission(arg0: vector<u8>) : CreatePermission {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        CreatePermission{
            name      : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            threshold : 0x2::bcs::peel_u64(&mut v0),
            proposer  : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0),
            approver  : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0),
        }
    }

    public fun deserialize_create_role(arg0: vector<u8>) : CreateRole {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        CreateRole{name: 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0))}
    }

    public fun deserialize_create_signer(arg0: vector<u8>) : CreateSigner {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        CreateSigner{address: 0x2::bcs::peel_address(&mut v0)}
    }

    public fun deserialize_create_spending_limit(arg0: vector<u8>) : CreateSpendingLimit {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        CreateSpendingLimit{
            spender       : 0x2::bcs::peel_address(&mut v0),
            coin_type     : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            start_time_ms : 0x2::bcs::peel_u64(&mut v0),
            period_ms     : 0x2::bcs::peel_u64(&mut v0),
            limit         : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun deserialize_delete_admin_policy(arg0: vector<u8>) : DeleteAdminPolicy {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        DeleteAdminPolicy{operation_type: 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0))}
    }

    public fun deserialize_delete_coin_policy(arg0: vector<u8>) : DeleteCoinPolicy {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        DeleteCoinPolicy{coin_type: 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0))}
    }

    public fun deserialize_delete_object_policy(arg0: vector<u8>) : DeleteObjectPolicy {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        DeleteObjectPolicy{object_id: 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0))}
    }

    public fun deserialize_delete_permission(arg0: vector<u8>) : DeletePermission {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        DeletePermission{permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_permission_query_id(&mut v0)}
    }

    public fun deserialize_delete_role(arg0: vector<u8>) : DeleteRole {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        DeleteRole{role_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0)}
    }

    public fun deserialize_delete_signer(arg0: vector<u8>) : DeleteSigner {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        DeleteSigner{address: 0x2::bcs::peel_address(&mut v0)}
    }

    public fun deserialize_delete_spending_limit(arg0: vector<u8>) : DeleteSpendingLimit {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        DeleteSpendingLimit{
            spender           : 0x2::bcs::peel_address(&mut v0),
            coin_type         : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            spending_limit_id : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun deserialize_grant_role(arg0: vector<u8>) : GrantRole {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        GrantRole{
            role_id : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0),
            address : 0x2::bcs::peel_address(&mut v0),
        }
    }

    public fun deserialize_rename_role(arg0: vector<u8>) : RenameRole {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        RenameRole{
            role_id : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0),
            name    : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
        }
    }

    public fun deserialize_revoke_role(arg0: vector<u8>) : RevokeRole {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        RevokeRole{
            role_id : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0),
            address : 0x2::bcs::peel_address(&mut v0),
        }
    }

    public fun deserialize_update_admin_policy(arg0: vector<u8>) : UpdateAdminPolicy {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        UpdateAdminPolicy{
            operation_type : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            permission_id  : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_permission_query_id(&mut v0),
        }
    }

    public fun deserialize_update_coin_policy(arg0: vector<u8>) : UpdateCoinPolicy {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        UpdateCoinPolicy{
            coin_type      : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            stages         : 0x2::bcs::peel_vec_u64(&mut v0),
            permission_ids : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_vec_permission_query_id(&mut v0),
        }
    }

    public fun deserialize_update_meta_info(arg0: vector<u8>) : UpdateMetaInfo {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        UpdateMetaInfo{
            name : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            uri  : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
        }
    }

    public fun deserialize_update_object_policy(arg0: vector<u8>) : UpdateObjectPolicy {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        UpdateObjectPolicy{
            object_id     : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            permission_id : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_permission_query_id(&mut v0),
        }
    }

    public fun deserialize_update_permission(arg0: vector<u8>) : UpdatePermission {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        UpdatePermission{
            id        : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_permission_query_id(&mut v0),
            name      : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            threshold : 0x2::bcs::peel_u64(&mut v0),
            proposer  : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0),
            approver  : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_role_query_id(&mut v0),
        }
    }

    public fun deserialize_update_timelock_config(arg0: vector<u8>) : UpdateTimelockConfig {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        UpdateTimelockConfig{
            timelock_duration  : 0x2::bcs::peel_u64(&mut v0),
            execution_duration : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun grant_role_destruct(arg0: GrantRole) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>, address) {
        let GrantRole {
            role_id : v0,
            address : v1,
        } = arg0;
        (v0, v1)
    }

    public fun is_allowlist_range_operation(arg0: u64) : bool {
        arg0 >= 30000 && arg0 <= 39999
    }

    public fun is_meta_info_range_operation(arg0: u64) : bool {
        arg0 >= 50000 && arg0 <= 59999
    }

    public fun is_op_allowlist_coin_delete(arg0: u64) : bool {
        arg0 == 30004
    }

    public fun is_op_allowlist_coin_update(arg0: u64) : bool {
        arg0 == 30001
    }

    public fun is_op_allowlist_default_update(arg0: u64) : bool {
        arg0 == 30003
    }

    public fun is_op_allowlist_enable(arg0: u64) : bool {
        arg0 == 30000
    }

    public fun is_op_allowlist_object_delete(arg0: u64) : bool {
        arg0 == 30005
    }

    public fun is_op_allowlist_object_update(arg0: u64) : bool {
        arg0 == 30002
    }

    public fun is_op_create_permission(arg0: u64) : bool {
        arg0 == 10000
    }

    public fun is_op_create_role(arg0: u64) : bool {
        arg0 == 0
    }

    public fun is_op_create_signer(arg0: u64) : bool {
        arg0 == 1
    }

    public fun is_op_create_spending_limit(arg0: u64) : bool {
        arg0 == 40000
    }

    public fun is_op_delete_admin_policy(arg0: u64) : bool {
        arg0 == 20003
    }

    public fun is_op_delete_coin_policy(arg0: u64) : bool {
        arg0 == 20004
    }

    public fun is_op_delete_object_policy(arg0: u64) : bool {
        arg0 == 20005
    }

    public fun is_op_delete_permission(arg0: u64) : bool {
        arg0 == 10002
    }

    public fun is_op_delete_role(arg0: u64) : bool {
        arg0 == 4
    }

    public fun is_op_delete_signer(arg0: u64) : bool {
        arg0 == 5
    }

    public fun is_op_delete_spending_limit(arg0: u64) : bool {
        arg0 == 40001
    }

    public fun is_op_grant_role(arg0: u64) : bool {
        arg0 == 2
    }

    public fun is_op_rename_role(arg0: u64) : bool {
        arg0 == 6
    }

    public fun is_op_revoke_role(arg0: u64) : bool {
        arg0 == 3
    }

    public fun is_op_update_admin_policy(arg0: u64) : bool {
        arg0 == 20000
    }

    public fun is_op_update_coin_policy(arg0: u64) : bool {
        arg0 == 20001
    }

    public fun is_op_update_meta_info(arg0: u64) : bool {
        arg0 == 50000
    }

    public fun is_op_update_object_policy(arg0: u64) : bool {
        arg0 == 20002
    }

    public fun is_op_update_permission(arg0: u64) : bool {
        arg0 == 10001
    }

    public fun is_op_update_timelock_config(arg0: u64) : bool {
        arg0 == 60000
    }

    public fun is_permission_range_operation(arg0: u64) : bool {
        arg0 >= 10000 && arg0 <= 19999
    }

    public fun is_policy_range_operation(arg0: u64) : bool {
        arg0 >= 20000 && arg0 <= 29999
    }

    public fun is_role_range_operation(arg0: u64) : bool {
        arg0 >= 0 && arg0 <= 9999
    }

    public fun is_spending_limit_range_operation(arg0: u64) : bool {
        arg0 >= 40000 && arg0 <= 49999
    }

    public fun is_timelock_config_range_opertaion(arg0: u64) : bool {
        arg0 >= 60000 && arg0 <= 69999
    }

    public fun rename_role_destruct(arg0: RenameRole) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>, 0x1::ascii::String) {
        let RenameRole {
            role_id : v0,
            name    : v1,
        } = arg0;
        (v0, v1)
    }

    public fun revoke_role_destruct(arg0: RevokeRole) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>, address) {
        let RevokeRole {
            role_id : v0,
            address : v1,
        } = arg0;
        (v0, v1)
    }

    public fun update_admin_policy_destruct(arg0: UpdateAdminPolicy) : (0x1::ascii::String, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>) {
        let UpdateAdminPolicy {
            operation_type : v0,
            permission_id  : v1,
        } = arg0;
        (v0, v1)
    }

    public fun update_coin_policy_destruct(arg0: UpdateCoinPolicy) : (0x1::ascii::String, vector<u64>, vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>>) {
        let UpdateCoinPolicy {
            coin_type      : v0,
            stages         : v1,
            permission_ids : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun update_meta_info_destruct(arg0: UpdateMetaInfo) : (0x1::ascii::String, 0x1::ascii::String) {
        let UpdateMetaInfo {
            name : v0,
            uri  : v1,
        } = arg0;
        (v0, v1)
    }

    public fun update_object_policy_destruct(arg0: UpdateObjectPolicy) : (0x2::object::ID, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>) {
        let UpdateObjectPolicy {
            object_id     : v0,
            permission_id : v1,
        } = arg0;
        (v0, v1)
    }

    public fun update_permission_destruct(arg0: UpdatePermission) : (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID>, 0x1::ascii::String, u64, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::QueryID<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::RoleID>) {
        let UpdatePermission {
            id        : v0,
            name      : v1,
            threshold : v2,
            proposer  : v3,
            approver  : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public fun update_timelock_config_destruct(arg0: UpdateTimelockConfig) : (u64, u64) {
        let UpdateTimelockConfig {
            timelock_duration  : v0,
            execution_duration : v1,
        } = arg0;
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

