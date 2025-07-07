module 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::mmt_v3_adapter {
    fun swap<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        if (arg3) {
            0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v1, arg9));
            0x2::balance::destroy_zero<T0>(v0);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg9)), 0x2::balance::zero<T1>(), arg8, arg9);
        } else {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg9));
            0x2::balance::destroy_zero<T1>(v1);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg9)), arg8, arg9);
        };
        (arg1, arg2)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, v0, true, true, arg2, 4295048016, arg4, arg3, arg5);
        0x2::coin::destroy_zero<T0>(v1);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, v0, arg1, false, true, arg2, 79226673515401279992447579054, arg4, arg3, arg5);
        0x2::coin::destroy_zero<T1>(v2);
        v1
    }

    public fun swap_router<T0, T1>(arg0: &mut 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::RouterAcl, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::access(arg3);
        let v1 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, u8, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::borrow_data<vector<u8>, u8, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::bag_value::unwrap(0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<u8, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::bag_value::Value, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1) == v2, 0);
        if (v3) {
            let v4 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, b"funds");
            0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, b"funds", swap_a2b<T0, T1>(arg1, v4, 0x2::coin::value<T0>(&v4), arg2, arg4, arg5));
        } else {
            let v5 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, b"funds");
            0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, b"funds", swap_b2a<T0, T1>(arg1, v5, 0x2::coin::value<T1>(&v5), arg2, arg4, arg5));
        };
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, u8, 0x824de83c98bb219e24fdaf1f7c9964e4c01122d083dbd471bb983184d5a1f7b3::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

