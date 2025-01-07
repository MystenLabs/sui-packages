module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config {
    struct Config has drop, store {
        public_key: vector<u8>,
        three_char_price: u64,
        four_char_price: u64,
        five_plus_char_price: u64,
    }

    public fun assert_valid_user_registerable_domain(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain) {
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::number_of_levels(arg0) == 2, 5);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::sui_tld();
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::tld(arg0) == &v0, 6);
        let v1 = 0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(arg0));
        assert!(v1 >= (0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::min_domain_length() as u64), 0);
        assert!(v1 <= (0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::max_domain_length() as u64), 1);
    }

    public fun calculate_price(arg0: &Config, arg1: u8, arg2: u8) : u64 {
        assert!(arg2 > 0, 4);
        assert!(arg1 >= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::min_domain_length(), 0);
        assert!(arg1 <= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::max_domain_length(), 1);
        let v0 = if (arg1 == 3) {
            arg0.three_char_price
        } else if (arg1 == 4) {
            arg0.four_char_price
        } else {
            arg0.five_plus_char_price
        };
        (v0 as u64) * (arg2 as u64)
    }

    fun check_price(arg0: u64) {
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::mist_per_sui() <= arg0 && arg0 <= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::mist_per_sui() * 1000000, 2);
    }

    public fun five_plus_char_price(arg0: &Config) : u64 {
        arg0.five_plus_char_price
    }

    public fun four_char_price(arg0: &Config) : u64 {
        arg0.four_char_price
    }

    public fun new(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64) : Config {
        assert!(0x1::vector::length<u8>(&arg0) == 33, 3);
        Config{
            public_key           : arg0,
            three_char_price     : arg1,
            four_char_price      : arg2,
            five_plus_char_price : arg3,
        }
    }

    public fun public_key(arg0: &Config) : &vector<u8> {
        &arg0.public_key
    }

    public fun set_five_plus_char_price(arg0: &mut Config, arg1: u64) {
        check_price(arg1);
        arg0.five_plus_char_price = arg1;
    }

    public fun set_four_char_price(arg0: &mut Config, arg1: u64) {
        check_price(arg1);
        arg0.four_char_price = arg1;
    }

    public fun set_public_key(arg0: &mut Config, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 33, 3);
        arg0.public_key = arg1;
    }

    public fun set_three_char_price(arg0: &mut Config, arg1: u64) {
        check_price(arg1);
        arg0.three_char_price = arg1;
    }

    public fun three_char_price(arg0: &Config) : u64 {
        arg0.three_char_price
    }

    // decompiled from Move bytecode v6
}

