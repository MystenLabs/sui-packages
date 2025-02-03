module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::create_oracle_action {
    public entry fun run<T0>(arg0: vector<u8>, arg1: address, arg2: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg2);
        let v2 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::new(arg0, arg1, v1, v0, arg6);
        let v3 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::authority<T0>(arg2);
        let v4 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::new(v3, v1, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::oracle_address(&v2), v0, arg6);
        if (v3 == 0x2::tx_context::sender(arg6)) {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::set(&mut v4, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::PERMIT_ORACLE_HEARTBEAT(), v0);
        };
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::permission_create<T0>(arg2, v4);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::escrow_deposit<T0>(&mut v2, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg2), 0x2::coin::split<T0>(arg3, arg4, arg6));
        let v5 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::new_oracle_token(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::oracle_address(&v2), v1, 0, v0, arg6);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::set_token_addr(&mut v2, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::oracle_token_address(&v5));
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::transfer_oracle_token(v5, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::authority(&v2));
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::share_oracle(v2);
    }

    // decompiled from Move bytecode v6
}

