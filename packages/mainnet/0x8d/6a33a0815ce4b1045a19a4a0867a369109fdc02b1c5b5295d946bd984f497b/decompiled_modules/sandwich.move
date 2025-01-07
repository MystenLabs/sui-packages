module 0x8d6a33a0815ce4b1045a19a4a0867a369109fdc02b1c5b5295d946bd984f497b::sandwich {
    struct Ham has key {
        id: 0x2::object::UID,
    }

    struct Bread has key {
        id: 0x2::object::UID,
    }

    struct Sandwich has key {
        id: 0x2::object::UID,
    }

    struct GroceryOwnerCapability has key {
        id: 0x2::object::UID,
    }

    struct Grocery has key {
        id: 0x2::object::UID,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun buy_bread(arg0: &mut Grocery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == 2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profits, v0);
        let v1 = Bread{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<Bread>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun buy_ham(arg0: &mut Grocery, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == 10, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profits, v0);
        let v1 = Ham{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<Ham>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun collect_profits(arg0: &GroceryOwnerCapability, arg1: &mut Grocery, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2), 0x2::tx_context::sender(arg2));
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

    public entry fun make_sandwich(arg0: Ham, arg1: Bread, arg2: &mut 0x2::tx_context::TxContext) {
        let Ham { id: v0 } = arg0;
        let Bread { id: v1 } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v1);
        let v2 = Sandwich{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<Sandwich>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun profits(arg0: &Grocery) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.profits)
    }

    // decompiled from Move bytecode v6
}

