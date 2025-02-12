module 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        public_key: vector<u8>,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{public_key: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun prove<T0, T1>(arg0: &0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::TradeInfo<T1>, arg1: vector<u8>, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::transfer_policy::has_rule<T0, Rule>(arg2), 9223372285962878977);
        assert!(0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::item_id<T1>(arg0) == 0x2::transfer_policy::item<T0>(arg3), 9223372290258108421);
        let v0 = 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::seller<T1>(arg0);
        let v1 = 0x1::bcs::to_bytes<address>(&v0);
        let v2 = 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::buyer<T1>(arg0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&v2));
        let v3 = 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::item_id<T1>(arg0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::coin_type<T1>(arg0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<0x1::string::String>(&v4));
        let v5 = 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::price<T1>(arg0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v5));
        let v6 = 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::marketplace::salt<T1>(arg0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v6));
        let v7 = Rule{dummy_field: false};
        let v8 = 0x2::hash::blake2b256(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &0x2::transfer_policy::get_rule<T0, Rule, Config>(v7, arg2).public_key, &v8) == true, 9223372337502617603);
        let v9 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v9, arg3);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

