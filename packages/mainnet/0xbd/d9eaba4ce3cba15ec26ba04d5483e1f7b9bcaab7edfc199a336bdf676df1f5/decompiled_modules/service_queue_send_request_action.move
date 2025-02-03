module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue_send_request_action {
    fun actuate<T0>() {
    }

    public entry fun run<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        validate<T0>();
        actuate<T0>();
    }

    public fun validate<T0>() {
    }

    // decompiled from Move bytecode v6
}

