module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config {
    struct Range has copy, drop, store {
        pos0: u64,
        pos1: u64,
    }

    struct PricingConfig has drop, store {
        pricing: 0x2::vec_map::VecMap<Range, u64>,
    }

    struct RenewalConfig has drop, store {
        config: PricingConfig,
    }

    public fun calculate_base_price(arg0: &PricingConfig, arg1: u64) : u64 {
        let v0 = 0x2::vec_map::keys<Range, u64>(&arg0.pricing);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<Range>(v1)) {
            if (is_between_inclusive(0x1::vector::borrow<Range>(v1, v2), arg1)) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v3), 4);
                let v4 = *0x1::vector::borrow<Range>(&v0, 0x1::option::extract<u64>(&mut v3));
                return *0x2::vec_map::get<Range, u64>(&arg0.pricing, &v4)
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun config(arg0: &RenewalConfig) : &PricingConfig {
        &arg0.config
    }

    public fun is_between_inclusive(arg0: &Range, arg1: u64) : bool {
        arg1 >= arg0.pos0 && arg1 <= arg0.pos1
    }

    public fun new(arg0: vector<Range>, arg1: vector<u64>) : PricingConfig {
        assert!(0x1::vector::length<Range>(&arg0) == 0x1::vector::length<u64>(&arg1), 3);
        let v0 = 1;
        while (v0 < 0x1::vector::length<Range>(&arg0)) {
            assert!(0x1::vector::borrow<Range>(&arg0, v0 - 1).pos1 < 0x1::vector::borrow<Range>(&arg0, v0).pos0, 2);
            v0 = v0 + 1;
        };
        PricingConfig{pricing: 0x2::vec_map::from_keys_values<Range, u64>(arg0, arg1)}
    }

    public fun new_range(arg0: vector<u64>) : Range {
        assert!(0x1::vector::length<u64>(&arg0) == 2, 1);
        assert!(*0x1::vector::borrow<u64>(&arg0, 0) <= *0x1::vector::borrow<u64>(&arg0, 1), 2);
        Range{
            pos0 : *0x1::vector::borrow<u64>(&arg0, 0),
            pos1 : *0x1::vector::borrow<u64>(&arg0, 1),
        }
    }

    public fun new_renewal_config(arg0: PricingConfig) : RenewalConfig {
        RenewalConfig{config: arg0}
    }

    public fun pricing(arg0: &PricingConfig) : &0x2::vec_map::VecMap<Range, u64> {
        &arg0.pricing
    }

    // decompiled from Move bytecode v6
}

