module 0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::vault {
    struct VaultShare<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        liquidity: 0x2::balance::Balance<T0>,
        rewards: 0x2::table::Table<address, 0x2::balance::Balance<VaultShare<T0>>>,
        shares_supply: 0x2::balance::Supply<VaultShare<T0>>,
    }

    struct DepositEvent has copy, drop {
        assets_amount_in: u64,
        shares_amount_out: u64,
    }

    struct RedeemEvent has copy, drop {
        shares_value_in: u64,
        asset_value_out: u64,
    }

    public(friend) fun add<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun admin_claim<T0>(arg0: &0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::admin::AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VaultShare<T0>> {
        assert!(arg1.version == 1, 2);
        0x2::coin::from_balance<VaultShare<T0>>(claim_balance<T0>(arg1, @0x0, 0x1::option::some<u64>(arg2)), arg3)
    }

    public fun admin_claim_all<T0>(arg0: &0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::admin::AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VaultShare<T0>> {
        assert!(arg1.version == 1, 2);
        0x2::coin::from_balance<VaultShare<T0>>(claim_balance<T0>(arg1, @0x0, 0x1::option::none<u64>()), arg2)
    }

    fun assets_to_shares<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        (((arg1 as u128) * ((total_shares<T0>(arg0) + 1) as u128) / ((total_assets<T0>(arg0) + 1) as u128)) as u64)
    }

    fun calc_admin_dividends(arg0: u64) : u64 {
        (((arg0 as u128) * 10 / 10000) as u64)
    }

    fun calc_exit_fee(arg0: u64) : u64 {
        (((arg0 as u128) * 50 / 10000) as u64)
    }

    public fun claim<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VaultShare<T0>> {
        assert!(arg0.version == 1, 2);
        0x2::coin::from_balance<VaultShare<T0>>(claim_balance<T0>(arg0, 0x2::tx_context::sender(arg2), 0x1::option::some<u64>(arg1)), arg2)
    }

    public fun claim_all<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VaultShare<T0>> {
        assert!(arg0.version == 1, 2);
        0x2::coin::from_balance<VaultShare<T0>>(claim_balance<T0>(arg0, 0x2::tx_context::sender(arg1), 0x1::option::none<u64>()), arg1)
    }

    fun claim_balance<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: 0x1::option::Option<u64>) : 0x2::balance::Balance<VaultShare<T0>> {
        if (0x1::option::is_some<u64>(&arg2)) {
            0x2::balance::split<VaultShare<T0>>(0x2::table::borrow_mut<address, 0x2::balance::Balance<VaultShare<T0>>>(&mut arg0.rewards, arg1), 0x1::option::extract<u64>(&mut arg2))
        } else {
            0x2::balance::withdraw_all<VaultShare<T0>>(0x2::table::borrow_mut<address, 0x2::balance::Balance<VaultShare<T0>>>(&mut arg0.rewards, arg1))
        }
    }

    public fun create<T0>(arg0: &0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<address, 0x2::balance::Balance<VaultShare<T0>>>(arg1);
        0x2::table::add<address, 0x2::balance::Balance<VaultShare<T0>>>(&mut v0, @0x0, 0x2::balance::zero<VaultShare<T0>>());
        let v1 = VaultShare<T0>{dummy_field: false};
        let v2 = Vault<T0>{
            id            : 0x2::object::new(arg1),
            version       : 1,
            liquidity     : 0x2::balance::zero<T0>(),
            rewards       : v0,
            shares_supply : 0x2::balance::create_supply<VaultShare<T0>>(v1),
        };
        0x2::transfer::share_object<Vault<T0>>(v2);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VaultShare<T0>> {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = assets_to_shares<T0>(arg0, v0);
        0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::coin::into_balance<T0>(arg1));
        let v2 = DepositEvent{
            assets_amount_in  : v0,
            shares_amount_out : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
        0x2::coin::from_balance<VaultShare<T0>>(0x2::balance::increase_supply<VaultShare<T0>>(&mut arg0.shares_supply, v1), arg2)
    }

    public(friend) fun has_reward<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x2::balance::Balance<VaultShare<T0>>>(&arg0.rewards, arg1)
    }

    public(friend) fun init_reward<T0>(arg0: &mut Vault<T0>, arg1: address) {
        0x2::table::add<address, 0x2::balance::Balance<VaultShare<T0>>>(&mut arg0.rewards, arg1, 0x2::balance::zero<VaultShare<T0>>());
    }

    public(friend) fun max_payout<T0>(arg0: &Vault<T0>) : u64 {
        (((0x2::balance::value<T0>(&arg0.liquidity) as u128) * 1618 / 100000) as u64)
    }

    public(friend) fun mint_and_deposit<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address) {
        if (!has_reward<T0>(arg0, arg2)) {
            init_reward<T0>(arg0, arg2);
        };
        0x2::balance::join<VaultShare<T0>>(0x2::table::borrow_mut<address, 0x2::balance::Balance<VaultShare<T0>>>(&mut arg0.rewards, arg2), 0x2::balance::increase_supply<VaultShare<T0>>(&mut arg0.shares_supply, arg1));
    }

    public(friend) fun payout<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.liquidity, arg1), arg2), arg2);
    }

    public fun redeem<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<VaultShare<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::coin::value<VaultShare<T0>>(&arg1);
        0x2::balance::join<VaultShare<T0>>(0x2::table::borrow_mut<address, 0x2::balance::Balance<VaultShare<T0>>>(&mut arg0.rewards, @0x0), 0x2::balance::split<VaultShare<T0>>(0x2::coin::balance_mut<VaultShare<T0>>(&mut arg1), calc_admin_dividends(v0)));
        let v1 = shares_to_assets<T0>(arg0, 0x2::coin::value<VaultShare<T0>>(&arg1));
        let v2 = 0x2::balance::split<T0>(&mut arg0.liquidity, v1 - calc_exit_fee(v1));
        0x2::balance::decrease_supply<VaultShare<T0>>(&mut arg0.shares_supply, 0x2::coin::into_balance<VaultShare<T0>>(arg1));
        let v3 = RedeemEvent{
            shares_value_in : v0,
            asset_value_out : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<RedeemEvent>(v3);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    fun shares_to_assets<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        (((arg1 as u128) * ((total_assets<T0>(arg0) + 1) as u128) / ((total_shares<T0>(arg0) + 1) as u128)) as u64)
    }

    fun total_assets<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquidity)
    }

    fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares_supply)
    }

    // decompiled from Move bytecode v6
}

