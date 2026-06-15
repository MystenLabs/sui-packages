module 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        total_shares: u64,
        reserve: 0x2::balance::Balance<T0>,
        supplied: u64,
        score: u8,
        status: u8,
        utilization_bps: u64,
        volatility_bps: u64,
        health_buffer_bps: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        shares_minted: u64,
        score: u8,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        shares_burned: u64,
    }

    struct ScoreUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        score: u8,
        status: u8,
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                : 0x2::object::new(arg0),
            total_shares      : 0,
            reserve           : 0x2::balance::zero<T0>(),
            supplied          : 0,
            score             : 100,
            status            : 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::status_safe(),
            utilization_bps   : 0,
            volatility_bps    : 0,
            health_buffer_bps : 10000,
        };
        let v1 = 0x2::object::id<Vault<T0>>(&v0);
        0x2::transfer::share_object<Vault<T0>>(v0);
        let v2 = AdminCap{
            id       : 0x2::object::new(arg0),
            vault_id : v1,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = VaultCreated{vault_id: v1};
        0x2::event::emit<VaultCreated>(v3);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::ShieldReceipt<T0> {
        assert!(0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::deposits_allowed(arg0.status), 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::paused());
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::zero_amount());
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v0;
        0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::navi_adapter::mock_supply(&mut arg0.supplied, v0);
        refresh_score_internal<T0>(arg0);
        let v1 = Deposited{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            amount        : v0,
            shares_minted : v0,
            score         : arg0.score,
        };
        0x2::event::emit<Deposited>(v1);
        0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::mint<T0>(0x2::object::id<Vault<T0>>(arg0), v0, arg2)
    }

    public fun deposit_into_receipt<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::ShieldReceipt<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::deposits_allowed(arg0.status), 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::paused());
        assert!(0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::vault_id<T0>(arg1) == 0x2::object::id<Vault<T0>>(arg0), 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::wrong_vault());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::zero_amount());
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_shares = arg0.total_shares + v0;
        0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::add_shares<T0>(arg1, v0);
        0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::navi_adapter::mock_supply(&mut arg0.supplied, v0);
        refresh_score_internal<T0>(arg0);
        let v1 = Deposited{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            amount        : v0,
            shares_minted : v0,
            score         : arg0.score,
        };
        0x2::event::emit<Deposited>(v1);
    }

    fun refresh_score_internal<T0>(arg0: &mut Vault<T0>) {
        let v0 = 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::compute_score(0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::util_component_from_bps(arg0.utilization_bps), 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::vol_component_from_bps(arg0.volatility_bps), 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::health_component_from_bps(arg0.health_buffer_bps));
        let v1 = 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score::status_from_score(v0);
        arg0.score = v0;
        arg0.status = v1;
        let v2 = ScoreUpdated{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            score    : v0,
            status   : v1,
        };
        0x2::event::emit<ScoreUpdated>(v2);
    }

    public fun score<T0>(arg0: &Vault<T0>) : u8 {
        arg0.score
    }

    public fun status<T0>(arg0: &Vault<T0>) : u8 {
        arg0.status
    }

    public fun supplied<T0>(arg0: &Vault<T0>) : u64 {
        arg0.supplied
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun update_metrics<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0>>(arg1), 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::not_admin());
        arg1.utilization_bps = arg2;
        arg1.volatility_bps = arg3;
        arg1.health_buffer_bps = arg4;
        refresh_score_internal<T0>(arg1);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::ShieldReceipt<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::vault_id<T0>(arg1) == 0x2::object::id<Vault<T0>>(arg0), 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::wrong_vault());
        assert!(0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::shares<T0>(arg1) >= arg2, 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::errors::insufficient_shares());
        0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::receipt::subtract_shares<T0>(arg1, arg2);
        arg0.total_shares = arg0.total_shares - arg2;
        0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::navi_adapter::mock_withdraw(&mut arg0.supplied, arg2);
        let v0 = Withdrawn{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            amount        : arg2,
            shares_burned : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

