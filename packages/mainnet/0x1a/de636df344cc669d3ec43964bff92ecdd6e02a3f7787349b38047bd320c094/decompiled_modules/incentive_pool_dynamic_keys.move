module 0x1ade636df344cc669d3ec43964bff92ecdd6e02a3f7787349b38047bd320c094::incentive_pool_dynamic_keys {
    struct SimilarCoin has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    public fun similar_coin_key(arg0: 0x1::type_name::TypeName) : SimilarCoin {
        SimilarCoin{coin_type: arg0}
    }

    // decompiled from Move bytecode v6
}

