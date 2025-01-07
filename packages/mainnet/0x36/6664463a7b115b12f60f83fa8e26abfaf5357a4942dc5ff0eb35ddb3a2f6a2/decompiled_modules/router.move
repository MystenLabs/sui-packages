module 0x366664463a7b115b12f60f83fa8e26abfaf5357a4942dc5ff0eb35ddb3a2f6a2::router {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Shop<phantom T0> has key {
        id: 0x2::object::UID,
        address_table: 0x2::table::Table<address, u8>,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun add_address<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, u8>(&arg1.address_table, v1)) {
                0x2::table::add<address, u8>(&mut arg1.address_table, v1, 1);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun create_shop<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop<T0>{
            id            : 0x2::object::new(arg1),
            address_table : 0x2::table::new<address, u8>(arg1),
            balance       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Shop<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 1);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
    }

    public entry fun deposit2<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg2)) {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2)));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a2b<T0, T1, T2>(arg0: &mut Shop<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u128, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u8>(&arg0.address_table, 0x2::tx_context::sender(arg9)), 2);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::take<T0>(&mut arg0.balance, arg2, arg9));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg1, v0, arg2, arg3, arg4, true, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun swap_b2a<T0, T1, T2>(arg0: &mut Shop<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u128, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u8>(&arg0.address_table, 0x2::tx_context::sender(arg9)), 2);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::take<T1>(&mut arg0.balance, arg2, arg9));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg1, v0, arg2, arg3, arg4, true, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun withdraw<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

