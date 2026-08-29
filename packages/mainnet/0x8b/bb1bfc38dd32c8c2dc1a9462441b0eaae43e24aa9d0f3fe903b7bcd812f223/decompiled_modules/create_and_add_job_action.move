module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::create_and_add_job_action {
    public entry fun run(arg0: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg3, arg5);
        actuate(arg0, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4) / 1000, arg5);
    }

    fun actuate(arg0: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg1, arg2, arg4, arg5);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(arg0, &v0, arg3, arg5);
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v0);
    }

    public fun validate(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::has_authority(arg0, arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidAuthority());
        assert!(!0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::is_locked(arg0), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::AggregatorLocked());
        assert!(arg1 > 0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
    }

    // decompiled from Move bytecode v6
}

