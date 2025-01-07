module 0x785513237411decdd7c08be3c318b688e29760d9ce8ca5a312516b4a5987f0cf::bank {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    struct RepayEvent<phantom T0> has copy, drop {
        repaylimit_amount: u64,
        repay_amount: u64,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x30fba4730ab2647539644fff946392ef9d341616c38648815d5c8e0fc30ef7c5, 1);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 2);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v1 = RepayEvent<T0>{
            repaylimit_amount : arg2,
            repay_amount      : v0,
        };
        0x2::event::emit<RepayEvent<T0>>(v1);
    }

    fun is_valid(arg0: &mut AccessList, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg0.list;
        let v1 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x30fba4730ab2647539644fff946392ef9d341616c38648815d5c8e0fc30ef7c5, 1);
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::singleton<address>(@0x30fba4730ab2647539644fff946392ef9d341616c38648815d5c8e0fc30ef7c5),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun new_pool<T0>(arg0: &mut AccessList, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid(arg0, arg2), 1);
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun withdraw<T0>(arg0: &mut AccessList, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg3), 1);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

