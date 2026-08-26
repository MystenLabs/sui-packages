module 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault {
    struct ATOMIC_VAULT has drop {
        dummy_field: bool,
    }

    struct LiquidationVault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorizedTraderKey has copy, drop, store {
        pos0: address,
    }

    public fun balance<T0>(arg0: &LiquidationVault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    fun assert_admin(arg0: &LiquidationVault, arg1: &AdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<LiquidationVault>(arg0), 0);
    }

    public(friend) fun assert_authorized(arg0: &LiquidationVault, arg1: &0x2::tx_context::TxContext) {
        let v0 = if (!arg0.paused) {
            let v1 = AuthorizedTraderKey{pos0: 0x2::tx_context::sender(arg1)};
            0x2::dynamic_field::exists<AuthorizedTraderKey>(&arg0.id, v1)
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun authorize_trader(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        let v0 = AuthorizedTraderKey{pos0: arg2};
        if (!0x2::dynamic_field::exists<AuthorizedTraderKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<AuthorizedTraderKey, bool>(&mut arg0.id, v0, true);
        };
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = LiquidationVault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
            paused   : false,
        };
        0x2::transfer::share_object<LiquidationVault>(v0);
        AdminCap{
            id       : 0x2::object::new(arg0),
            vault_id : 0x2::object::id<LiquidationVault>(&v0),
        }
    }

    public fun deauthorize_trader(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        let v0 = AuthorizedTraderKey{pos0: arg2};
        if (0x2::dynamic_field::exists<AuthorizedTraderKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<AuthorizedTraderKey, bool>(&mut arg0.id, v0);
        };
    }

    public fun deposit<T0>(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        assert_admin(arg0, arg1);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut LiquidationVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    fun init(arg0: ATOMIC_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun set_paused(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.paused = arg2;
    }

    public fun withdraw<T0>(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_admin(arg0, arg1);
        0x2::coin::from_balance<T0>(withdraw_balance<T0>(arg0, arg2), arg3)
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut LiquidationVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0), 2);
        let v1 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 2);
        0x2::balance::split<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v7
}

