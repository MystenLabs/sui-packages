module 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::user_entry {
    public fun cancel_deposit<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::cancel_deposit<T0>(arg0, arg3, arg2, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(arg1), 0x2::tx_context::sender(arg4))
    }

    public fun cancel_deposit_with_auto_transfer<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_deposit<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun cancel_withdraw<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u256 {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::cancel_withdraw<T0>(arg0, arg3, arg2, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(arg1), 0x2::tx_context::sender(arg4))
    }

    public fun claim_claimable_principal<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt, arg2: u64) : 0x2::balance::Balance<T0> {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::claim_claimable_principal<T0>(arg0, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(arg1), arg2)
    }

    public fun deposit<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::RewardManager<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u256, arg5: 0x1::option::Option<0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt, 0x2::coin::Coin<T0>) {
        assert!(arg3 > 0, 4004);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 4001);
        assert!(0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::vault_id<T0>(arg0) == 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::vault_id<T0>(arg1), 4002);
        let v0 = if (!0x1::option::is_some<0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt>(&arg5)) {
            0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::issue_receipt<T0>(arg1, arg7)
        } else {
            0x1::option::extract<0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt>(&mut arg5)
        };
        let v1 = v0;
        0x1::option::destroy_none<0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt>(arg5);
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::assert_vault_receipt_matched<T0>(arg0, &v1);
        let v2 = 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(&v1);
        if (!0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::contains_vault_receipt_info<T0>(arg0, v2)) {
            0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::add_vault_receipt_info<T0>(arg0, v2, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::issue_vault_receipt_info<T0>(arg1, arg7));
        };
        (0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::request_deposit<T0>(arg0, 0x2::coin::split<T0>(&mut arg2, arg3, arg7), arg6, arg4, v2, 0x2::tx_context::sender(arg7)), v1, arg2)
    }

    public fun deposit_with_auto_transfer<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::reward_manager::RewardManager<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u256, arg5: 0x1::option::Option<0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt>(v1, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
        v0
    }

    public fun withdraw<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::assert_vault_receipt_matched<T0>(arg0, arg3);
        assert!(0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::check_locking_time_for_withdraw<T0>(arg0, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(arg3), arg4), 4003);
        assert!(arg1 > 0, 4004);
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::request_withdraw<T0>(arg0, arg4, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(arg3), arg1, arg2, 0x2::address::from_u256(0))
    }

    public fun withdraw_with_auto_transfer<T0>(arg0: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: &mut 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::assert_vault_receipt_matched<T0>(arg0, arg3);
        assert!(0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::check_locking_time_for_withdraw<T0>(arg0, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(arg3), arg4), 4003);
        assert!(arg1 > 0, 4004);
        0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::vault::request_withdraw<T0>(arg0, arg4, 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::receipt::receipt_id(arg3), arg1, arg2, 0x2::tx_context::sender(arg5))
    }

    // decompiled from Move bytecode v6
}

