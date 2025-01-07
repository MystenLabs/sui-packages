module 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::deposit {
    public entry fun deposit<T0, T1, T2>(arg0: &mut 0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::version::assert_current_version(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x19d4b7bcf29257b4a372d2f8ea151359da960a1ca6984dcb80dfd895343f6353::vault::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

