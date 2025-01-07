module 0x67661310f6a1039f0190af000d5fb1a1c4aa2a47fd13705c106877fcefb886ed::donuts {
    struct Donut has key {
        id: 0x2::object::UID,
    }

    struct DonutShop has store, key {
        id: 0x2::object::UID,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ShopCap has key {
        id: 0x2::object::UID,
    }

    entry fun collectBalance(arg0: &mut ShopCap, arg1: &mut DonutShop, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun deleteDonut(arg0: Donut) {
        let Donut { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    entry fun getDonut(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut DonutShop, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1.price, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), arg1.price));
        let v0 = Donut{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<Donut>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DonutShop{
            id      : 0x2::object::new(arg0),
            price   : 10000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<DonutShop>(v0);
        let v1 = ShopCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ShopCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

