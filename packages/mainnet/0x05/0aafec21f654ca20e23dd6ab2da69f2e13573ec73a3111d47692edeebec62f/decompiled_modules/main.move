module 0x50aafec21f654ca20e23dd6ab2da69f2e13573ec73a3111d47692edeebec62f::main {
    public entry fun withdraw_royalty_entry<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<T0>(arg0, arg1, 0x1::option::some<u64>(arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

