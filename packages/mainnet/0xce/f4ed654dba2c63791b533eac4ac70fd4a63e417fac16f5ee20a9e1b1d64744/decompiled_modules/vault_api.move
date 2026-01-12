module 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault_api {
    public entry fun accept_admin_change<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::accept_admin_change<T0, T1>(arg0, arg1);
    }

    public entry fun accept_operator_change<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::accept_operator_change<T0, T1>(arg0, arg1);
    }

    public entry fun cancel_admin_change<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::cancel_admin_change<T0, T1>(arg0, arg1);
    }

    public entry fun cancel_deposit<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::PendingDeposits<T0>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::cancel_deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancel_deposit_by_id<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::PendingDeposits<T0>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::cancel_deposit_by_id<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun cancel_operator_change<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::cancel_operator_change<T0, T1>(arg0, arg1);
    }

    public entry fun charge_mgmt_fee<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::charge_mgmt_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun claim<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Claims<T0>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun create<T0, T1>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::create<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun deposit<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::PendingDeposits<T0>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun deposit_reserve<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::deposit_reserve<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun finalize_redeems<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::PendingRedeems<T1>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::finalize_redeems<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun initiate_admin_change<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::initiate_admin_change<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun initiate_operator_change<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::initiate_operator_change<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun instant_redeem<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Balances<T1>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::instant_redeem<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun queue_redeem<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::PendingRedeems<T1>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Balances<T1>, arg3: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::queue_redeem<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun set_cancel_deposit_enabled<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_cancel_deposit_enabled<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_cancel_deposit_fee<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_cancel_deposit_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_fee_recipient<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_fee_recipient<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_fees<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_fees<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_instant_redeem_enabled<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_instant_redeem_enabled<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_instant_redeem_fee<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_instant_redeem_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_operator<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_operator<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_pause<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_role_change_delay<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_role_change_delay<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_settle_interval<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_settle_interval<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_withdraw_fee<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_withdraw_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_withdraw_rcusdp_enabled<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::set_withdraw_rcusdp_enabled<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun settle_deposits<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::PendingDeposits<T0>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Balances<T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::settle_deposits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun settle_redeems<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::settle_redeems<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun sync_price<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::sync_price<T0, T1>(arg0, arg1);
    }

    public entry fun take_pending_rcusdp<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::take_pending_rcusdp<T0, T1>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun take_pending_usdc<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::take_pending_usdc<T0, T1>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun withdraw_rcusdp<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Balances<T1>, arg2: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::withdraw_rcusdp<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdraw_reserve<T0, T1>(arg0: &mut 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault::withdraw_reserve<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

