module 0xdbd3c82018f4aa055a980b13fbd287f2165d87a38b37f787f79ec308c360c863::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        sui_balance: u64,
        total_shares: u64,
        hwm: u64,
        paused: bool,
        config: VaultConfig,
        admin: address,
        strategy_ids: vector<address>,
        sui_index: u8,
        usdc_index: u8,
        share_treasury: 0x2::coin::TreasuryCap<VAULT>,
        ctoken: 0x1::option::Option<0x2::object::ID>,
        obligation_cap: 0x1::option::Option<0x2::object::ID>,
    }

    struct VaultConfig has store {
        min_deposit: u64,
        deposit_paused: bool,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        amount: u64,
        shares: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        user: address,
        amount: u64,
        shares: u64,
    }

    struct StrategyUpdatedEvent has copy, drop, store {
        by: address,
        new_strategy: address,
    }

    struct EmergencyToggledEvent has copy, drop, store {
        by: address,
        paused: bool,
    }

    struct PerformanceFeeAccruedEvent has copy, drop, store {
        fee_shares: u64,
        treasury: address,
    }

    struct BorrowEvent has copy, drop, store {
        vault_id: address,
        borrowed_amount: u64,
        borrow_type: 0x1::type_name::TypeName,
        timestamp: u64,
    }

    struct LiquidationEvent has copy, drop, store {
        vault_id: address,
        liquidated_amount: u64,
        seized_collateral: u64,
        liquidator: address,
        timestamp: u64,
    }

    struct RewardsClaimedEvent has copy, drop, store {
        vault_id: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        compounded: bool,
        timestamp: u64,
    }

    struct LSTConversionEvent has copy, drop, store {
        user: address,
        sui_amount: u64,
        lst_amount: u64,
    }

    public fun accrue_performance_fee(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_pps(arg0);
        let v1 = arg0.config.fee_recipient;
        if (v0 <= (arg0.hwm as u128)) {
            arg0.hwm = (v0 as u64);
            return
        };
        let v2 = arg1 * arg0.config.fee_bps / 10000;
        if (v2 == 0) {
            arg0.hwm = (v0 as u64);
            return
        };
        let v3 = (((v2 as u128) * (arg0.total_shares as u128) / (arg0.sui_balance as u128)) as u64);
        if (v3 > 0) {
            arg0.total_shares = arg0.total_shares + v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v3, arg2), v1);
        };
        arg0.hwm = (v0 as u64);
        let v4 = PerformanceFeeAccruedEvent{
            fee_shares : v3,
            treasury   : v1,
        };
        0x2::event::emit<PerformanceFeeAccruedEvent>(v4);
    }

    public entry fun add_strategy_id(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1001);
        0x1::vector::push_back<address>(&mut arg0.strategy_ids, arg1);
    }

    public fun add_total_shares(arg0: &mut Vault, arg1: u64) {
        arg0.total_shares = arg0.total_shares + arg1;
    }

    public fun calc_shares_for_deposit(arg0: &Vault, arg1: u64) : u64 {
        if (arg0.total_shares == 0 || arg0.sui_balance == 0) {
            arg1
        } else {
            arg1 * arg0.total_shares / arg0.sui_balance
        }
    }

    public entry fun deposit_with_lst(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.config.min_deposit, 1);
        let v1 = calc_shares_for_deposit(arg0, v0);
        arg0.sui_balance = arg0.sui_balance + v0;
        arg0.total_shares = arg0.total_shares + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v1, arg2), 0x2::tx_context::sender(arg2));
        let v2 = v0 / 2;
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.coin), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.sui_balance = arg0.sui_balance + v0 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg2), arg0.admin);
        let v3 = DepositEvent{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
            shares : v1,
        };
        0x2::event::emit<DepositEvent>(v3);
        let v4 = LSTConversionEvent{
            user       : 0x2::tx_context::sender(arg2),
            sui_amount : v2,
            lst_amount : v2,
        };
        0x2::event::emit<LSTConversionEvent>(v4);
    }

    public fun emit_performance_fee_event(arg0: &Vault, arg1: u64, arg2: address) {
        let v0 = PerformanceFeeAccruedEvent{
            fee_shares : arg1,
            treasury   : arg2,
        };
        0x2::event::emit<PerformanceFeeAccruedEvent>(v0);
    }

    public fun get_admin(arg0: &Vault) : address {
        arg0.admin
    }

    public fun get_fee_bps(arg0: &Vault) : u64 {
        arg0.config.fee_bps
    }

    public fun get_fee_recipient(arg0: &Vault) : address {
        arg0.config.fee_recipient
    }

    public fun get_hwm(arg0: &Vault) : u64 {
        arg0.hwm
    }

    public fun get_pps(arg0: &Vault) : u128 {
        if (arg0.total_shares == 0) {
            1000000000000
        } else {
            (arg0.sui_balance as u128) * 1000000000000 / (arg0.total_shares as u128)
        }
    }

    public entry fun get_reward_and_compound(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.sui_balance = arg0.sui_balance + arg1;
        let v0 = get_pps(arg0);
        if (v0 > (arg0.hwm as u128)) {
            let v1 = arg0.config.fee_recipient;
            let v2 = arg1 * arg0.config.fee_bps / 10000;
            if (v2 > 0) {
                let v3 = (((v2 as u128) * (arg0.total_shares as u128) / (arg0.sui_balance as u128)) as u64);
                arg0.total_shares = arg0.total_shares + v3;
                0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v3, arg2), v1);
                let v4 = PerformanceFeeAccruedEvent{
                    fee_shares : v3,
                    treasury   : v1,
                };
                0x2::event::emit<PerformanceFeeAccruedEvent>(v4);
            };
            arg0.hwm = (v0 as u64);
        } else {
            arg0.hwm = (v0 as u64);
        };
    }

    public fun get_sui_balance(arg0: &Vault) : u64 {
        arg0.sui_balance
    }

    public fun get_total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
    }

    public fun get_vault_id(arg0: &Vault) : address {
        0x2::object::id_address<Vault>(arg0)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"VSHARE", b"Vault Share", b"Vault share token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = VaultConfig{
            min_deposit    : 10,
            deposit_paused : false,
            fee_bps        : 1000,
            fee_recipient  : 0x2::tx_context::sender(arg1),
        };
        let v3 = Vault{
            id             : 0x2::object::new(arg1),
            coin           : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1),
            sui_balance    : 0,
            total_shares   : 0,
            hwm            : 0,
            paused         : false,
            config         : v2,
            admin          : 0x2::tx_context::sender(arg1),
            strategy_ids   : 0x1::vector::empty<address>(),
            sui_index      : 0,
            usdc_index     : 1,
            share_treasury : v0,
            ctoken         : 0x1::option::none<0x2::object::ID>(),
            obligation_cap : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<Vault>(v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun set_hwm(arg0: &mut Vault, arg1: u64) {
        arg0.hwm = arg1;
    }

    public entry fun set_strategy(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = StrategyUpdatedEvent{
            by           : 0x2::tx_context::sender(arg2),
            new_strategy : arg1,
        };
        0x2::event::emit<StrategyUpdatedEvent>(v0);
    }

    public entry fun toggle_pause(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.paused = !arg0.paused;
        let v0 = EmergencyToggledEvent{
            by     : 0x2::tx_context::sender(arg1),
            paused : arg0.paused,
        };
        0x2::event::emit<EmergencyToggledEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

