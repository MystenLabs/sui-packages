module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue_init_action {
    fun actuate<T0>(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: address, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::share_oracle_queue<T0>(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_create<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public entry fun run<T0>(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: address, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        validate<T0>();
        actuate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg9) / 1000, arg7, arg8, arg10);
    }

    public fun validate<T0>() {
    }

    // decompiled from Move bytecode v6
}

