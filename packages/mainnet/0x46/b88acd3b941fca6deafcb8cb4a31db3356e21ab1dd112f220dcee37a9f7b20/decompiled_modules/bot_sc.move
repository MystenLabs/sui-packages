module 0x46b88acd3b941fca6deafcb8cb4a31db3356e21ab1dd112f220dcee37a9f7b20::bot_sc {
    struct BotOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct BotWallet has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ReferCreator has store, key {
        id: 0x2::object::UID,
    }

    struct Refer has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun claim_reward(arg0: &mut Refer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_refer(arg0: &ReferCreator, arg1: &BotOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Refer{
            id      : 0x2::object::new(arg3),
            owner   : arg2,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Refer>(v0);
    }

    public fun deposit(arg0: &mut BotWallet, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Refer, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) > 0, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v0 * 1 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v0 * 9999 / 10000));
    }

    public fun distribute(arg0: &mut BotWallet, arg1: &BotOwnerCap, arg2: address, arg3: address, arg4: &mut Refer, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg4.balance, 0x2::balance::value<0x2::sui::SUI>(&arg4.balance)));
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 >= 1000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 70 / 100), arg5), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 30 / 100), arg5), arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BotOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BotOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = BotWallet{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = ReferCreator{id: 0x2::object::new(arg0)};
        let v3 = Refer{
            id      : 0x2::object::new(arg0),
            owner   : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<BotWallet>(v1);
        0x2::transfer::share_object<ReferCreator>(v2);
        0x2::transfer::share_object<Refer>(v3);
    }

    public fun withdraw(arg0: &mut BotWallet, arg1: &BotOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

