module 0xadb4dda54f665b4f668db678042156889b4afc2714a1839254e9caaf17aca2d6::grid_vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        paused: bool,
        risk: RiskParams,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct TraderCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct RiskParams has copy, drop, store {
        max_in_per_trade: u64,
        cooldown_ms: u64,
    }

    struct VaultCreatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct DepositEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        side: u8,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        side: u8,
        amount: u64,
    }

    struct TradeEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        side: u8,
        amount_in: u64,
        amount_out: u64,
    }

    struct PausedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    struct RiskParamsUpdatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        max_in_per_trade: u64,
        cooldown_ms: u64,
    }

    public fun assert_can_trade<T0, T1>(arg0: &Vault<T0, T1>, arg1: &TraderCap) {
        assert_trader_cap<T0, T1>(arg0, arg1);
        assert_not_paused<T0, T1>(arg0);
    }

    fun assert_has_sufficient_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        if (0x2::balance::value<T0>(arg0) < arg1) {
            abort 4
        };
    }

    fun assert_non_zero_amount(arg0: u64) {
        if (arg0 == 0) {
            abort 3
        };
    }

    fun assert_not_paused<T0, T1>(arg0: &Vault<T0, T1>) {
        if (arg0.paused) {
            abort 1
        };
    }

    fun assert_owner_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &OwnerCap) {
        if (arg1.vault_id != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            abort 0
        };
    }

    fun assert_trader_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &TraderCap) {
        if (arg1.vault_id != 0x2::object::id<Vault<T0, T1>>(arg0)) {
            abort 0
        };
    }

    public fun balance_a<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_a)
    }

    public fun balance_b<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_b)
    }

    public fun create_and_share<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : (OwnerCap, TraderCap, 0x2::object::ID) {
        let (v0, v1, v2) = create_internal<T0, T1>(arg0);
        let v3 = v2;
        0x2::transfer::share_object<Vault<T0, T1>>(v3);
        (v0, v1, 0x2::object::id<Vault<T0, T1>>(&v3))
    }

    fun create_internal<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : (OwnerCap, TraderCap, Vault<T0, T1>) {
        let v0 = Vault<T0, T1>{
            id        : 0x2::object::new(arg0),
            balance_a : 0x2::balance::zero<T0>(),
            balance_b : 0x2::balance::zero<T1>(),
            paused    : false,
            risk      : new_risk_params(),
        };
        let v1 = 0x2::object::id<Vault<T0, T1>>(&v0);
        let v2 = OwnerCap{
            id       : 0x2::object::new(arg0),
            vault_id : v1,
        };
        let v3 = TraderCap{
            id       : 0x2::object::new(arg0),
            vault_id : v1,
        };
        let v4 = VaultCreatedEvent{
            vault_id : v1,
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreatedEvent>(v4);
        (v2, v3, v0)
    }

    public fun deposit_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: 0x2::coin::Coin<T0>) {
        assert_owner_cap<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert_non_zero_amount(v0);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg2));
        let v1 = DepositEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            side     : 0,
            amount   : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun deposit_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: 0x2::coin::Coin<T1>) {
        assert_owner_cap<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert_non_zero_amount(v0);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
        let v1 = DepositEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            side     : 1,
            amount   : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun get_risk_params<T0, T1>(arg0: &Vault<T0, T1>) : RiskParams {
        arg0.risk
    }

    public fun is_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.paused
    }

    fun new_risk_params() : RiskParams {
        RiskParams{
            max_in_per_trade : 0,
            cooldown_ms      : 0,
        }
    }

    public fun owner_cap_vault_id(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun set_paused<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: bool) {
        assert_owner_cap<T0, T1>(arg0, arg1);
        arg0.paused = arg2;
        let v0 = PausedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            paused   : arg2,
        };
        0x2::event::emit<PausedEvent>(v0);
    }

    public fun set_risk_params<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: u64, arg3: u64) {
        assert_owner_cap<T0, T1>(arg0, arg1);
        let v0 = RiskParams{
            max_in_per_trade : arg2,
            cooldown_ms      : arg3,
        };
        arg0.risk = v0;
        let v1 = RiskParamsUpdatedEvent{
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg0),
            max_in_per_trade : arg2,
            cooldown_ms      : arg3,
        };
        0x2::event::emit<RiskParamsUpdatedEvent>(v1);
    }

    public fun trader_cap_vault_id(arg0: &TraderCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Vault<T0, T1>>(arg0)
    }

    public fun vault_swap_a_to_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &TraderCap, arg2: u64, arg3: u64, arg4: vector<u8>) : u64 {
        assert_can_trade<T0, T1>(arg0, arg1);
        assert_non_zero_amount(arg2);
        assert_has_sufficient_balance<T0>(&arg0.balance_a, arg2);
        let v0 = TradeEvent{
            vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
            side       : 0,
            amount_in  : arg2,
            amount_out : 0,
        };
        0x2::event::emit<TradeEvent>(v0);
        abort 2
    }

    public fun vault_swap_b_to_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &TraderCap, arg2: u64, arg3: u64, arg4: vector<u8>) : u64 {
        assert_can_trade<T0, T1>(arg0, arg1);
        assert_non_zero_amount(arg2);
        assert_has_sufficient_balance<T1>(&arg0.balance_b, arg2);
        let v0 = TradeEvent{
            vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
            side       : 1,
            amount_in  : arg2,
            amount_out : 0,
        };
        0x2::event::emit<TradeEvent>(v0);
        abort 2
    }

    public fun withdraw_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner_cap<T0, T1>(arg0, arg1);
        assert_non_zero_amount(arg2);
        assert_has_sufficient_balance<T0>(&arg0.balance_a, arg2);
        let v0 = WithdrawEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            side     : 0,
            amount   : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, arg2), arg3)
    }

    public fun withdraw_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_owner_cap<T0, T1>(arg0, arg1);
        assert_non_zero_amount(arg2);
        assert_has_sufficient_balance<T1>(&arg0.balance_b, arg2);
        let v0 = WithdrawEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            side     : 1,
            amount   : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

