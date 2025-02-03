module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node_init_action {
    fun actuate(arg0: address, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::share_node(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::new(arg0, arg1, arg2, arg3));
    }

    public entry fun run<T0>(arg0: address, arg1: address, arg2: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::service_queue_address<T0>(arg2);
        validate<T0>(arg0, v0, arg3);
        actuate(arg0, arg1, v0, arg3);
    }

    public fun validate<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

