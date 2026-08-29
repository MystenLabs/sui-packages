module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue_permission_set_action {
    struct PermissionSetParams has copy, drop {
        authority: address,
        granter: address,
        grantee: address,
        permission: u64,
        enable: bool,
        now: u64,
    }

    fun actuate<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg1: &PermissionSetParams) {
        if (arg1.enable) {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::set(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::permission_mut<T0>(arg0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::key(&arg1.authority, &arg1.granter, &arg1.grantee)), arg1.permission, arg1.now);
        } else {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::unset(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::permission_mut<T0>(arg0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::key(&arg1.authority, &arg1.granter, &arg1.grantee)), arg1.permission, arg1.now);
        };
    }

    public entry fun run<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = PermissionSetParams{
            authority  : arg1,
            granter    : arg2,
            grantee    : arg3,
            permission : arg4,
            enable     : arg5,
            now        : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        validate<T0>(arg0, &v0, arg7);
        actuate<T0>(arg0, &v0);
    }

    public fun validate<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg1: &PermissionSetParams, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::authority(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::permission<T0>(arg0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::key(&arg1.authority, &arg1.granter, &arg1.grantee))) == 0x2::tx_context::sender(arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
    }

    // decompiled from Move bytecode v6
}

