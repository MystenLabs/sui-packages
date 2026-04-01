module 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::revenue {
    struct Distribution has copy, drop, store {
        addresses: vector<address>,
        shares_bps: vector<u64>,
    }

    public fun addresses(arg0: &Distribution) : &vector<address> {
        &arg0.addresses
    }

    public fun default_distribution(arg0: address) : Distribution {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        Distribution{
            addresses  : v0,
            shares_bps : vector[10000],
        }
    }

    public fun new_distribution(arg0: vector<address>, arg1: vector<u64>) : Distribution {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0, 200);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 200);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg1, v2) > 0, 200);
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 201);
        Distribution{
            addresses  : arg0,
            shares_bps : arg1,
        }
    }

    public fun shares(arg0: &Distribution) : &vector<u64> {
        &arg0.shares_bps
    }

    // decompiled from Move bytecode v6
}

