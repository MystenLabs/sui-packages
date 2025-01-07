module 0x48b4a219a13cbc2e629d13f53d4ec373f90cf96c1166a65173ef3f302ac61bd0::redeemFee {
    public fun redeem_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

