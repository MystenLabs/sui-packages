module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node_heartbeat_action {
    public entry fun run<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::Node, arg1: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg2: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_and_actuate<T0>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3) / 1000, arg4);
    }

    fun validate_and_actuate<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::Node, arg1: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg2: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::has_authority(arg0, arg4), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::queue_addr(arg0) == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::service_queue_address<T0>(arg1), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidQuoteError());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::node_address(arg0) == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::node_addr(arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidQuoteError());
        let v0 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::authority<T0>(arg1);
        assert!(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::is_valid(arg2, arg3), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidQuoteError());
        if (0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::require_authority_heartbeat_permission<T0>(arg1)) {
            let v1 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::service_queue_address<T0>(arg1);
            let v2 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::authority(arg0);
            assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::has(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::permission<T0>(arg1, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::key(&v0, &v1, &v2)), 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::PERMIT_NODE_HEARTBEAT()), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        };
        let (v3, v4) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::verify_quote_data(arg2);
        if (!v3) {
            assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::has_mr_enclave<T0>(arg1, v4), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        };
        assert!(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::queue_addr(arg2) == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::verifier_queue_addr<T0>(arg1), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidQuoteError());
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::push_back<T0>(arg1, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::node_address(arg0), arg3);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::set_last_heartbeat(arg0, arg3);
        let (v5, v6) = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::next_garbage_collection_node<T0>(arg1);
        if (v5 == @0x0) {
            return
        };
        if (0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::is_expired<T0>(arg1, v5, arg3)) {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::garbage_collect<T0>(arg1, v6);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_node_booted_event(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::service_queue_address<T0>(arg1), v5);
        };
    }

    // decompiled from Move bytecode v6
}

