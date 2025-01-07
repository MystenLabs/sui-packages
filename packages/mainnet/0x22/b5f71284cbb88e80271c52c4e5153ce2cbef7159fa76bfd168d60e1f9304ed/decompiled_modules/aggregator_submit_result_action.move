module 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator_submit_result_action {
    struct AggregatorUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        oracle_id: 0x2::object::ID,
        value: 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::decimal::Decimal,
        timestamp_ms: u64,
    }

    fun actuate<T0>(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::Aggregator, arg1: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg2: 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::decimal::Decimal, arg3: u64, arg4: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>) {
        let v0 = arg3 * 1000;
        0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::add_result(arg0, arg2, v0, 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::id(arg4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::fee_recipient(arg1));
        let v1 = AggregatorUpdated{
            aggregator_id : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::id(arg0),
            oracle_id     : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::id(arg4),
            value         : arg2,
            timestamp_ms  : v0,
        };
        0x2::event::emit<AggregatorUpdated>(v1);
    }

    public entry fun run<T0>(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::Aggregator, arg1: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg2: u128, arg3: bool, arg4: u64, arg5: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::Oracle, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T0>) {
        let v0 = 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::decimal::new(arg2, arg3);
        validate<T0>(arg0, arg1, arg5, arg4, &v0, arg6, arg7, &arg8);
        actuate<T0>(arg0, arg1, v0, arg4, arg5, arg7, arg8);
    }

    public fun validate<T0>(arg0: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::Aggregator, arg1: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::Queue, arg2: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::Oracle, arg3: u64, arg4: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::decimal::Decimal, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::coin::Coin<T0>) {
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::version(arg1) == 1, 9223372268784123922);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::version(arg0) == 1, 9223372281668894736);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::queue(arg2) == 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::queue(arg0), 9223372294553010180);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::expiration_time_ms(arg2) > 0x2::clock::timestamp_ms(arg6), 9223372307437780994);
        assert!(arg3 * 1000 + 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::max_staleness_seconds(arg0) * 1000 >= 0x2::clock::timestamp_ms(arg6), 9223372320322945030);
        assert!(0x1::vector::length<u8>(&arg5) == 65, 9223372333207977992);
        let v0 = 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::hash::generate_update_msg(arg4, 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::queue_key(arg2), 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::feed_hash(arg0), x"0000000000000000000000000000000000000000000000000000000000000000", 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::max_variance(arg0), 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::min_responses(arg0), arg3);
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg5, &v0, 1);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::oracle::secp256k1_key(arg2);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::hash::check_subvec(&v2, &v3, 1), 9223372427697389578);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::has_fee_type<T0>(arg1), 9223372440582422540);
        assert!(0x2::coin::value<T0>(arg7) >= 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue::fee(arg1), 9223372444877520910);
    }

    // decompiled from Move bytecode v6
}

