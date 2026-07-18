module 0xe22ed94b5aec53a2795ba615c0b512e6551a915dc26ccc3b6cbdae3c08d6d787::incentive_pool_dynamic_keys {
    struct SimilarCoin has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    public fun similar_coin_key(arg0: 0x1::type_name::TypeName) : SimilarCoin {
        SimilarCoin{coin_type: arg0}
    }

    // decompiled from Move bytecode v7
}

