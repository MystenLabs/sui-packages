module 0xffbf54282c0c29f000c2606414244bc0e4a65585037176604b18f13f93df99ca::donuts {
    struct ShopOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Donut has key {
        id: 0x2::object::UID,
    }

    struct DonutShop has key {
        id: 0x2::object::UID,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun buy_donut<T0>(arg0: &mut DonutShop, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg1) >= arg0.price, 0);
        arg0.price = arg0.price + 5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg0.price, arg2), @0x3d3f9909d036722a12753a660a84d2b75ef8a3e77fa887d02d87788271caa828);
        let v0 = Donut{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<Donut>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun buy_donut_x2<T0>(arg0: &mut DonutShop, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        buy_donut<T0>(arg0, arg1, arg2);
        buy_donut<T0>(arg0, arg1, arg2);
    }

    public entry fun collect_profits(arg0: &ShopOwnerCap, arg1: &mut DonutShop, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x3d3f9909d036722a12753a660a84d2b75ef8a3e77fa887d02d87788271caa828 != 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun eat_donut(arg0: Donut) {
        let Donut { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShopOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ShopOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DonutShop{
            id      : 0x2::object::new(arg0),
            price   : 5000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<DonutShop>(v1);
    }

    // decompiled from Move bytecode v6
}

