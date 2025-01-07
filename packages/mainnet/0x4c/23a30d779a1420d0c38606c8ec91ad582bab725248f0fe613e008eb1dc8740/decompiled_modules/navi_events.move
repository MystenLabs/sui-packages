module 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_events {
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

    struct RewardsClaimed has copy, drop {
        vault_id: address,
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

    public(friend) fun navi_vault_rewards_claimed(arg0: address, arg1: u64) {
        let v0 = RewardsClaimed{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<RewardsClaimed>(v0);
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

