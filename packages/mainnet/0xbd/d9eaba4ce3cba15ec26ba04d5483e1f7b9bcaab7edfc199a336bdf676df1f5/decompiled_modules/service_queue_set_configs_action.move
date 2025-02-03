module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue_set_configs_action {
    fun actuate<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: address) {
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::set_configs<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun run<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        validate<T0>(arg0, arg10);
        actuate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun validate<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::has_authority<T0>(arg0, arg1), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
    }

    // decompiled from Move bytecode v6
}

