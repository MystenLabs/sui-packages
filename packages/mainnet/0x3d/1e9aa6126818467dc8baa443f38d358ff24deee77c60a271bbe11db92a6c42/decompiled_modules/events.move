module 0x3d1e9aa6126818467dc8baa443f38d358ff24deee77c60a271bbe11db92a6c42::events {
    struct ScallopVaultCreated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
    }

    struct ScallopVaultDeposit has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct ScallopVaultWithdraw has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct ScallopVaultRewardsClaimed has copy, drop {
        vault_id: address,
        rewards_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun scallop_vault_created<T0, T1>(arg0: address) {
        let v0 = ScallopVaultCreated{
            vault_id                 : arg0,
            coin_type                : 0x1::type_name::get<T0>(),
            aftermath_grow_coin_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ScallopVaultCreated>(v0);
    }

    public(friend) fun scallop_vault_deposit(arg0: address, arg1: u64) {
        let v0 = ScallopVaultDeposit{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopVaultDeposit>(v0);
    }

    public(friend) fun scallop_vault_rewards_claimed<T0>(arg0: address, arg1: u64) {
        let v0 = ScallopVaultRewardsClaimed{
            vault_id     : arg0,
            rewards_type : 0x1::type_name::get<T0>(),
            amount       : arg1,
        };
        0x2::event::emit<ScallopVaultRewardsClaimed>(v0);
    }

    public(friend) fun scallop_vault_withdraw(arg0: address, arg1: u64) {
        let v0 = ScallopVaultWithdraw{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopVaultWithdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

