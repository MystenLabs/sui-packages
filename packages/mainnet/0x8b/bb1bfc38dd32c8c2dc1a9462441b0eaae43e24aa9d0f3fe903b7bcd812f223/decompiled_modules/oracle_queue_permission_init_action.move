module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue_permission_init_action {
    struct PermissionInitParams has copy, drop {
        authority: address,
        granter: address,
        grantee: address,
        now: u64,
    }

    fun actuate<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg1: &PermissionInitParams, arg2: &mut 0x2::tx_context::TxContext) {
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::permission_create<T0>(arg0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::new(arg1.authority, arg1.granter, arg1.grantee, arg1.now, arg2));
    }

    public entry fun run<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg1: address, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PermissionInitParams{
            authority : arg1,
            granter   : arg2,
            grantee   : arg3,
            now       : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        validate(&v0);
        actuate<T0>(arg0, &v0, arg5);
    }

    public fun validate(arg0: &PermissionInitParams) {
    }

    // decompiled from Move bytecode v6
}

