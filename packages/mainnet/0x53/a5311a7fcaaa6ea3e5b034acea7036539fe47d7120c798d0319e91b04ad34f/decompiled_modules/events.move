module 0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events {
    struct NaviVaultCreated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
    }

    struct NaviVaultDeposit has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct NaviVaultWithdraw has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct NaviVaultRewardsClaimed has copy, drop {
        vault_id: address,
        rewards_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun navi_vault_created<T0, T1>(arg0: address) {
        let v0 = NaviVaultCreated{
            vault_id                 : arg0,
            coin_type                : 0x1::type_name::get<T0>(),
            aftermath_grow_coin_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<NaviVaultCreated>(v0);
    }

    public(friend) fun navi_vault_deposit(arg0: address, arg1: u64) {
        let v0 = NaviVaultDeposit{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviVaultDeposit>(v0);
    }

    public(friend) fun navi_vault_rewards_claimed<T0>(arg0: address, arg1: u64) {
        let v0 = NaviVaultRewardsClaimed{
            vault_id     : arg0,
            rewards_type : 0x1::type_name::get<T0>(),
            amount       : arg1,
        };
        0x2::event::emit<NaviVaultRewardsClaimed>(v0);
    }

    public(friend) fun navi_vault_withdraw(arg0: address, arg1: u64) {
        let v0 = NaviVaultWithdraw{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviVaultWithdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

