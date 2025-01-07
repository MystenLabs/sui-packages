module 0x85769d63565ce99c7622f8e336ca1460926ddf29738ad2a39407b5cac29f61fe::incentive_pool_dynamic_keys {
    struct SimilarCoin has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    public fun similar_coin_key(arg0: 0x1::type_name::TypeName) : SimilarCoin {
        SimilarCoin{coin_type: arg0}
    }

    // decompiled from Move bytecode v6
}

