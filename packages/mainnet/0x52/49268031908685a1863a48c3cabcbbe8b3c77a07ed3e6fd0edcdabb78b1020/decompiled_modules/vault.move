module 0x5249268031908685a1863a48c3cabcbbe8b3c77a07ed3e6fd0edcdabb78b1020::vault {
    struct MiniVault has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_profit: u64,
        tx_count: u64,
    }

    struct ProfitTaken has copy, drop {
        amount: u64,
        taker: address,
    }

    struct DepositMade has copy, drop {
        amount: u64,
        depositor: address,
    }

    public entry fun deposit(arg0: &mut MiniVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = DepositMade{
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositMade>(v0);
    }

    public entry fun execute_arb_with_profit(arg0: &mut MiniVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1 + arg2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg1));
        arg0.total_profit = arg0.total_profit + arg2;
        arg0.tx_count = arg0.tx_count + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = ProfitTaken{
            amount : arg2,
            taker  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProfitTaken>(v0);
    }

    public fun get_balance(arg0: &MiniVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun get_stats(arg0: &MiniVault) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui), arg0.total_profit, arg0.tx_count)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MiniVault{
            id           : 0x2::object::new(arg0),
            sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            total_profit : 0,
            tx_count     : 0,
        };
        0x2::transfer::share_object<MiniVault>(v0);
    }

    public entry fun take_profit(arg0: &mut MiniVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1, 0);
        assert!(arg1 > 0, 1);
        arg0.total_profit = arg0.total_profit + arg1;
        arg0.tx_count = arg0.tx_count + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg1), arg2), 0x2::tx_context::sender(arg2));
        let v0 = ProfitTaken{
            amount : arg1,
            taker  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfitTaken>(v0);
    }

    public entry fun withdraw(arg0: &mut MiniVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_all(arg0: &mut MiniVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

