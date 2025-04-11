module 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_pool_dynamic_keys {
    struct SimilarCoin has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    public fun similar_coin_key(arg0: 0x1::type_name::TypeName) : SimilarCoin {
        SimilarCoin{coin_type: arg0}
    }

    // decompiled from Move bytecode v6
}

