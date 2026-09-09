module 0x96e30a2d44ad0f4a8f4fd896bbaa88044ad9bfbf1ed88d160904f45924d040bd::reader {
    public fun current<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: bool) : (u128, u128, u64, u64) {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(v0);
        let (v3, v4) = if (arg1) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        ((v3 as u128), (v4 as u128), 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(v0), 10000)
    }

    // decompiled from Move bytecode v7
}

