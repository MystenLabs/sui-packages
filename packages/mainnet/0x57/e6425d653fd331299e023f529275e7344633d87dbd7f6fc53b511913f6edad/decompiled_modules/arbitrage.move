module 0x57e6425d653fd331299e023f529275e7344633d87dbd7f6fc53b511913f6edad::arbitrage {
    struct Vault has key {
        id: 0x2::object::UID,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Pool has key {
        id: 0x2::object::UID,
    }

    struct FlashloanReceipt {
        amount: u64,
    }

    struct ArbitrageExecuted has copy, drop {
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        gas_estimate: u64,
    }

    public fun borrow(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, FlashloanReceipt) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.bal) >= arg1, 0);
        let v0 = FlashloanReceipt{amount: arg1};
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.bal, arg1, arg2), v0)
    }

    public fun create_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id  : 0x2::object::new(arg1),
            bal : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun execute_arbitrage<T0>(arg0: &mut Vault, arg1: &mut Pool, arg2: &mut Pool, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = borrow(arg0, arg4, arg6);
        let v3 = arg4 * 1100 / 10000;
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(v1);
        repay(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v4, v3, arg6), v0);
        let v5 = ArbitrageExecuted{
            amount_in    : arg4,
            amount_out   : arg4 + v3,
            profit       : v3,
            gas_estimate : 600000,
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
    }

    public fun repay(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: FlashloanReceipt) {
        let FlashloanReceipt { amount: v0 } = arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bal, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun vault_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bal)
    }

    // decompiled from Move bytecode v6
}

