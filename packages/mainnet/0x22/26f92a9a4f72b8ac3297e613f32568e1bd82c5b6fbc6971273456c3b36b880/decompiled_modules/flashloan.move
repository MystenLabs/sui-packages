module 0x2226f92a9a4f72b8ac3297e613f32568e1bd82c5b6fbc6971273456c3b36b880::flashloan {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    struct FlashLoanEvent<phantom T0> has copy, drop {
        token: 0x1::type_name::TypeName,
        borrower: address,
        loan_amount: u64,
        repay_amount: u64,
    }

    public fun access_list_add(arg0: &mut AccessList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2, 1);
        0x1::vector::push_back<address>(&mut arg0.list, arg1);
    }

    public fun access_list_add_vec(arg0: &mut AccessList, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2, 1);
        0x1::vector::append<address>(&mut arg0.list, arg1);
    }

    fun is_valid(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x1::vector::contains<address>(&arg0.list, &v0)
    }

    public fun loan<T0>(arg0: &AccessList, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(is_valid(arg0, arg3), 3);
        0x2::balance::split<T0>(&mut arg1.balance, arg2)
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2, 1);
        let v0 = AccessList{
            id   : 0x2::object::new(arg0),
            list : 0x1::vector::singleton<address>(@0x90d5b42385c3f764fdf83ccc77c4b5379b65eb343b50f652cd2f4ec22b2ad5a2),
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

    public fun repay<T0>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::tx_context::sender(arg3);
        if (v0 > arg2) {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(&mut arg1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg3), v1);
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, arg1);
        };
        let v2 = FlashLoanEvent<T0>{
            token        : 0x1::type_name::with_defining_ids<T0>(),
            borrower     : v1,
            loan_amount  : arg2,
            repay_amount : v0,
        };
        0x2::event::emit<FlashLoanEvent<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

