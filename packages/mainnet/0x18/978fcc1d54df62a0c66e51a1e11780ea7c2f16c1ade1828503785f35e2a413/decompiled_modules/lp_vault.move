module 0x18978fcc1d54df62a0c66e51a1e11780ea7c2f16c1ade1828503785f35e2a413::lp_vault {
    struct LP_VAULT has drop {
        dummy_field: bool,
    }

    struct LPVault<phantom T0> has key {
        id: 0x2::object::UID,
        reserves: 0x2::balance::Balance<T0>,
        fee_pool: 0x2::balance::Balance<T0>,
        total_plp: u64,
        withdraw_fee_bps: u64,
        paused: bool,
        admin: address,
        created_at: u64,
    }

    struct PLPTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<LP_VAULT>,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        depositor: address,
        amount_in: u64,
        plp_minted: u64,
        vault_tvl: u64,
        plp_price: u64,
    }

    struct WithdrawEvent has copy, drop {
        withdrawer: address,
        plp_burned: u64,
        amount_out: u64,
        fee_kept: u64,
        vault_tvl: u64,
        plp_price: u64,
    }

    struct FeesReceivedEvent has copy, drop {
        amount: u64,
        new_fee_pool: u64,
    }

    public entry fun create_vault<T0>(arg0: &VaultAdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LPVault<T0>{
            id               : 0x2::object::new(arg2),
            reserves         : 0x2::balance::zero<T0>(),
            fee_pool         : 0x2::balance::zero<T0>(),
            total_plp        : 0,
            withdraw_fee_bps : 50,
            paused           : false,
            admin            : 0x2::tx_context::sender(arg2),
            created_at       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::share_object<LPVault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut LPVault<T0>, arg1: &mut PLPTreasury, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = plp_for_deposit<T0>(arg0, v0);
        assert!(v1 >= arg3, 2);
        0x2::balance::join<T0>(&mut arg0.reserves, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_plp = arg0.total_plp + v1;
        let v2 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP_VAULT>>(0x2::coin::mint<LP_VAULT>(&mut arg1.cap, v1, arg5), v2);
        let v3 = DepositEvent{
            depositor  : v2,
            amount_in  : v0,
            plp_minted : v1,
            vault_tvl  : vault_total<T0>(arg0),
            plp_price  : plp_price<T0>(arg0),
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun fee_pool<T0>(arg0: &LPVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_pool)
    }

    public fun gross_for_withdraw<T0>(arg0: &LPVault<T0>, arg1: u64) : u64 {
        if (arg0.total_plp == 0) {
            return 0
        };
        (((arg1 as u128) * (vault_total<T0>(arg0) as u128) / (arg0.total_plp as u128)) as u64)
    }

    fun init(arg0: LP_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_VAULT>(arg0, 9, b"PLP", b"Predict LP", b"SuiBets LP token. Proportional share of the SuiBets P2P liquidity vault. Earn a fee cut on every settled bet.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LP_VAULT>>(v1);
        let v2 = PLPTreasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<PLPTreasury>(v2);
        let v3 = VaultAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VaultAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused<T0>(arg0: &LPVault<T0>) : bool {
        arg0.paused
    }

    public fun plp_for_deposit<T0>(arg0: &LPVault<T0>, arg1: u64) : u64 {
        let v0 = vault_total<T0>(arg0);
        if (arg0.total_plp == 0 || v0 == 0) {
            return arg1
        };
        (((arg1 as u128) * (arg0.total_plp as u128) / (v0 as u128)) as u64)
    }

    public fun plp_price<T0>(arg0: &LPVault<T0>) : u64 {
        if (arg0.total_plp == 0) {
            return 1000000000
        };
        (((vault_total<T0>(arg0) as u128) * (1000000000 as u128) / (arg0.total_plp as u128)) as u64)
    }

    public fun receive_fees<T0>(arg0: &mut LPVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.fee_pool, arg1);
        let v0 = FeesReceivedEvent{
            amount       : 0x2::balance::value<T0>(&arg1),
            new_fee_pool : 0x2::balance::value<T0>(&arg0.fee_pool),
        };
        0x2::event::emit<FeesReceivedEvent>(v0);
    }

    public fun reserves<T0>(arg0: &LPVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserves)
    }

    public entry fun set_paused<T0>(arg0: &VaultAdminCap, arg1: &mut LPVault<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_withdraw_fee<T0>(arg0: &VaultAdminCap, arg1: &mut LPVault<T0>, arg2: u64) {
        assert!(arg2 <= 500, 5);
        arg1.withdraw_fee_bps = arg2;
    }

    public fun total_plp<T0>(arg0: &LPVault<T0>) : u64 {
        arg0.total_plp
    }

    public fun vault_total<T0>(arg0: &LPVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserves) + 0x2::balance::value<T0>(&arg0.fee_pool)
    }

    public entry fun withdraw<T0>(arg0: &mut LPVault<T0>, arg1: &mut PLPTreasury, arg2: 0x2::coin::Coin<LP_VAULT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<LP_VAULT>(&arg2);
        assert!(v0 > 0, 0);
        assert!(arg0.total_plp >= v0, 3);
        let v1 = (((v0 as u128) * (vault_total<T0>(arg0) as u128) / (arg0.total_plp as u128)) as u64);
        let v2 = v1 * arg0.withdraw_fee_bps / 10000;
        let v3 = v1 - v2;
        assert!(v3 >= arg3, 2);
        assert!(v1 <= vault_total<T0>(arg0), 4);
        0x2::coin::burn<LP_VAULT>(&mut arg1.cap, arg2);
        arg0.total_plp = arg0.total_plp - v0;
        let v4 = 0x2::balance::value<T0>(&arg0.reserves);
        let v5 = if (v3 <= v4) {
            0x2::balance::split<T0>(&mut arg0.reserves, v3)
        } else {
            let v6 = 0x2::balance::split<T0>(&mut arg0.reserves, v4);
            0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(&mut arg0.fee_pool, v3 - v4));
            v6
        };
        let v7 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), v7);
        let v8 = WithdrawEvent{
            withdrawer : v7,
            plp_burned : v0,
            amount_out : v3,
            fee_kept   : v2,
            vault_tvl  : vault_total<T0>(arg0),
            plp_price  : plp_price<T0>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

