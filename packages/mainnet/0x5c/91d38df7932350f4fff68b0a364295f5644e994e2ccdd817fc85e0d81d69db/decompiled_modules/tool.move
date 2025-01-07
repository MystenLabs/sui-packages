module 0x5c91d38df7932350f4fff68b0a364295f5644e994e2ccdd817fc85e0d81d69db::tool {
    public entry fun delete_old_swap_policy<T0: store + key>(arg0: 0x2::transfer_policy::TransferPolicy<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::destroy_and_withdraw<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

