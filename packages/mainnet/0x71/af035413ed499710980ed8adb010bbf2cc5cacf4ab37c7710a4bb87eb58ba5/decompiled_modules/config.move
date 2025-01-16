module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config {
    struct Config has drop, store {
        public_key: vector<u8>,
        three_char_price: u64,
        four_char_price: u64,
        five_plus_char_price: u64,
    }

    public fun assert_valid_user_registerable_domain(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain) {
        abort 1337
    }

    public fun calculate_price(arg0: &Config, arg1: u8, arg2: u8) : u64 {
        abort 1337
    }

    public fun five_plus_char_price(arg0: &Config) : u64 {
        abort 1337
    }

    public fun four_char_price(arg0: &Config) : u64 {
        abort 1337
    }

    public fun new(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64) : Config {
        abort 1337
    }

    public fun public_key(arg0: &Config) : &vector<u8> {
        abort 1337
    }

    public fun set_five_plus_char_price(arg0: &mut Config, arg1: u64) {
        abort 1337
    }

    public fun set_four_char_price(arg0: &mut Config, arg1: u64) {
        abort 1337
    }

    public fun set_public_key(arg0: &mut Config, arg1: vector<u8>) {
        abort 1337
    }

    public fun set_three_char_price(arg0: &mut Config, arg1: u64) {
        abort 1337
    }

    public fun three_char_price(arg0: &Config) : u64 {
        abort 1337
    }

    // decompiled from Move bytecode v6
}

