module 0xd88ebdabeaead893d6ce24259bf596627ff4d209b9e1541c2eb7997fa90651d2::suiswap {
    public fun swap_x_to_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::utils::transfer_or_destroy_zero<T0>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::utils::transfer_or_destroy_zero<T1>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    // decompiled from Move bytecode v6
}

