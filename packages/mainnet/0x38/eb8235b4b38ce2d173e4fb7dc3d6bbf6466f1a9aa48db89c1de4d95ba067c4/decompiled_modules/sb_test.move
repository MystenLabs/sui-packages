module 0x38eb8235b4b38ce2d173e4fb7dc3d6bbf6466f1a9aa48db89c1de4d95ba067c4::sb_test {
    public entry fun get_switchboard_price(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : (u128, u8, u64) {
        let (v0, v1) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg0);
        let (v2, v3, v4) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(v0);
        assert!(v4 == false, 12345);
        (v2, v3, v1)
    }

    // decompiled from Move bytecode v6
}

