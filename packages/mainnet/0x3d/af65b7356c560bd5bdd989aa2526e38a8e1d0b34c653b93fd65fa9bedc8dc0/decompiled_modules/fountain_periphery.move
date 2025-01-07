module 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_periphery {
    public entry fun airdrop<T0, T1, T2>(arg0: &mut 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::airdrop<T0, T1, T2>(arg0, 0x2::coin::into_balance<T2>(arg1));
    }

    public entry fun claim<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>, arg2: &mut 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::StakeProof<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::claim<T0, T1, T2>(arg0, arg1, arg2);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    public entry fun stake<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>, arg2: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::StakeProof<T0, T1, T2>>(0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::stake<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun supply<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>, arg2: 0x2::coin::Coin<T2>) {
        0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::supply<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(arg2));
    }

    public entry fun tune<T0, T1, T2>(arg0: &mut 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>) {
        0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::tune<T0, T1, T2>(arg0, 0x2::coin::into_balance<T2>(arg1));
    }

    public entry fun unstake<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>, arg2: 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::StakeProof<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::unstake<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>>(v0, v3);
        if (0x2::balance::value<T2>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v2, arg3), v3);
        } else {
            0x2::balance::destroy_zero<T2>(v2);
        };
    }

    public entry fun create_fountain<T0, T1, T2>(arg0: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            let (v0, v1) = 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::new_fountain_with_admin_cap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
            0x2::transfer::public_share_object<0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>>(v0);
            0x2::transfer::public_transfer<0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::AdminCap>(v1, 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_share_object<0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>>(0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::new_fountain<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7));
        };
    }

    public entry fun setup_fountain<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T2>, arg2: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg8) {
            let (v0, v1) = 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::new_fountain_with_admin_cap<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg9);
            let v2 = v0;
            0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::supply<T0, T1, T2>(arg0, &mut v2, 0x2::coin::into_balance<T2>(arg1));
            0x2::transfer::public_share_object<0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>>(v2);
            0x2::transfer::public_transfer<0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::AdminCap>(v1, 0x2::tx_context::sender(arg9));
        } else {
            let v3 = 0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::new_fountain<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg9);
            0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::supply<T0, T1, T2>(arg0, &mut v3, 0x2::coin::into_balance<T2>(arg1));
            0x2::transfer::public_share_object<0x3daf65b7356c560bd5bdd989aa2526e38a8e1d0b34c653b93fd65fa9bedc8dc0::fountain_core::Fountain<T0, T1, T2>>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

