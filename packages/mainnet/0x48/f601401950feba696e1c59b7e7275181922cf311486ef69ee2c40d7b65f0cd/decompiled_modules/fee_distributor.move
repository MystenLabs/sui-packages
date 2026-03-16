module 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::fee_distributor {
    struct FeeVault<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        creator_bps: u64,
        toastr_wallet: address,
        partner: address,
        partner_bps: u64,
    }

    struct FeesDistributed has copy, drop {
        vault_id: 0x2::object::ID,
        total_amount: u64,
        creator_share: u64,
        staker_share: u64,
        toastr_share: u64,
        partner_share: u64,
    }

    public(friend) fun create_vault<T0>(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 != @0x0, 3);
        let v0 = 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::toastr_bps();
        let v1 = 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::staker_bps();
        let v2 = 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::total_bps();
        let (v3, v4) = if (arg2 == @0x0) {
            (arg1, 0)
        } else {
            (arg2, arg3)
        };
        let v5 = v2 - v0 - v1 - v4;
        assert!(v5 + v0 + v1 + v4 == v2, 1);
        let v6 = FeeVault<T0>{
            id            : 0x2::object::new(arg4),
            creator       : arg0,
            creator_bps   : v5,
            toastr_wallet : arg1,
            partner       : v3,
            partner_bps   : v4,
        };
        0x2::transfer::share_object<FeeVault<T0>>(v6);
        0x2::object::id<FeeVault<T0>>(&v6)
    }

    public fun creator<T0>(arg0: &FeeVault<T0>) : address {
        arg0.creator
    }

    public fun creator_bps<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.creator_bps
    }

    public fun distribute<T0>(arg0: &FeeVault<T0>, arg1: &mut 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::staking_pool::StakingPool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::total_bps();
        let v2 = v0 * 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::staker_bps() / v1;
        let v3 = v0 * 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::token_factory::toastr_bps() / v1;
        let v4 = v0 * arg0.partner_bps / v1;
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::staking_pool::deposit_rewards<T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v2), arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v3), arg3), arg0.toastr_wallet);
        if (arg0.partner_bps > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v4), arg3), arg0.partner);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3), arg0.creator);
        let v6 = FeesDistributed{
            vault_id      : 0x2::object::id<FeeVault<T0>>(arg0),
            total_amount  : v0,
            creator_share : v0 - v2 - v3 - v4,
            staker_share  : v2,
            toastr_share  : v3,
            partner_share : v4,
        };
        0x2::event::emit<FeesDistributed>(v6);
    }

    public fun partner<T0>(arg0: &FeeVault<T0>) : address {
        arg0.partner
    }

    public fun partner_bps<T0>(arg0: &FeeVault<T0>) : u64 {
        arg0.partner_bps
    }

    public fun toastr_wallet<T0>(arg0: &FeeVault<T0>) : address {
        arg0.toastr_wallet
    }

    // decompiled from Move bytecode v6
}

