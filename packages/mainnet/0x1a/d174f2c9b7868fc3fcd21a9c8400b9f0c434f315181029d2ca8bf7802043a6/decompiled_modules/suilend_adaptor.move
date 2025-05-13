module 0x1ad174f2c9b7868fc3fcd21a9c8400b9f0c434f315181029d2ca8bf7802043a6::suilend_adaptor {
    public(friend) fun parse_suilend_obligation<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>) : u256 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(arg0)) - 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<T0>(arg0))
    }

    // decompiled from Move bytecode v6
}

