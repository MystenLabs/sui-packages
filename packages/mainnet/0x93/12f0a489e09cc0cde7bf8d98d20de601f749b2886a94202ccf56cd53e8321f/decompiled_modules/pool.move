module 0x9312f0a489e09cc0cde7bf8d98d20de601f749b2886a94202ccf56cd53e8321f::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    struct RepayEvent<phantom T0> has copy, drop {
        loan_amount: u64,
        repay_amount: u64,
    }

    public fun access_list_add(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x1::vector::push_back<address>(&mut arg1.list, arg2);
    }

    public fun access_list_add_vec(arg0: &AdminCap, arg1: &mut AccessList, arg2: vector<address>) {
        0x1::vector::append<address>(&mut arg1.list, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::empty<address>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AccessList>(v1);
    }

    fun is_valid(arg0: &AccessList, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.list, &arg1)
    }

    public fun loan<T0>(arg0: &mut AccessList, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid(arg0, 0x2::tx_context::sender(arg3)), 10000);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    public fun new_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun repay<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 10001);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v1 = RepayEvent<T0>{
            loan_amount  : arg2,
            repay_amount : v0,
        };
        0x2::event::emit<RepayEvent<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

