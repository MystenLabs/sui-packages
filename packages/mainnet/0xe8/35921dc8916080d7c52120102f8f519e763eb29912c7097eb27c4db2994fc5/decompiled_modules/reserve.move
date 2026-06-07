module 0xe835921dc8916080d7c52120102f8f519e763eb29912c7097eb27c4db2994fc5::reserve {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        admin: address,
        list: vector<address>,
    }

    public fun balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun access_list_add_vec(arg0: &mut AccessList, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x1::vector::append<address>(&mut arg0.list, arg1);
    }

    public fun fund<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    fun is_valid(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.list, &v0)
    }

    public fun loan<T0>(arg0: &AccessList, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg3), 2);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = AccessList{
            id    : 0x2::object::new(arg0),
            admin : v0,
            list  : v1,
        };
        0x2::transfer::share_object<AccessList>(v2);
    }

    public fun new_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun repay<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 3);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public fun withdraw<T0>(arg0: &AccessList, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

