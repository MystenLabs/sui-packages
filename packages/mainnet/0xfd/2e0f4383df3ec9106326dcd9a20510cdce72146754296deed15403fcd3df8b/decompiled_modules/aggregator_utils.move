module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils {
    struct FriendKey has drop {
        dummy_field: bool,
    }

    struct AggregatorToken has key {
        id: 0x2::object::UID,
        aggregator_addr: address,
        queue_addr: address,
        batch_size: u64,
        min_oracle_results: u64,
        min_update_delay_seconds: u64,
        created_at: u64,
        read_charge: u64,
        reward_escrow: address,
        read_whitelist: 0x2::bag::Bag,
        limit_reads_to_whitelist: bool,
    }

    struct Result has key {
        id: 0x2::object::UID,
        aggregator_addr: address,
        update_data: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::SlidingWindow,
        timestamp: u64,
        parent: address,
    }

    struct Authority has store, key {
        id: 0x2::object::UID,
        aggregator_address: address,
    }

    public fun admin_friend_key(arg0: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::switchboard::AdminCap) : FriendKey {
        FriendKey{dummy_field: false}
    }

    public fun aggregator_token_address(arg0: &AggregatorToken) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun aggregator_token_data(arg0: &AggregatorToken) : (address, address, u64, u64, u64, u64) {
        (arg0.aggregator_addr, arg0.queue_addr, arg0.batch_size, arg0.min_oracle_results, arg0.min_update_delay_seconds, arg0.created_at)
    }

    public fun authority_is_for_aggregator(arg0: &Authority, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : bool {
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg1) == arg0.aggregator_address
    }

    public(friend) fun extend_result(arg0: &Result, arg1: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (bool, Result) {
        let v0 = Result{
            id              : 0x2::object::new(arg6),
            aggregator_addr : arg0.aggregator_addr,
            update_data     : arg0.update_data,
            timestamp       : arg0.timestamp,
            parent          : result_address(arg0),
        };
        let (v1, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::add_to_sliding_window(&mut v0.update_data, arg2, arg1, arg3, arg4, arg5);
        (v1, v0)
    }

    public fun freeze_aggregator_token(arg0: AggregatorToken) {
        0x2::transfer::freeze_object<AggregatorToken>(arg0);
    }

    public fun freeze_result(arg0: Result) {
        0x2::transfer::freeze_object<Result>(arg0);
    }

    public(friend) fun friend_key() : FriendKey {
        FriendKey{dummy_field: false}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun new_aggregator_token(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: vector<address>, arg8: bool, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : AggregatorToken {
        let v0 = 0x2::bag::new(arg10);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg7)) {
            0x2::bag::add<address, bool>(&mut v0, *0x1::vector::borrow<address>(&arg7, v1), true);
            v1 = v1 + 1;
        };
        AggregatorToken{
            id                       : 0x2::object::new(arg10),
            aggregator_addr          : arg0,
            queue_addr               : arg1,
            batch_size               : arg2,
            min_oracle_results       : arg3,
            min_update_delay_seconds : arg4,
            created_at               : arg9,
            read_charge              : arg5,
            reward_escrow            : arg6,
            read_whitelist           : v0,
            limit_reads_to_whitelist : arg8,
        }
    }

    public(friend) fun new_authority(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) : Authority {
        Authority{
            id                 : 0x2::object::new(arg1),
            aggregator_address : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg0),
        }
    }

    public(friend) fun new_result(arg0: &AggregatorToken, arg1: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg2: address, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : Result {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::new_sliding_window();
        if (arg4) {
            let (_, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::add_to_sliding_window(&mut v0, arg2, arg1, arg0.batch_size, arg0.min_oracle_results, arg3);
        };
        Result{
            id              : 0x2::object::new(arg5),
            aggregator_addr : arg0.aggregator_addr,
            update_data     : v0,
            timestamp       : arg3,
            parent          : @0x0,
        }
    }

    public(friend) fun result(arg0: &Result) : (0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, u64) {
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::sliding_window_latest_result(&arg0.update_data)
    }

    public fun result_address(arg0: &Result) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun result_data(arg0: &Result, arg1: &AggregatorToken, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::tx_context::TxContext) : (0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, u64) {
        assert!(arg1.read_charge == 0 && arg1.limit_reads_to_whitelist == false || 0x2::bag::contains<address>(&arg1.read_whitelist, 0x2::tx_context::sender(arg4)), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        assert!(arg0.aggregator_addr == arg1.aggregator_addr, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        assert!(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::results_older_than(&arg0.update_data, arg2, arg3) == false, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        result(arg0)
    }

    public(friend) fun transfer_authority(arg0: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg1: Authority, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Authority>(arg1, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::authority(arg0));
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::set_authority(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

