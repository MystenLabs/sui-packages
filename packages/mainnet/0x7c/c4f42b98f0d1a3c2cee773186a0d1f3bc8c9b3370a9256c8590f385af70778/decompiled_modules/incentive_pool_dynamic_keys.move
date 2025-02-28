module 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool_dynamic_keys {
    struct SimilarCoin has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    public fun similar_coin_key(arg0: 0x1::type_name::TypeName) : SimilarCoin {
        SimilarCoin{coin_type: arg0}
    }

    // decompiled from Move bytecode v6
}

