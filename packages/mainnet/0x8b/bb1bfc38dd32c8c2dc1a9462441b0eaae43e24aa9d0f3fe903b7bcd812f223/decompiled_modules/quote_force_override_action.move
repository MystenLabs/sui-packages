module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_force_override_action {
    public entry fun run<T0>(arg0: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg1: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::Node, arg2: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::authority<T0>(arg2) == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::owner(arg1), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::has_authority<T0>(arg2, arg4), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::service_queue_address<T0>(arg2) == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::queue_addr(arg1), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidConstraint());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::authority(arg1) == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::node_authority(arg0), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidConstraint());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::node_address(arg1) == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::node_addr(arg0), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidConstraint());
        assert!(v0 - 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::last_heartbeat<T0>(arg2) > 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::allow_authority_override_after<T0>(arg2) && 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::allow_authority_override_after<T0>(arg2) != 0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        let v1 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_utils::friend_key();
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::force_override<0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_utils::FriendKey>(arg0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::max_quote_verification_age<T0>(arg2) + v0, v0, &v1);
    }

    // decompiled from Move bytecode v6
}

