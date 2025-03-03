module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator_submit_result_action {
    struct AggregatorUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        oracle_id: 0x2::object::ID,
        value: 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::decimal::Decimal,
        timestamp_ms: u64,
    }

    fun actuate<T0>(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::Aggregator, arg1: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg2: 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::decimal::Decimal, arg3: u64, arg4: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>) {
        let v0 = arg3 * 1000;
        0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::add_result(arg0, arg2, v0, 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::id(arg4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::fee_recipient(arg1));
        let v1 = AggregatorUpdated{
            aggregator_id : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::id(arg0),
            oracle_id     : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::id(arg4),
            value         : arg2,
            timestamp_ms  : v0,
        };
        0x2::event::emit<AggregatorUpdated>(v1);
    }

    public entry fun run<T0>(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::Aggregator, arg1: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg2: u128, arg3: bool, arg4: u64, arg5: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T0>) {
        let v0 = 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::decimal::new(arg2, arg3);
        validate<T0>(arg0, arg1, arg5, arg4, &v0, arg6, arg7, &arg8);
        actuate<T0>(arg0, arg1, v0, arg4, arg5, arg7, arg8);
    }

    public fun validate<T0>(arg0: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::Aggregator, arg1: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::Queue, arg2: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::Oracle, arg3: u64, arg4: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::decimal::Decimal, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::coin::Coin<T0>) {
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::queue(arg2) == 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::queue(arg0), 9223372238718369795);
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::expiration_time_ms(arg2) > 0x2::clock::timestamp_ms(arg6), 9223372251603140609);
        assert!(arg3 * 1000 + 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::max_staleness_seconds(arg0) * 1000 >= 0x2::clock::timestamp_ms(arg6), 9223372264488304645);
        assert!(0x1::vector::length<u8>(&arg5) == 65, 9223372277373337607);
        let v0 = 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::hash::generate_update_msg(arg4, 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::queue_key(arg2), 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::feed_hash(arg0), x"0000000000000000000000000000000000000000000000000000000000000000", 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::max_variance(arg0), 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::min_responses(arg0), arg3);
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg5, &v0, 1);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle::secp256k1_key(arg2);
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::hash::check_subvec(&v2, &v3, 1), 9223372371862749193);
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::has_fee_type<T0>(arg1), 9223372384747782155);
        assert!(0x2::coin::value<T0>(arg7) >= 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::fee(arg1), 9223372389042880525);
    }

    // decompiled from Move bytecode v6
}

