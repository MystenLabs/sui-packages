module 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::share_token {
    struct ShareToken has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
        minted_at: u64,
        initial_deposit: u64,
    }

    struct ShareMinted has copy, drop {
        token_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        deposit_amount: u64,
    }

    struct ShareBurned has copy, drop {
        token_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        shares: u64,
        redeemed_amount: u64,
    }

    struct ShareTransferred has copy, drop {
        token_id: 0x2::object::ID,
        from: address,
        to: address,
        shares: u64,
    }

    public fun burn(arg0: ShareToken, arg1: u64, arg2: u64) : u64 {
        let ShareToken {
            id              : v0,
            vault_id        : v1,
            shares          : v2,
            minted_at       : _,
            initial_deposit : _,
        } = arg0;
        let v5 = v0;
        let v6 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::shares_to_amount(v2, arg1, arg2);
        let v7 = ShareBurned{
            token_id        : 0x2::object::uid_to_inner(&v5),
            vault_id        : v1,
            shares          : v2,
            redeemed_amount : v6,
        };
        0x2::event::emit<ShareBurned>(v7);
        0x2::object::delete(v5);
        v6
    }

    public fun current_value(arg0: &ShareToken, arg1: u64, arg2: u64) : u64 {
        0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::shares_to_amount(arg0.shares, arg1, arg2)
    }

    public fun initial_deposit(arg0: &ShareToken) : u64 {
        arg0.initial_deposit
    }

    public fun merge(arg0: &mut ShareToken, arg1: ShareToken) {
        let ShareToken {
            id              : v0,
            vault_id        : v1,
            shares          : v2,
            minted_at       : _,
            initial_deposit : v4,
        } = arg1;
        assert!(v1 == arg0.vault_id, 201);
        arg0.shares = arg0.shares + v2;
        arg0.initial_deposit = arg0.initial_deposit + v4;
        0x2::object::delete(v0);
    }

    public fun mint(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (ShareToken, u64) {
        let v0 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::amount_to_shares(arg1, arg2, arg3);
        assert!(v0 > 0, 200);
        let v1 = ShareToken{
            id              : 0x2::object::new(arg5),
            vault_id        : arg0,
            shares          : v0,
            minted_at       : arg4,
            initial_deposit : arg1,
        };
        let v2 = ShareMinted{
            token_id       : 0x2::object::id<ShareToken>(&v1),
            vault_id       : arg0,
            owner          : 0x2::tx_context::sender(arg5),
            shares         : v0,
            deposit_amount : arg1,
        };
        0x2::event::emit<ShareMinted>(v2);
        (v1, v0)
    }

    public fun minted_at(arg0: &ShareToken) : u64 {
        arg0.minted_at
    }

    public fun pnl(arg0: &ShareToken, arg1: u64, arg2: u64) : (bool, u64) {
        let v0 = current_value(arg0, arg1, arg2);
        if (v0 >= arg0.initial_deposit) {
            (true, v0 - arg0.initial_deposit)
        } else {
            (false, arg0.initial_deposit - v0)
        }
    }

    public fun shares(arg0: &ShareToken) : u64 {
        arg0.shares
    }

    public fun split(arg0: &mut ShareToken, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ShareToken {
        assert!(arg1 > 0 && arg1 < arg0.shares, 202);
        arg0.shares = arg0.shares - arg1;
        ShareToken{
            id              : 0x2::object::new(arg2),
            vault_id        : arg0.vault_id,
            shares          : arg1,
            minted_at       : arg0.minted_at,
            initial_deposit : 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(arg0.initial_deposit, (((arg1 as u128) * 10000 / ((arg0.shares + arg1) as u128)) as u64)),
        }
    }

    public fun vault_id(arg0: &ShareToken) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

