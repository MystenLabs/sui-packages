module 0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::user_entry {
    public entry fun deposit<T0>(arg0: &0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::active_vault::Config, arg1: &mut 0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::active_vault::ActiveVault<T0>, arg2: &mut 0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::secure_vault::SecureVault<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::active_vault::deposit<T0>(arg1, 0x2::coin::into_balance<T0>(arg3), arg5);
    }

    public entry fun withdraw<T0>(arg0: &0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::active_vault::OwnerCap, arg1: &mut 0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::active_vault::ActiveVault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x4a61b80142fdb9c6c51aa1d4cae2f72414e059190dcf7dece29bdbeefe6b9f5e::active_vault::withdraw<T0>(arg1, 0, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

