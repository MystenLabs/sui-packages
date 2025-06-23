module 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::suilend_adaptor {
    public(friend) fun parse_suilend_obligation<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>) : u256 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(arg0)) - 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<T0>(arg0))
    }

    public fun update_suilend_position_value<T0, T1>(arg0: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg1: &0x2::clock::Clock, arg2: 0x1::ascii::String) {
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::finish_update_asset_value<T0>(arg0, arg2, parse_suilend_obligation<T1>(0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::get_defi_asset<T0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T1>>(arg0, arg2)), 0x2::clock::timestamp_ms(arg1));
    }

    // decompiled from Move bytecode v6
}

