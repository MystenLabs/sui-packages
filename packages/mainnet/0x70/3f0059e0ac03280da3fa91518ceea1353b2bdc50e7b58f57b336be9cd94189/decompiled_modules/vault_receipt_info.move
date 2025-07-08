module 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_receipt_info {
    struct VaultReceiptInfoUpdated has copy, drop {
        new_reward: u256,
        unclaimed_reward: u256,
    }

    struct VaultReceiptInfo has store {
        status: u8,
        shares: u256,
        pending_deposit_balance: u64,
        pending_withdraw_shares: u256,
        last_deposit_time: u64,
        claimable_principal: u64,
        reward_indices: 0x2::table::Table<0x1::type_name::TypeName, u256>,
        unclaimed_rewards: 0x2::table::Table<0x1::type_name::TypeName, u256>,
    }

    public fun claimable_principal(arg0: &VaultReceiptInfo) : u64 {
        arg0.claimable_principal
    }

    public fun get_receipt_reward(arg0: &VaultReceiptInfo, arg1: 0x1::type_name::TypeName) : u256 {
        if (0x2::table::contains<0x1::type_name::TypeName, u256>(&arg0.unclaimed_rewards, arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.unclaimed_rewards, arg1)
        } else {
            0
        }
    }

    public fun get_receipt_rewards(arg0: &VaultReceiptInfo, arg1: vector<0x1::type_name::TypeName>) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            0x1::vector::push_back<u256>(&mut v0, get_receipt_reward(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2)));
            v2 = v2 + 1;
        };
        0x1::vector::reverse<u256>(&mut v0);
        v0
    }

    public fun last_deposit_time(arg0: &VaultReceiptInfo) : u64 {
        arg0.last_deposit_time
    }

    public(friend) fun new_vault_receipt_info(arg0: 0x2::table::Table<0x1::type_name::TypeName, u256>, arg1: 0x2::table::Table<0x1::type_name::TypeName, u256>) : VaultReceiptInfo {
        VaultReceiptInfo{
            status                  : 0,
            shares                  : 0,
            pending_deposit_balance : 0,
            pending_withdraw_shares : 0,
            last_deposit_time       : 0,
            claimable_principal     : 0,
            reward_indices          : arg0,
            unclaimed_rewards       : arg1,
        }
    }

    public fun pending_deposit_balance(arg0: &VaultReceiptInfo) : u64 {
        arg0.pending_deposit_balance
    }

    public fun pending_withdraw_shares(arg0: &VaultReceiptInfo) : u256 {
        arg0.pending_withdraw_shares
    }

    public(friend) fun reset_unclaimed_rewards<T0>(arg0: &mut VaultReceiptInfo) : u256 {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(&mut arg0.unclaimed_rewards, 0x1::type_name::get<T0>());
        *v0 = 0;
        *v0
    }

    public(friend) fun reward_indices(arg0: &VaultReceiptInfo) : &0x2::table::Table<0x1::type_name::TypeName, u256> {
        &arg0.reward_indices
    }

    public(friend) fun reward_indices_mut(arg0: &mut VaultReceiptInfo) : &mut 0x2::table::Table<0x1::type_name::TypeName, u256> {
        &mut arg0.reward_indices
    }

    public fun shares(arg0: &VaultReceiptInfo) : u256 {
        arg0.shares
    }

    public fun status(arg0: &VaultReceiptInfo) : u8 {
        arg0.status
    }

    public(friend) fun unclaimed_rewards(arg0: &VaultReceiptInfo) : &0x2::table::Table<0x1::type_name::TypeName, u256> {
        &arg0.unclaimed_rewards
    }

    public(friend) fun unclaimed_rewards_mut(arg0: &mut VaultReceiptInfo) : &mut 0x2::table::Table<0x1::type_name::TypeName, u256> {
        &mut arg0.unclaimed_rewards
    }

    public(friend) fun update_after_cancel_deposit(arg0: &mut VaultReceiptInfo, arg1: u64) {
        arg0.status = 0;
        arg0.pending_deposit_balance = arg0.pending_deposit_balance - arg1;
    }

    public(friend) fun update_after_cancel_withdraw(arg0: &mut VaultReceiptInfo, arg1: u256) {
        arg0.status = 0;
        arg0.pending_withdraw_shares = arg0.pending_withdraw_shares - arg1;
    }

    public(friend) fun update_after_claim_principal(arg0: &mut VaultReceiptInfo, arg1: u64) {
        arg0.claimable_principal = arg0.claimable_principal - arg1;
    }

    public(friend) fun update_after_execute_deposit(arg0: &mut VaultReceiptInfo, arg1: u64, arg2: u256, arg3: u64) {
        arg0.status = 0;
        arg0.shares = arg0.shares + arg2;
        arg0.pending_deposit_balance = arg0.pending_deposit_balance - arg1;
        arg0.last_deposit_time = arg3;
    }

    public(friend) fun update_after_execute_withdraw(arg0: &mut VaultReceiptInfo, arg1: u256, arg2: u64) {
        arg0.status = 0;
        arg0.shares = arg0.shares - arg1;
        arg0.pending_withdraw_shares = arg0.pending_withdraw_shares - arg1;
        arg0.claimable_principal = arg0.claimable_principal + arg2;
    }

    public(friend) fun update_after_request_deposit(arg0: &mut VaultReceiptInfo, arg1: u64) {
        arg0.status = 1;
        arg0.pending_deposit_balance = arg0.pending_deposit_balance + arg1;
    }

    public(friend) fun update_after_request_withdraw(arg0: &mut VaultReceiptInfo, arg1: u256, arg2: address) {
        let v0 = if (arg2 == 0x2::address::from_u256(0)) {
            2
        } else {
            3
        };
        arg0.status = v0;
        arg0.pending_withdraw_shares = arg0.pending_withdraw_shares + arg1;
    }

    public(friend) fun update_reward(arg0: &mut VaultReceiptInfo, arg1: 0x1::type_name::TypeName, arg2: u256) : u256 {
        let v0 = &mut arg0.reward_indices;
        if (!0x2::table::contains<0x1::type_name::TypeName, u256>(v0, arg1)) {
            0x2::table::add<0x1::type_name::TypeName, u256>(v0, arg1, 0);
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, u256>(&arg0.unclaimed_rewards, arg1)) {
            0x2::table::add<0x1::type_name::TypeName, u256>(&mut arg0.unclaimed_rewards, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(v0, arg1);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(&mut arg0.unclaimed_rewards, arg1);
        if (arg2 > *v1) {
            let v3 = 0x703f0059e0ac03280da3fa91518ceea1353b2bdc50e7b58f57b336be9cd94189::vault_utils::mul_with_oracle_price(arg2 - *v1, arg0.shares);
            *v1 = arg2;
            *v2 = *v2 + v3;
            let v4 = VaultReceiptInfoUpdated{
                new_reward       : v3,
                unclaimed_reward : *v2,
            };
            0x2::event::emit<VaultReceiptInfoUpdated>(v4);
            return v3
        };
        0
    }

    // decompiled from Move bytecode v6
}

