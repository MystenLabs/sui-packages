module 0xeab7010e0876c2142756af4acb83a758ce751247ead88ec59d414977305ca71f::arbitrage {
    struct Vault has key {
        id: 0x2::object::UID,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Receipt {
        amount: u64,
    }

    struct ArbitrageProfit has copy, drop {
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        sender: address,
    }

    public fun borrow(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Receipt) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.bal) >= arg1, 0);
        let v0 = Receipt{amount: arg1};
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.bal, arg1, arg2), v0)
    }

    public fun create_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id  : 0x2::object::new(arg1),
            bal : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun execute_arbitrage(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = borrow(arg0, arg2, arg4);
        let v3 = arg2 * 1000 / 10000;
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(v1);
        repay(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg4), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v4, v3, arg4), v0);
        let v5 = ArbitrageProfit{
            amount_in  : arg2,
            amount_out : arg2 + v3,
            profit     : v3,
            sender     : v0,
        };
        0x2::event::emit<ArbitrageProfit>(v5);
    }

    public fun repay(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: Receipt) {
        let Receipt { amount: v0 } = arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bal, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun vault_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bal)
    }

    // decompiled from Move bytecode v6
}

