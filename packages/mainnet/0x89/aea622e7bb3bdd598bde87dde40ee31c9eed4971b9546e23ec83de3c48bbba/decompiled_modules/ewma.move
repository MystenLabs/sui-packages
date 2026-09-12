module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma {
    struct EwmaState has copy, drop, store {
        mean: u64,
        variance: u64,
        last_updated_timestamp_ms: u64,
    }

    public(friend) fun new(arg0: &0x2::tx_context::TxContext) : EwmaState {
        EwmaState{
            mean                      : scaled_gas_price(arg0),
            variance                  : 0,
            last_updated_timestamp_ms : 0,
        }
    }

    public(friend) fun penalty_fee(arg0: &EwmaState, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::EwmaConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) : u64 {
        if (!0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::enabled(arg1) || arg0.variance == 0) {
            return 0
        };
        let v0 = scaled_gas_price(arg3);
        if (v0 <= arg0.mean) {
            return 0
        };
        if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::div_down(v0 - arg0.mean, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_down(arg0.variance)) <= 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::z_score_threshold(arg1)) {
            return 0
        };
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::penalty_rate(arg1), arg2)
    }

    fun scaled_gas_price(arg0: &0x2::tx_context::TxContext) : u64 {
        0x2::tx_context::gas_price(arg0) * 1000000000
    }

    public(friend) fun update(arg0: &mut EwmaState, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::EwmaConfig, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 == arg0.last_updated_timestamp_ms) {
            return
        };
        arg0.last_updated_timestamp_ms = v0;
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::alpha(arg1);
        let v2 = 1000000000 - v1;
        let v3 = scaled_gas_price(arg3);
        let v4 = 0x1::u64::diff(v3, arg0.mean);
        let v5 = if (arg0.variance == 0) {
            0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v4, v4)
        } else {
            0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v2, arg0.variance) + 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v1, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v4, v4))
        };
        arg0.mean = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v1, v3) + 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v2, arg0.mean);
        arg0.variance = v5;
    }

    // decompiled from Move bytecode v7
}

