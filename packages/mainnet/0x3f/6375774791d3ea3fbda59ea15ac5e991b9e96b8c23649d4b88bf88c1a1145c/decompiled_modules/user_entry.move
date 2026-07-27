module 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::user_entry {
    struct WithdrawSwapRequested has copy, drop {
        vault_id: address,
        request_id: u64,
        recipient: address,
        target_asset_type: 0x1::ascii::String,
        slippage_bps: u64,
        shares: u256,
    }

    public fun cancel_deposit<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_normal<T0>(arg0);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt_cancellation::assert_receipt_can_be_cancelled(arg1);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::cancel_deposit<T0>(arg0, arg3, arg2, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg1), 0x2::tx_context::sender(arg4))
    }

    public fun cancel_deposit_with_auto_transfer<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_deposit<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun cancel_withdraw<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u256 {
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_normal<T0>(arg0);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::swap_request::try_delete_withdraw_swap_request<T0>(arg0, arg2);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::cancel_withdraw<T0>(arg0, arg3, arg2, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg1), 0x2::tx_context::sender(arg4))
    }

    public fun claim_claimable_principal<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, arg2: u64) : 0x2::balance::Balance<T0> {
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_vault_receipt_matched<T0>(arg0, arg1);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::claim_claimable_principal<T0>(arg0, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg1), arg2)
    }

    public fun deposit<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::reward_manager::RewardManager<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u256, arg5: 0x1::option::Option<0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, 0x2::coin::Coin<T0>) {
        assert!(arg3 > 0, 4004);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 4001);
        assert!(0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::vault_id<T0>(arg0) == 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::reward_manager::vault_id<T0>(arg1), 4002);
        let v0 = if (!0x1::option::is_some<0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt>(&arg5)) {
            0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::reward_manager::issue_receipt<T0>(arg1, arg7)
        } else {
            0x1::option::extract<0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt>(&mut arg5)
        };
        let v1 = v0;
        0x1::option::destroy_none<0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt>(arg5);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_vault_receipt_matched<T0>(arg0, &v1);
        let v2 = 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(&v1);
        if (!0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::contains_vault_receipt_info<T0>(arg0, v2)) {
            0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::add_vault_receipt_info<T0>(arg0, v2, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::reward_manager::issue_vault_receipt_info<T0>(arg1, arg7));
        };
        (0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::request_deposit<T0>(arg0, 0x2::coin::split<T0>(&mut arg2, arg3, arg7), arg6, arg4, v2, 0x2::tx_context::sender(arg7)), v1, arg2)
    }

    public fun deposit_with_auto_transfer<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::reward_manager::RewardManager<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u256, arg5: 0x1::option::Option<0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2) = deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt>(v1, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
        v0
    }

    public fun withdraw<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_vault_receipt_matched<T0>(arg0, arg3);
        assert!(0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::check_locking_time_for_withdraw<T0>(arg0, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg3), arg4), 4003);
        assert!(arg1 > 0, 4004);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::request_withdraw<T0>(arg0, arg4, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg3), arg1, arg2, 0x2::address::from_u256(0))
    }

    public fun withdraw_with_auto_transfer<T0>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_vault_receipt_matched<T0>(arg0, arg3);
        assert!(0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::check_locking_time_for_withdraw<T0>(arg0, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg3), arg4), 4003);
        assert!(arg1 > 0, 4004);
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::request_withdraw<T0>(arg0, arg4, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg3), arg1, arg2, 0x2::tx_context::sender(arg5))
    }

    public fun withdraw_with_swap<T0, T1>(arg0: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: &mut 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::assert_vault_receipt_matched<T0>(arg0, arg3);
        assert!(0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::check_locking_time_for_withdraw<T0>(arg0, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg3), arg4), 4003);
        assert!(arg1 > 0, 4004);
        assert!(arg5 <= 10000, 4004);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::request_withdraw<T0>(arg0, arg4, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::receipt::receipt_id(arg3), arg1, arg2, v0);
        0x2::table::add<u64, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::swap_request::WithdrawSwapRequest>(0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::swap_request::withdraw_swap_requests_mut<T0>(arg0), v2, 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::swap_request::new_withdraw_swap_request(0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::vault_id<T0>(arg0), v2, v0, v1, arg5));
        let v3 = WithdrawSwapRequested{
            vault_id          : 0x8503330c960f116469c2f43a489d153f221833e10053ba8d79da1544ed709028::vault::vault_id<T0>(arg0),
            request_id        : v2,
            recipient         : v0,
            target_asset_type : v1,
            slippage_bps      : arg5,
            shares            : arg1,
        };
        0x2::event::emit<WithdrawSwapRequested>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

