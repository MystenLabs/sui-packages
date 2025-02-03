module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::recovery_operation {
    struct PermissionRecovery {
        permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID,
    }

    public fun deserialize_permission_recovery(arg0: vector<u8>) : PermissionRecovery {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 1000);
        PermissionRecovery{permission_id: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::deserialize_permission_id(&mut v0)}
    }

    public fun is_op_permission_recovery(arg0: u64) : bool {
        arg0 == 0
    }

    public fun permission_recovery_destruct(arg0: PermissionRecovery) : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id::PermissionID {
        let PermissionRecovery { permission_id: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

