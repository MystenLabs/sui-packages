module 0xd35eea0d63b5df3f34b3e296e90f680449d88e0b704285e2cf55393eabab5609::escrow {
    struct Order<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        maker: address,
        escrowed_balance: 0x2::balance::Balance<T0>,
        amount_wanted: u64,
        is_active: bool,
    }

    struct OrderCap has store, key {
        id: 0x2::object::UID,
        order_id: 0x2::object::ID,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        maker: address,
        amount_offer: u64,
        amount_wanted: u64,
    }

    struct OrderExecuted has copy, drop {
        order_id: 0x2::object::ID,
        taker: address,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
    }

    public entry fun cancel_order<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &OrderCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        assert!(arg1.order_id == 0x2::object::uid_to_inner(&arg0.id), 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.maker, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrowed_balance, 0x2::balance::value<T0>(&arg0.escrowed_balance), arg2), v0);
        arg0.is_active = false;
        let v1 = OrderCancelled{order_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<OrderCancelled>(v1);
    }

    public entry fun create_order<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = Order<T0, T1>{
            id               : v1,
            maker            : v0,
            escrowed_balance : 0x2::coin::into_balance<T0>(arg0),
            amount_wanted    : arg1,
            is_active        : true,
        };
        let v4 = OrderCap{
            id       : 0x2::object::new(arg2),
            order_id : v2,
        };
        let v5 = OrderCreated{
            order_id      : v2,
            maker         : v0,
            amount_offer  : 0x2::coin::value<T0>(&arg0),
            amount_wanted : arg1,
        };
        0x2::event::emit<OrderCreated>(v5);
        0x2::transfer::share_object<Order<T0, T1>>(v3);
        0x2::transfer::transfer<OrderCap>(v4, v0);
    }

    public entry fun delete_order<T0, T1>(arg0: Order<T0, T1>, arg1: OrderCap) {
        assert!(!arg0.is_active, 0);
        let Order {
            id               : v0,
            maker            : _,
            escrowed_balance : v2,
            amount_wanted    : _,
            is_active        : _,
        } = arg0;
        let v5 = v2;
        assert!(0x2::balance::value<T0>(&v5) == 0, 2);
        0x2::balance::destroy_zero<T0>(v5);
        0x2::object::delete(v0);
        let OrderCap {
            id       : v6,
            order_id : _,
        } = arg1;
        0x2::object::delete(v6);
    }

    public entry fun execute_order<T0, T1>(arg0: &mut Order<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        assert!(0x2::coin::value<T1>(&arg1) >= arg0.amount_wanted, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrowed_balance, 0x2::balance::value<T0>(&arg0.escrowed_balance), arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg0.maker);
        arg0.is_active = false;
        let v1 = OrderExecuted{
            order_id : 0x2::object::uid_to_inner(&arg0.id),
            taker    : v0,
        };
        0x2::event::emit<OrderExecuted>(v1);
    }

    public fun get_order_info<T0, T1>(arg0: &Order<T0, T1>) : (address, u64, u64, bool) {
        (arg0.maker, 0x2::balance::value<T0>(&arg0.escrowed_balance), arg0.amount_wanted, arg0.is_active)
    }

    // decompiled from Move bytecode v6
}

