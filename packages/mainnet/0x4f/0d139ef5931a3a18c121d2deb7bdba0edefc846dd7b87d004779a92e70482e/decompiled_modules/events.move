module 0x4f0d139ef5931a3a18c121d2deb7bdba0edefc846dd7b87d004779a92e70482e::events {
    struct VaultCreated has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
    }

    struct Deposit has copy, drop {
        vault_id: address,
        amount: u64,
        shares_minted: u64,
        to: address,
    }

    struct Withdraw has copy, drop {
        vault_id: address,
        amount: u64,
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

    struct NewGrowCoinRegistered has copy, drop {
        coin_type: 0x1::ascii::String,
    }

    struct SoulboundGrowCreate has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        aftermath_grow_coin_type: 0x1::type_name::TypeName,
    }

    struct SoulboundGrowDeposit has copy, drop {
        vault_id: address,
        amount: u64,
    }

    struct SoulboundGrowWithdraw has copy, drop {
        vault_id: address,
        amount: u64,
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

    public(friend) fun deposit(arg0: address, arg1: u64, arg2: u64, arg3: address) {
        let v0 = Deposit{
            vault_id      : arg0,
            amount        : arg1,
            shares_minted : arg2,
            to            : arg3,
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

    public(friend) fun new_grow_coin_registered<T0>() {
        let v0 = NewGrowCoinRegistered{coin_type: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<NewGrowCoinRegistered>(v0);
    }

    public(friend) fun soulbound_grow_created(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) {
        let v0 = SoulboundGrowCreate{
            vault_id                 : arg0,
            coin_type                : arg1,
            aftermath_grow_coin_type : arg2,
        };
        0x2::event::emit<SoulboundGrowCreate>(v0);
    }

    public(friend) fun soulbound_grow_deposit(arg0: address, arg1: u64) {
        let v0 = SoulboundGrowDeposit{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SoulboundGrowDeposit>(v0);
    }

    public(friend) fun soulbound_grow_withdraw(arg0: address, arg1: u64) {
        let v0 = SoulboundGrowWithdraw{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SoulboundGrowWithdraw>(v0);
    }

    public(friend) fun vault_created(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) {
        let v0 = VaultCreated{
            vault_id                 : arg0,
            coin_type                : arg1,
            aftermath_grow_coin_type : arg2,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public(friend) fun withdraw(arg0: address, arg1: u64, arg2: address) {
        let v0 = Withdraw{
            vault_id : arg0,
            amount   : arg1,
            to       : arg2,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

