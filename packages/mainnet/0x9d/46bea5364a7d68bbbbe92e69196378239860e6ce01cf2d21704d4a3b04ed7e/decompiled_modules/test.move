module 0x9d46bea5364a7d68bbbbe92e69196378239860e6ce01cf2d21704d4a3b04ed7e::test {
    struct AggKey has drop {
        dummy_field: bool,
    }

    public fun get_key() : AggKey {
        AggKey{dummy_field: false}
    }

    public fun price() : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal {
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero()
    }

    // decompiled from Move bytecode v7
}

