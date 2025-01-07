module 0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::flow {
    public fun swap<T0, T1>(arg0: &0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::Permits, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::valid(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::help::merge_all<T0>(arg2, arg4);
        let v1 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, 0x2::coin::split<T0>(&mut v0, arg3, arg4), arg4);
        0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::help::transfer<T0>(v0, 0x2::tx_context::sender(arg4));
        (v1, 0x2::coin::value<T1>(&v1))
    }

    public fun swap1<T0, T1>(arg0: &0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::Permits, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = swap<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

