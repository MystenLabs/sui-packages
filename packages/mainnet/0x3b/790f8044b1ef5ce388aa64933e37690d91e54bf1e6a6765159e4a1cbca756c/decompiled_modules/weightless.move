module 0x3b790f8044b1ef5ce388aa64933e37690d91e54bf1e6a6765159e4a1cbca756c::weightless {
    struct WEIGHTLESS has drop {
        dummy_field: bool,
    }

    struct CopyVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        collateral: 0x2::balance::Balance<T0>,
        share_treasury: 0x2::coin::TreasuryCap<WEIGHTLESS>,
        strategist: address,
        bot_manager: address,
        x_handle: vector<u8>,
        x_verified: bool,
        total_bot_withdrawn: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        strategist: address,
        bot_manager: address,
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

    public entry fun create_vault<T0>(arg0: 0x2::coin::TreasuryCap<WEIGHTLESS>, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CopyVault<T0>{
            id                  : 0x2::object::new(arg3),
            collateral          : 0x2::balance::zero<T0>(),
            share_treasury      : arg0,
            strategist          : 0x2::tx_context::sender(arg3),
            bot_manager         : arg1,
            x_handle            : arg2,
            x_verified          : false,
            total_bot_withdrawn : 0,
        };
        let v1 = VaultCreated{
            vault_id    : 0x2::object::id<CopyVault<T0>>(&v0),
            strategist  : 0x2::tx_context::sender(arg3),
            bot_manager : arg1,
            x_handle    : arg2,
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::public_share_object<CopyVault<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut CopyVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::total_supply<WEIGHTLESS>(&arg0.share_treasury);
        let v2 = if (v1 == 0) {
            v0
        } else {
            (((v0 as u128) * (v1 as u128) / ((0x2::balance::value<T0>(&arg0.collateral) + arg0.total_bot_withdrawn) as u128)) as u64)
        };
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<WEIGHTLESS>>(0x2::coin::mint<WEIGHTLESS>(&mut arg0.share_treasury, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = Deposit{
            vault_id      : 0x2::object::id<CopyVault<T0>>(arg0),
            depositor     : 0x2::tx_context::sender(arg2),
            amount        : v0,
            shares_minted : v2,
        };
        0x2::event::emit<Deposit>(v3);
    }

    fun init(arg0: WEIGHTLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIGHTLESS>(arg0, 6, b"WLSS", b"Weightless Share", b"Copy trading vault share token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIGHTLESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEIGHTLESS>>(v1);
    }

    public fun share_supply<T0>(arg0: &CopyVault<T0>) : u64 {
        0x2::coin::total_supply<WEIGHTLESS>(&arg0.share_treasury)
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

    public entry fun withdraw<T0>(arg0: &mut CopyVault<T0>, arg1: 0x2::coin::Coin<WEIGHTLESS>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<WEIGHTLESS>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = (((v0 as u128) * ((0x2::balance::value<T0>(&arg0.collateral) + arg0.total_bot_withdrawn) as u128) / (0x2::coin::total_supply<WEIGHTLESS>(&arg0.share_treasury) as u128)) as u64);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.collateral), 2);
        0x2::coin::burn<WEIGHTLESS>(&mut arg0.share_treasury, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, v1), arg2), 0x2::tx_context::sender(arg2));
        let v2 = Withdraw{
            vault_id      : 0x2::object::id<CopyVault<T0>>(arg0),
            withdrawer    : 0x2::tx_context::sender(arg2),
            shares_burned : v0,
            amount_out    : v1,
        };
        0x2::event::emit<Withdraw>(v2);
    }

    public fun x_handle<T0>(arg0: &CopyVault<T0>) : vector<u8> {
        arg0.x_handle
    }

    // decompiled from Move bytecode v6
}

