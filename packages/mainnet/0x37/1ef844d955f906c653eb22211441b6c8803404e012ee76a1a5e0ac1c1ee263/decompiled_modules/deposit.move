module 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::deposit {
    public entry fun deposit<T0, T1, T2>(arg0: &mut 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

