module 0x91eac008046afaf3b655b0265690767dbb4aa36aa1939bc6f3dfe4df9a68df38::router {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Shop<phantom T0> has key {
        id: 0x2::object::UID,
        address_table: 0x2::table::Table<address, u8>,
        balance: 0x2::balance::Balance<T0>,
    }

    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
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

    public entry fun swap_a2b<T0, T1>(arg0: &mut Shop<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u8>(&arg0.address_table, 0x2::tx_context::sender(arg8)), 2);
        let v0 = 0x2::coin::take<T0>(&mut arg0.balance, arg3, arg8);
        let v1 = 0x2::coin::zero<T1>(arg8);
        let (v2, v3) = swap<T0, T1>(arg1, arg2, v0, v1, true, arg3, arg4, arg5, arg7, arg8);
        let v4 = v3;
        assert!(0x2::coin::value<T1>(&v4) >= arg4, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, arg6);
    }

    public entry fun swap_b2a<T0, T1>(arg0: &mut Shop<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u8>(&arg0.address_table, 0x2::tx_context::sender(arg8)), 2);
        let v0 = 0x2::coin::zero<T0>(arg8);
        let v1 = 0x2::coin::take<T1>(&mut arg0.balance, arg3, arg8);
        let (v2, v3) = swap<T0, T1>(arg1, arg2, v0, v1, false, arg3, arg4, arg5, arg7, arg8);
        let v4 = v2;
        assert!(0x2::coin::value<T0>(&v4) >= arg4, 3);
        0x2::balance::join<T1>(&mut arg0.balance, 0x2::coin::into_balance<T1>(v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg6);
    }

    public entry fun withdraw<T0>(arg0: &OwnerCap, arg1: &mut Shop<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

