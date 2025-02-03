module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_init_action {
    fun actuate(arg0: vector<u8>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::new(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::new_oracle_token(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::oracle_address(&v0), arg2, 0, arg3, arg4);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::set_token_addr(&mut v0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::oracle_token_address(&v1));
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::transfer_oracle_token(v1, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::authority(&v0));
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::share_oracle(v0);
    }

    public entry fun run<T0>(arg0: vector<u8>, arg1: address, arg2: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        validate<T0>(arg0, arg1, v0, v1, arg4);
        actuate(arg0, arg1, v0, v1, arg4);
    }

    public fun validate<T0>(arg0: vector<u8>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

