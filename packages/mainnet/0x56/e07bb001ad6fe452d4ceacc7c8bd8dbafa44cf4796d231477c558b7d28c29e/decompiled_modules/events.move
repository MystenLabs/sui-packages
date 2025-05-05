module 0x5a1ada90b2f07c37f73d757ca57d24dd9b875693183807cc8064810d4f2f8973::events {
    struct SuilendVaultCreated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
    }

    struct SuilendVaultDeposit has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct SuilendVaultWithdraw has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct RewardsClaimed has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun suilend_vault_created<T0, T1>(arg0: address) {
        let v0 = SuilendVaultCreated{
            vault_id                 : arg0,
            coin_type                : 0x1::type_name::get<T0>(),
            aftermath_grow_coin_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<SuilendVaultCreated>(v0);
    }

    public(friend) fun suilend_vault_deposit(arg0: address, arg1: u64) {
        let v0 = SuilendVaultDeposit{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SuilendVaultDeposit>(v0);
    }

    public(friend) fun suilend_vault_rewards_claimed<T0>(arg0: address, arg1: u64) {
        let v0 = RewardsClaimed{
            vault_id  : arg0,
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<RewardsClaimed>(v0);
    }

    public(friend) fun suilend_vault_withdraw(arg0: address, arg1: u64) {
        let v0 = SuilendVaultWithdraw{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SuilendVaultWithdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

