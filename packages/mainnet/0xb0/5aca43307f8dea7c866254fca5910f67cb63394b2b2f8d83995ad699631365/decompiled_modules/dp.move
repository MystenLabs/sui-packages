module 0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::dp {
    public fun dp_swap_ab<T0, T1>(arg0: &0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1, v2) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg1, 8235, arg2, arg4, 0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::help::merge_all<T0>(arg3, arg6), 0x2::coin::zero<T1>(arg6), arg5, arg6);
        0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::help::transfer<T0>(v0, 0x2::tx_context::sender(arg6));
        (v1, v2)
    }

    public fun dp_swap_ab1<T0, T1>(arg0: &0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = dp_swap_ab<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun dp_swap_ba<T0, T1>(arg0: &0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1, v2) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg1, 8235, arg2, arg4, arg5, 0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::help::merge_all<T1>(arg3, arg6), arg6);
        0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::help::transfer<T1>(v1, 0x2::tx_context::sender(arg6));
        (v0, v2)
    }

    public fun dp_swap_ba1<T0, T1>(arg0: &0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = dp_swap_ba<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    public entry fun mint_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(0xdee9::clob_v2::create_account(arg1), arg0);
    }

    // decompiled from Move bytecode v6
}

