module 0xf75af0c72e4c459a7d131be68a1e8c03806208d738dbcb7481a69236d0dbe72e::events {
    struct VaultCreated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
    }

    struct Deposit has copy, drop {
        vault_id: address,
        amount: u64,
        shares_minted: u64,
        to_lending_pool: bool,
        to: address,
    }

    struct Withdraw has copy, drop {
        vault_id: address,
        amount: u64,
        from_lending_pool: bool,
        to: address,
    }

    struct FeesTaken has copy, drop {
        vault_id: address,
        performance_fee: u64,
        management_fee: u64,
        shares_minted: u64,
    }

    struct AssetsCompounded has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct AssetsUpdated has copy, drop {
        vault_id: address,
        old_total_assets: u64,
        new_total_assets: u64,
        urealized_gains: u64,
    }

    struct SuilendVaultCreated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
        market_type: 0x1::type_name::TypeName,
        reserve_array_index: u64,
    }

    struct SuilendVaultDeposit has copy, drop {
        vault_id: address,
        amount: u64,
        ctokens_minted: u64,
    }

    struct SuilendVaultWithdraw has copy, drop {
        vault_id: address,
        amount: u64,
        ctokens_burned: u64,
    }

    struct SuilendVaultRewardsClaimed has copy, drop {
        vault_id: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

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
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ScallopVaultCreated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
        scoin_type: 0x1::type_name::TypeName,
    }

    struct ScallopVaultDeposit has copy, drop {
        vault_id: address,
        amount: u64,
        scoin_minted: u64,
    }

    struct ScallopVaultWithdraw has copy, drop {
        vault_id: address,
        amount: u64,
        scoin_burned: u64,
    }

    struct NewGrowCoinRegistered has copy, drop {
        coin_type: 0x1::ascii::String,
    }

    public(friend) fun assets_compounded(arg0: address, arg1: u64) {
        let v0 = AssetsCompounded{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<AssetsCompounded>(v0);
    }

    public(friend) fun assets_updated(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = AssetsUpdated{
            vault_id         : arg0,
            old_total_assets : arg1,
            new_total_assets : arg2,
            urealized_gains  : arg3,
        };
        0x2::event::emit<AssetsUpdated>(v0);
    }

    public(friend) fun deposit(arg0: address, arg1: u64, arg2: u64, arg3: bool, arg4: address) {
        let v0 = Deposit{
            vault_id        : arg0,
            amount          : arg1,
            shares_minted   : arg2,
            to_lending_pool : arg3,
            to              : arg4,
        };
        0x2::event::emit<Deposit>(v0);
    }

    public(friend) fun fees_taken(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = FeesTaken{
            vault_id        : arg0,
            performance_fee : arg1,
            management_fee  : arg2,
            shares_minted   : arg3,
        };
        0x2::event::emit<FeesTaken>(v0);
    }

    public(friend) fun navi_deposit(arg0: address, arg1: u64) {
        let v0 = NaviVaultDeposit{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviVaultDeposit>(v0);
    }

    public(friend) fun navi_rewards_claimed<T0>(arg0: address, arg1: u64) {
        let v0 = NaviVaultRewardsClaimed{
            vault_id    : arg0,
            reward_type : 0x1::type_name::get<T0>(),
            amount      : arg1,
        };
        0x2::event::emit<NaviVaultRewardsClaimed>(v0);
    }

    public(friend) fun navi_vault_created<T0, T1>(arg0: address) {
        let v0 = NaviVaultCreated{
            vault_id                 : arg0,
            coin_type                : 0x1::type_name::get<T0>(),
            aftermath_grow_coin_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<NaviVaultCreated>(v0);
    }

    public(friend) fun navi_withdraw(arg0: address, arg1: u64) {
        let v0 = NaviVaultWithdraw{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviVaultWithdraw>(v0);
    }

    public(friend) fun new_grow_coin_registered<T0>() {
        let v0 = NewGrowCoinRegistered{coin_type: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<NewGrowCoinRegistered>(v0);
    }

    public(friend) fun scallop_deposit(arg0: address, arg1: u64, arg2: u64) {
        let v0 = ScallopVaultDeposit{
            vault_id     : arg0,
            amount       : arg1,
            scoin_minted : arg2,
        };
        0x2::event::emit<ScallopVaultDeposit>(v0);
    }

    public(friend) fun scallop_vault_created(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName) {
        let v0 = ScallopVaultCreated{
            vault_id                 : arg0,
            coin_type                : arg1,
            aftermath_grow_coin_type : arg2,
            scoin_type               : arg3,
        };
        0x2::event::emit<ScallopVaultCreated>(v0);
    }

    public(friend) fun scallop_withdraw(arg0: address, arg1: u64, arg2: u64) {
        let v0 = ScallopVaultWithdraw{
            vault_id     : arg0,
            amount       : arg1,
            scoin_burned : arg2,
        };
        0x2::event::emit<ScallopVaultWithdraw>(v0);
    }

    public(friend) fun suilend_deposit(arg0: address, arg1: u64, arg2: u64) {
        let v0 = SuilendVaultDeposit{
            vault_id       : arg0,
            amount         : arg1,
            ctokens_minted : arg2,
        };
        0x2::event::emit<SuilendVaultDeposit>(v0);
    }

    public(friend) fun suilend_rewards_claimed<T0>(arg0: address, arg1: u64) {
        let v0 = SuilendVaultRewardsClaimed{
            vault_id    : arg0,
            reward_type : 0x1::type_name::get<T0>(),
            amount      : arg1,
        };
        0x2::event::emit<SuilendVaultRewardsClaimed>(v0);
    }

    public(friend) fun suilend_vault_created<T0, T1, T2>(arg0: address, arg1: u64) {
        let v0 = SuilendVaultCreated{
            vault_id                 : arg0,
            coin_type                : 0x1::type_name::get<T1>(),
            aftermath_grow_coin_type : 0x1::type_name::get<T2>(),
            market_type              : 0x1::type_name::get<T0>(),
            reserve_array_index      : arg1,
        };
        0x2::event::emit<SuilendVaultCreated>(v0);
    }

    public(friend) fun suilend_withdraw(arg0: address, arg1: u64, arg2: u64) {
        let v0 = SuilendVaultWithdraw{
            vault_id       : arg0,
            amount         : arg1,
            ctokens_burned : arg2,
        };
        0x2::event::emit<SuilendVaultWithdraw>(v0);
    }

    public(friend) fun vault_created(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) {
        let v0 = VaultCreated{
            vault_id                 : arg0,
            coin_type                : arg1,
            aftermath_grow_coin_type : arg2,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public(friend) fun withdraw(arg0: address, arg1: u64, arg2: bool, arg3: address) {
        let v0 = Withdraw{
            vault_id          : arg0,
            amount            : arg1,
            from_lending_pool : arg2,
            to                : arg3,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

