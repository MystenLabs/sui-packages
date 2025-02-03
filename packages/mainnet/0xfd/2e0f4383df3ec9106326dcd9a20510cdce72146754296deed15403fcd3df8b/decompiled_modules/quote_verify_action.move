module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_verify_action {
    fun actuate<T0>(arg0: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::Node, arg2: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_utils::friend_key();
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::verify<0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_utils::FriendKey>(arg0, arg3 + 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::max_quote_verification_age<T0>(arg2), arg3, &v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::escrow_withdraw<T0>(arg2, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::quote_address(arg0), 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::reward<T0>(arg2), arg4), 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::owner(arg1));
    }

    public entry fun run<T0>(arg0: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg1: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg2: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::Node, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (validate<T0>(arg0, arg1, arg2, arg3, arg5, arg6, arg4, arg7)) {
            actuate<T0>(arg0, arg2, arg1, arg5, arg7);
        } else {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::quote_fail_action::actuate<T0>(arg0, arg2, arg1, arg7);
        };
    }

    public fun validate<T0>(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::ServiceQueue<T0>, arg2: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::Node, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::Quote, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::verification_status(arg0);
        assert!(v0 == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::VERIFICATION_PENDING() || v0 == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::VERIFICATION_OVERRIDE(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        assert!(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::node_authority(arg0) != 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::node_authority(arg3), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::has_authority(arg2, arg7), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::valid_until(arg3) > arg4, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidTimestamp());
        let v1 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::verification_status(arg3);
        assert!(v1 == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::VERIFICATION_SUCCESS() || v1 == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::VERIFICATION_OVERRIDE(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        let v2 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v3 = if (arg4 > v2) {
            arg4 - v2
        } else {
            v2 - arg4
        };
        assert!(v3 > 600, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidTimestamp());
        let (v4, v5) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::verify_quote_data(arg3);
        if (!v4) {
            assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::has_mr_enclave<T0>(arg1, v5), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        };
        let (_, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::verify_quote_data(arg0);
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::node_at_idx<T0>(arg1, arg6) == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::node::node_address(arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        if (0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::require_usage_permissions<T0>(arg1)) {
            let v9 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::authority<T0>(arg1);
            let v10 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::service_queue_address<T0>(arg1);
            let v11 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote::node_authority(arg0);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::has(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::service_queue::permission<T0>(arg1, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::key(&v9, &v10, &v11)), 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::PERMIT_SERVICE_QUEUE_USAGE())
        } else {
            true
        }
    }

    // decompiled from Move bytecode v6
}

