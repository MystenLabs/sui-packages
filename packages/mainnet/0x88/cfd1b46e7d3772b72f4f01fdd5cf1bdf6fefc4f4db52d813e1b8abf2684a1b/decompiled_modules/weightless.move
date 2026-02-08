module 0x88cfd1b46e7d3772b72f4f01fdd5cf1bdf6fefc4f4db52d813e1b8abf2684a1b::weightless {
    struct VaultRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        x_verifier: address,
        min_strategist_deposit: u64,
        vault_count: u64,
    }

    struct CopyVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        collateral: 0x2::balance::Balance<T0>,
        strategist: address,
        bot_manager: address,
        x_handle: vector<u8>,
        x_verified: bool,
        shares: 0x2::table::Table<address, u64>,
        total_shares: u64,
        total_bot_withdrawn: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        strategist: address,
        bot_manager: address,
        initial_deposit: u64,
    }

    struct XHandleVerified has copy, drop {
        vault_id: 0x2::object::ID,
        x_handle: vector<u8>,
    }

    struct Deposit has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        shares_minted: u64,
    }

    struct Withdraw has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawer: address,
        shares_burned: u64,
        amount_out: u64,
    }

    struct BotWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct BotDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun admin_update_min_deposit(arg0: &mut VaultRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        arg0.min_strategist_deposit = arg1;
    }

    public entry fun admin_update_x_verifier(arg0: &mut VaultRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 8);
        arg0.x_verifier = arg1;
    }

    public entry fun bot_deposit<T0>(arg0: &mut CopyVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bot_manager, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        if (v0 >= arg0.total_bot_withdrawn) {
            arg0.total_bot_withdrawn = 0;
        } else {
            arg0.total_bot_withdrawn = arg0.total_bot_withdrawn - v0;
        };
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        let v1 = BotDeposit{
            vault_id : 0x2::object::id<CopyVault<T0>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<BotDeposit>(v1);
    }

    public fun bot_manager<T0>(arg0: &CopyVault<T0>) : address {
        arg0.bot_manager
    }

    public entry fun bot_withdraw<T0>(arg0: &mut CopyVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bot_manager, 0);
        assert!(arg1 > 0, 3);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.collateral), 2);
        arg0.total_bot_withdrawn = arg0.total_bot_withdrawn + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, arg1), arg2), 0x2::tx_context::sender(arg2));
        let v0 = BotWithdraw{
            vault_id : 0x2::object::id<CopyVault<T0>>(arg0),
            amount   : arg1,
        };
        0x2::event::emit<BotWithdraw>(v0);
    }

    public fun collateral_value<T0>(arg0: &CopyVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public entry fun create_vault<T0>(arg0: &mut VaultRegistry, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg0.min_strategist_deposit, 6);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::table::new<address, u64>(arg3);
        0x2::table::add<address, u64>(&mut v2, v1, v0);
        let v3 = CopyVault<T0>{
            id                  : 0x2::object::new(arg3),
            collateral          : 0x2::coin::into_balance<T0>(arg1),
            strategist          : v1,
            bot_manager         : arg2,
            x_handle            : b"",
            x_verified          : false,
            shares              : v2,
            total_shares        : v0,
            total_bot_withdrawn : 0,
        };
        arg0.vault_count = arg0.vault_count + 1;
        let v4 = VaultCreated{
            vault_id        : 0x2::object::id<CopyVault<T0>>(&v3),
            strategist      : v1,
            bot_manager     : arg2,
            initial_deposit : v0,
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::public_share_object<CopyVault<T0>>(v3);
    }

    public entry fun deposit<T0>(arg0: &mut CopyVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = arg0.total_shares;
        let v2 = if (v1 == 0) {
            v0
        } else {
            (((v0 as u128) * (v1 as u128) / ((0x2::balance::value<T0>(&arg0.collateral) + arg0.total_bot_withdrawn) as u128)) as u64)
        };
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.shares, v3)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.shares, v3);
            *v4 = *v4 + v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.shares, v3, v2);
        };
        arg0.total_shares = arg0.total_shares + v2;
        let v5 = Deposit{
            vault_id      : 0x2::object::id<CopyVault<T0>>(arg0),
            depositor     : v3,
            amount        : v0,
            shares_minted : v2,
        };
        0x2::event::emit<Deposit>(v5);
    }

    public fun get_shares<T0>(arg0: &CopyVault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id                     : 0x2::object::new(arg0),
            admin                  : 0x2::tx_context::sender(arg0),
            x_verifier             : 0x2::tx_context::sender(arg0),
            min_strategist_deposit : 100000000,
            vault_count            : 0,
        };
        let v1 = RegistryCreated{
            registry_id : 0x2::object::id<VaultRegistry>(&v0),
            admin       : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun min_strategist_deposit(arg0: &VaultRegistry) : u64 {
        arg0.min_strategist_deposit
    }

    public fun share_supply<T0>(arg0: &CopyVault<T0>) : u64 {
        arg0.total_shares
    }

    public fun strategist<T0>(arg0: &CopyVault<T0>) : address {
        arg0.strategist
    }

    public fun total_bot_withdrawn<T0>(arg0: &CopyVault<T0>) : u64 {
        arg0.total_bot_withdrawn
    }

    public fun tvl<T0>(arg0: &CopyVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral) + arg0.total_bot_withdrawn
    }

    public fun vault_count(arg0: &VaultRegistry) : u64 {
        arg0.vault_count
    }

    public entry fun verify_x_handle<T0>(arg0: &VaultRegistry, arg1: &mut CopyVault<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.x_verifier, 4);
        assert!(!arg1.x_verified, 5);
        arg1.x_handle = arg2;
        arg1.x_verified = true;
        let v0 = XHandleVerified{
            vault_id : 0x2::object::id<CopyVault<T0>>(arg1),
            x_handle : arg2,
        };
        0x2::event::emit<XHandleVerified>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut CopyVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.shares, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.shares, v0);
        assert!(*v1 >= arg1, 7);
        let v2 = (((arg1 as u128) * ((0x2::balance::value<T0>(&arg0.collateral) + arg0.total_bot_withdrawn) as u128) / (arg0.total_shares as u128)) as u64);
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.collateral), 2);
        *v1 = *v1 - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, v2), arg2), v0);
        let v3 = Withdraw{
            vault_id      : 0x2::object::id<CopyVault<T0>>(arg0),
            withdrawer    : v0,
            shares_burned : arg1,
            amount_out    : v2,
        };
        0x2::event::emit<Withdraw>(v3);
    }

    public fun x_handle<T0>(arg0: &CopyVault<T0>) : vector<u8> {
        arg0.x_handle
    }

    // decompiled from Move bytecode v6
}

