module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator_submit_result_action {
    struct AggregatorUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        oracle_id: 0x2::object::ID,
        value: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal,
        timestamp_ms: u64,
    }

    fun actuate<T0>(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg2: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal, arg3: u64, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>) {
        let v0 = arg3 * 1000;
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::add_result(arg0, arg2, v0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::id(arg4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::fee_recipient(arg1));
        let v1 = AggregatorUpdated{
            aggregator_id : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg0),
            oracle_id     : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::id(arg4),
            value         : arg2,
            timestamp_ms  : v0,
        };
        0x2::event::emit<AggregatorUpdated>(v1);
    }

    public entry fun run<T0>(arg0: &mut 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg2: u128, arg3: bool, arg4: u64, arg5: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T0>) {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::new(arg2, arg3);
        validate<T0>(arg0, arg1, arg5, arg4, &v0, arg6, arg7, &arg8);
        actuate<T0>(arg0, arg1, v0, arg4, arg5, arg7, arg8);
    }

    public fun validate<T0>(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::Queue, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::Oracle, arg3: u64, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::coin::Coin<T0>) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::version(arg1) == 1, 13906834406272729106);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::version(arg0) == 1, 13906834419157499920);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::queue(arg2) == 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::queue(arg0), 13906834432041615364);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::expiration_time_ms(arg2) > 0x2::clock::timestamp_ms(arg6), 13906834444926386178);
        assert!(arg3 * 1000 + 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_staleness_seconds(arg0) * 1000 >= 0x2::clock::timestamp_ms(arg6), 13906834457811550214);
        assert!(0x1::vector::length<u8>(&arg5) == 65, 13906834470696583176);
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::hash::generate_update_msg(arg4, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::queue_key(arg2), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::feed_hash(arg0), x"0000000000000000000000000000000000000000000000000000000000000000", 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_variance(arg0), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_responses(arg0), arg3);
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg5, &v0, 1);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::oracle::secp256k1_key(arg2);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::hash::check_subvec(&v2, &v3, 1), 13906834565185994762);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::has_fee_type<T0>(arg1), 13906834578071027724);
        assert!(0x2::coin::value<T0>(arg7) >= 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::queue::fee(arg1), 13906834582366126094);
    }

    // decompiled from Move bytecode v6
}

