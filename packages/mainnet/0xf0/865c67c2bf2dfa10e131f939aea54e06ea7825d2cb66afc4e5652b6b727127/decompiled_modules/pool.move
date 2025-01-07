module 0xf0865c67c2bf2dfa10e131f939aea54e06ea7825d2cb66afc4e5652b6b727127::pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    struct FlashLoanEvent<phantom T0> has copy, drop {
        loan_amount: u64,
        repay_amount: u64,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000000000);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun access_list_add_vec(arg0: &mut AccessList, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914, 10000000000);
        0x1::vector::append<address>(&mut arg0.list, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_access_list(arg0);
    }

    fun is_valid(arg0: &mut AccessList, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg0.list;
        let v1 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun loan<T0>(arg0: &mut AccessList, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, arg3), 10000000002);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::singleton<address>(@0xaecdaa08f1b9f4469aa3abe357a0ec105152a9b72129245a2e3277c98e4f3914),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun new_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun repay<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 10000000001);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v1 = FlashLoanEvent<T0>{
            loan_amount  : arg2,
            repay_amount : v0,
        };
        0x2::event::emit<FlashLoanEvent<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

