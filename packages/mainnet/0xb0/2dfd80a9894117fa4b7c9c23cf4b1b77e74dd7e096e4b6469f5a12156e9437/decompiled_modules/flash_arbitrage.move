module 0xb02dfd80a9894117fa4b7c9c23cf4b1b77e74dd7e096e4b6469f5a12156e9437::flash_arbitrage {
    struct FlashArbitrage has key {
        id: 0x2::object::UID,
        owner: address,
        total_profit_mist: u64,
        total_volume_mist: u64,
        successful_trades: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        active: bool,
    }

    struct ArbitrageEvent has copy, drop {
        loan_amount: u64,
        profit: u64,
        success: bool,
    }

    public entry fun deposit_profit(arg0: &mut FlashArbitrage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, arg1);
        arg0.total_profit_mist = arg0.total_profit_mist + 0x2::coin::value<0x2::sui::SUI>(&arg1);
    }

    public entry fun emergency_withdraw(arg0: &mut FlashArbitrage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, arg1, arg2), arg0.owner);
    }

    public entry fun execute_arbitrage(arg0: &mut FlashArbitrage, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg0.active, 2);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0x2::sui::SUI>>(&arg1)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = arg2 - v1 - 1;
        if (v2 > 1000000) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg3));
            arg0.total_profit_mist = arg0.total_profit_mist + v2;
            arg0.successful_trades = arg0.successful_trades + 1;
            let v3 = ArbitrageEvent{
                loan_amount : v1,
                profit      : v2,
                success     : true,
            };
            0x2::event::emit<ArbitrageEvent>(v3);
        };
        arg0.total_volume_mist = arg0.total_volume_mist + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.owner);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashArbitrage{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            total_profit_mist : 0,
            total_volume_mist : 0,
            successful_trades : 0,
            treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            active            : true,
        };
        0x2::transfer::share_object<FlashArbitrage>(v0);
    }

    public fun stats(arg0: &FlashArbitrage) : (u64, u64, u64, u64) {
        (arg0.total_profit_mist, arg0.total_volume_mist, arg0.successful_trades, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    public entry fun toggle_active(arg0: &mut FlashArbitrage, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.active = !arg0.active;
    }

    public entry fun withdraw_profits(arg0: &mut FlashArbitrage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, v0, arg1), arg0.owner);
        };
    }

    // decompiled from Move bytecode v6
}

