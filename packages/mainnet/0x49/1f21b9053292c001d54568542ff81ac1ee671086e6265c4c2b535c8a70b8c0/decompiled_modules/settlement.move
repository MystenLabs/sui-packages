module 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::settlement {
    public entry fun final_settlement<T0, T1>(arg0: &0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::Pool<T0, T1>) {
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::assert_version<T0, T1>(arg1);
        0x491f21b9053292c001d54568542ff81ac1ee671086e6265c4c2b535c8a70b8c0::oracle_driven_pool::final_settlement<T0, T1>(arg1);
    }

    // decompiled from Move bytecode v6
}

