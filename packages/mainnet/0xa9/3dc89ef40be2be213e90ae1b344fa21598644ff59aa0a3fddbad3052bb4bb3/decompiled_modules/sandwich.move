module 0xa93dc89ef40be2be213e90ae1b344fa21598644ff59aa0a3fddbad3052bb4bb3::sandwich {
    struct Ham has store, key {
        id: 0x2::object::UID,
    }

    struct Bread has store, key {
        id: 0x2::object::UID,
    }

    struct Sandwich has store, key {
        id: 0x2::object::UID,
    }

    struct GroceryOwnerCapability has key {
        id: 0x2::object::UID,
    }

    struct Grocery has key {
        id: 0x2::object::UID,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun buy_bread(arg0: &mut Grocery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : Bread {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == 2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profits, v0);
        Bread{id: 0x2::object::new(arg2)}
    }

    public fun buy_ham(arg0: &mut Grocery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : Ham {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == 10, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profits, v0);
        Ham{id: 0x2::object::new(arg2)}
    }

    public fun collect_profits(arg0: &GroceryOwnerCapability, arg1: &mut Grocery, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        assert!(v0 > 0, 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Grocery{
            id      : 0x2::object::new(arg0),
            profits : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Grocery>(v0);
        let v1 = GroceryOwnerCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GroceryOwnerCapability>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun make_sandwich(arg0: Ham, arg1: Bread, arg2: &mut 0x2::tx_context::TxContext) : Sandwich {
        let Ham { id: v0 } = arg0;
        let Bread { id: v1 } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v1);
        Sandwich{id: 0x2::object::new(arg2)}
    }

    public fun profits(arg0: &Grocery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.profits)
    }

    // decompiled from Move bytecode v6
}

