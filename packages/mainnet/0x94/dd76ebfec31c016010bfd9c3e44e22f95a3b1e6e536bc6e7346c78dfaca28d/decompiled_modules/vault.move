module 0x94dd76ebfec31c016010bfd9c3e44e22f95a3b1e6e536bc6e7346c78dfaca28d::vault {
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

    public entry fun add_strategy_id(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1001);
        0x1::vector::push_back<address>(&mut arg0.strategy_ids, arg1);
    }

    public fun add_total_shares(arg0: &mut Vault, arg1: u64) {
        arg0.total_shares = arg0.total_shares + arg1;
    }

    public entry fun deposit<T0, T1>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x94dd76ebfec31c016010bfd9c3e44e22f95a3b1e6e536bc6e7346c78dfaca28d::strategy::Strategies, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 >= arg0.config.min_deposit, 1);
        let v1 = v0 * 1000;
        arg0.sui_balance = arg0.sui_balance + v0;
        arg0.total_shares = arg0.total_shares + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(0x2::coin::mint<VAULT>(&mut arg0.share_treasury, v1, arg6), 0x2::tx_context::sender(arg6));
        0x94dd76ebfec31c016010bfd9c3e44e22f95a3b1e6e536bc6e7346c78dfaca28d::strategy::allocate_and_execute(&arg5, v0, arg6);
        0x2::transfer::public_share_object<0x94dd76ebfec31c016010bfd9c3e44e22f95a3b1e6e536bc6e7346c78dfaca28d::strategy::Strategies>(arg5);
        0x94dd76ebfec31c016010bfd9c3e44e22f95a3b1e6e536bc6e7346c78dfaca28d::suilend_adapter::deposit_to_suilend<T0, T1>(arg2, arg3, arg4, arg1, arg6);
        let v2 = DepositEvent{
            user   : 0x2::tx_context::sender(arg6),
            amount : v0,
            shares : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun emit_performance_fee_event(arg0: &Vault, arg1: u64, arg2: address) {
        let v0 = PerformanceFeeAccruedEvent{
            fee_shares : arg1,
            treasury   : arg2,
        };
        0x2::event::emit<PerformanceFeeAccruedEvent>(v0);
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

    public fun get_sui_balance(arg0: &Vault) : u64 {
        arg0.sui_balance
    }

    public fun get_total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
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
        };
        0x2::transfer::public_share_object<Vault>(v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAULT>>(v1, 0x2::tx_context::sender(arg1));
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

    public entry fun withdraw(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<VAULT>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0x2::sui::SUI>, arg4: u64, arg5: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0x2::sui::SUI, 0x2::sui::SUI>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(arg2 > 0 && arg2 <= arg0.total_shares, 1);
        let v0 = arg2 / 1000;
        assert!(v0 <= arg0.sui_balance, 2);
        arg0.sui_balance = arg0.sui_balance - v0;
        arg0.total_shares = arg0.total_shares - arg2;
        0x2::coin::burn<VAULT>(&mut arg0.share_treasury, 0x2::coin::split<VAULT>(arg1, arg2, arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x94dd76ebfec31c016010bfd9c3e44e22f95a3b1e6e536bc6e7346c78dfaca28d::suilend_adapter::withdraw_from_suilend(arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7));
        let v1 = WithdrawEvent{
            user   : 0x2::tx_context::sender(arg7),
            amount : v0,
            shares : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

