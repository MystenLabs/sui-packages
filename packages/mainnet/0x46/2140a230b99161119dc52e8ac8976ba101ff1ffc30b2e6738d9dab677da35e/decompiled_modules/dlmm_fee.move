module 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_fee {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((arg0 as u256) * (arg1 as u256) * ((arg1 as u256) + (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::precision() as u256)) / (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::squared_precision() as u256))
    }

    public fun get_fee_amount(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        let v0 = (((0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::precision() as u64) - arg1) as u256);
        0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0)
    }

    public fun get_fee_amount_from(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64(((arg0 as u256) * (arg1 as u256) + (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::precision() as u256) - 1) / (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::precision() as u256))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u16) : u64 {
        verify_protocol_share(arg1);
        0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe64((arg0 as u256) * (arg1 as u256) / (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u256))
    }

    public fun verify_fee(arg0: u64) {
        assert!(arg0 <= 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::max_fee(), 9223372088394383361);
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::max_protocol_share(), 9223372105574383619);
    }

    // decompiled from Move bytecode v6
}

