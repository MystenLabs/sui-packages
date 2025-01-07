module 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_periphery {
    public entry fun airdrop<T0, T1>(arg0: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::airdrop<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg2: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::claim<T0, T1>(arg0, arg1, arg2);
        if (0x2::balance::value<T1>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T1>(v0);
        };
    }

    public entry fun claim_penalty<T0, T1>(arg0: &0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::AdminCap, arg1: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::claim_penalty<T0, T1>(arg0, arg1), arg3), arg2);
    }

    public entry fun force_unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg2: 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::force_unstake<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), v3);
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), v3);
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
    }

    public entry fun stake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<T0, T1>>(0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::stake<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun supply<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::supply<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2));
    }

    public entry fun tune<T0, T1>(arg0: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::tune<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg2: 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::unstake<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), v3);
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), v3);
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
    }

    public entry fun create_fountain<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let (v0, v1) = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::new_fountain_with_admin_cap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
            0x2::transfer::public_share_object<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>>(v0);
            0x2::transfer::public_transfer<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::AdminCap>(v1, 0x2::tx_context::sender(arg6));
        } else {
            0x2::transfer::public_share_object<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>>(0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::new_fountain<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6));
        };
    }

    public entry fun create_penalty_vault<T0, T1>(arg0: &0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::AdminCap, arg1: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>, arg2: u64) {
        0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::new_penalty_vault<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun setup_fountain<T0, T1>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            let (v0, v1) = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::new_fountain_with_admin_cap<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg8);
            let v2 = v0;
            0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::supply<T0, T1>(arg0, &mut v2, 0x2::coin::into_balance<T1>(arg1));
            0x2::transfer::public_share_object<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>>(v2);
            0x2::transfer::public_transfer<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::AdminCap>(v1, 0x2::tx_context::sender(arg8));
        } else {
            let v3 = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::new_fountain<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg8);
            0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::supply<T0, T1>(arg0, &mut v3, 0x2::coin::into_balance<T1>(arg1));
            0x2::transfer::public_share_object<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<T0, T1>>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

