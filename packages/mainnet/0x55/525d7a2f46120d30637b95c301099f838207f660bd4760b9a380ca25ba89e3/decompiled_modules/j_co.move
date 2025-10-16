module 0x55525d7a2f46120d30637b95c301099f838207f660bd4760b9a380ca25ba89e3::j_co {
    struct CB has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun get_out(arg0: &mut CB, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)), arg1), @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CB{
            id          : 0x2::object::new(arg0),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CB>(v0);
    }

    public entry fun j_swap_a2b<T0>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &mut CB, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2, 2);
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::momentum::swap_a2b<0x2::sui::SUI, T0>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg4.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg4.sui_balance)), arg5), arg2, arg3, arg5);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, @0xd3e6dfba32fe366f67448d0e2d1a0f6b1e80834ef701dff5379206002972f4cb);
    }

    public entry fun to_in(arg0: &mut CB, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x73f3f297dbd2df9520a18484850d0a1fd690929b9af247e14b0db1cb48dd6eb2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    // decompiled from Move bytecode v6
}

