module 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::cB {
    struct AC {
        lv: 0x2::bag::Bag,
        lb: 0x1::string::String,
    }

    public fun eA<T0>(arg0: &mut AC, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.lv, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.lv, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.lv, v0, arg1);
        };
    }

    public fun fA<T0>(arg0: &0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : AC {
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::gJ(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 341);
        let v0 = 0x2::bag::new(arg3);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::into_balance<T0>(arg1));
        AC{
            lv : v0,
            lb : arg2,
        }
    }

    public fun fF<T0>(arg0: AC, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let AC {
            lv : v0,
            lb : _,
        } = arg0;
        let v2 = v0;
        assert!(0x2::bag::is_empty(&v2), 314);
        0x2::bag::destroy_empty(v2);
        0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    public fun fG<T0>(arg0: &mut AC, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.lv, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.lv, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.lv, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun gD<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun gH<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun gO<T0>(arg0: &mut AC) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.lv, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.lv, v0)
    }

    public fun iG<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2)
    }

    public fun ik<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, arg1, arg2);
    }

    public fun im<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, arg1, arg2);
    }

    public fun in<T0, T1>(arg0: &mut 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: bool, arg4: u64, arg5: AC, arg6: &mut 0x2::tx_context::TxContext) {
        let AC {
            lv : v0,
            lb : v1,
        } = arg5;
        let v2 = v0;
        if (arg3) {
            let v3 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2, 0x1::type_name::with_defining_ids<T0>());
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, arg4), arg6), arg2);
            assert!(0x2::bag::is_empty(&v2), 314);
            0x2::bag::destroy_empty(v2);
            0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::eA<T0>(arg0, v3, v1);
        } else {
            let v4 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v2, 0x1::type_name::with_defining_ids<T1>());
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg4), arg6), arg2);
            assert!(0x2::bag::is_empty(&v2), 314);
            0x2::bag::destroy_empty(v2);
            0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::eA<T1>(arg0, v4, v1);
        };
    }

    public fun iq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2)
    }

    public fun on<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::string::String, arg2: bool, arg3: u64, arg4: &0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::AP, arg5: &mut 0x2::tx_context::TxContext) : (AC, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB::gJ(arg4);
        let v0 = if (arg2) {
            0x1::type_name::with_defining_ids<T0>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        let v1 = 0x2::bag::new(arg5);
        let v2 = if (arg2) {
            let (v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg3, arg5);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1, v0, 0x2::coin::into_balance<T0>(v3));
            v4
        } else {
            let (v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg3, arg5);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1, v0, 0x2::coin::into_balance<T1>(v5));
            v6
        };
        let v7 = AC{
            lv : v1,
            lb : arg1,
        };
        (v7, v2)
    }

    public fun zx(arg0: &AC) : 0x1::string::String {
        arg0.lb
    }

    // decompiled from Move bytecode v6
}

