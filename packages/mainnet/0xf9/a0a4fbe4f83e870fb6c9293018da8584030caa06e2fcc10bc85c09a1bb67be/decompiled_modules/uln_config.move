module 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config {
    struct UlnConfig has copy, drop, store {
        confirmations: u64,
        required_dvns: vector<address>,
        optional_dvns: vector<address>,
        optional_dvn_threshold: u8,
    }

    public fun new() : UlnConfig {
        UlnConfig{
            confirmations          : 0,
            required_dvns          : 0x1::vector::empty<address>(),
            optional_dvns          : 0x1::vector::empty<address>(),
            optional_dvn_threshold : 0,
        }
    }

    public fun assert_at_least_one_dvn(arg0: &UlnConfig) {
        assert!(0x1::vector::length<address>(required_dvns(arg0)) > 0 || optional_dvn_threshold(arg0) > 0, 1);
    }

    public fun assert_default_config(arg0: &UlnConfig) {
        assert_required_dvns(arg0);
        assert_optional_dvns(arg0);
        assert_at_least_one_dvn(arg0);
    }

    public fun assert_optional_dvns(arg0: &UlnConfig) {
        let v0 = (optional_dvn_threshold(arg0) as u64);
        let v1 = 0x1::vector::length<address>(optional_dvns(arg0));
        assert!(!has_duplicates(optional_dvns(arg0)), 2);
        assert!(v1 <= (127 as u64), 4);
        assert!(v0 == 0 && v1 == 0 || v0 > 0 && v0 <= v1, 5);
    }

    public fun assert_required_dvns(arg0: &UlnConfig) {
        assert!(!has_duplicates(required_dvns(arg0)), 3);
        assert!(0x1::vector::length<address>(required_dvns(arg0)) <= (127 as u64), 6);
    }

    public fun confirmations(arg0: &UlnConfig) : u64 {
        arg0.confirmations
    }

    public fun create(arg0: u64, arg1: vector<address>, arg2: vector<address>, arg3: u8) : UlnConfig {
        UlnConfig{
            confirmations          : arg0,
            required_dvns          : arg1,
            optional_dvns          : arg2,
            optional_dvn_threshold : arg3,
        }
    }

    public fun deserialize(arg0: vector<u8>) : UlnConfig {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 7);
        create(0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_vec_address(&mut v0), 0x2::bcs::peel_vec_address(&mut v0), 0x2::bcs::peel_u8(&mut v0))
    }

    fun has_duplicates(arg0: &vector<address>) : bool {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            let v2 = *0x1::vector::borrow<address>(arg0, v1);
            if (0x1::vector::contains<address>(&v0, &v2)) {
                return true
            };
            0x1::vector::push_back<address>(&mut v0, v2);
            v1 = v1 + 1;
        };
        false
    }

    public fun optional_dvn_threshold(arg0: &UlnConfig) : u8 {
        arg0.optional_dvn_threshold
    }

    public fun optional_dvns(arg0: &UlnConfig) : &vector<address> {
        &arg0.optional_dvns
    }

    public fun required_dvns(arg0: &UlnConfig) : &vector<address> {
        &arg0.required_dvns
    }

    // decompiled from Move bytecode v6
}

