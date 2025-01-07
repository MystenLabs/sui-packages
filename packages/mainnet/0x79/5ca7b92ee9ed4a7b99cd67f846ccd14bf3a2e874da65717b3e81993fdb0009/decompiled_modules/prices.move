module 0x795ca7b92ee9ed4a7b99cd67f846ccd14bf3a2e874da65717b3e81993fdb0009::prices {
    public fun get_price<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>) : (u64, u64) {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0)
    }

    // decompiled from Move bytecode v6
}

