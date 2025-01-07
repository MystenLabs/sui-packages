module 0x4ee5fd6be25f9c496f1f896a5427e01ec49979f49027256e9753e67c8c9c241::no {
    struct NO has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct SpamData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun balance(arg0: &OwnerCap, arg1: &SpamData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg1.balance)
    }

    public fun deposit(arg0: &OwnerCap, arg1: &mut SpamData, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3));
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        let v1 = SpamData{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<SpamData>(v1);
    }

    public fun withdraw(arg0: &OwnerCap, arg1: &mut SpamData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg2, arg3)
    }

    public fun withdraw_all_balance(arg0: &OwnerCap, arg1: &mut SpamData, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

