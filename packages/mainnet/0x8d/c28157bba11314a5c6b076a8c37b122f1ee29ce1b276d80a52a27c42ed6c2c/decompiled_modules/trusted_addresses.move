module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::trusted_addresses {
    struct TrustedAddresses has copy, drop {
        trusted_chains: vector<0x1::ascii::String>,
        trusted_addresses: vector<0x1::ascii::String>,
    }

    public(friend) fun destroy(arg0: TrustedAddresses) : (vector<0x1::ascii::String>, vector<0x1::ascii::String>) {
        let TrustedAddresses {
            trusted_chains    : v0,
            trusted_addresses : v1,
        } = arg0;
        (v0, v1)
    }

    public fun new(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : TrustedAddresses {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg0) == 0x1::vector::length<0x1::ascii::String>(&arg1), 9223372161408827393);
        TrustedAddresses{
            trusted_chains    : arg0,
            trusted_addresses : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

