module 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::atomic_arbitrage {
    public entry fun arb_aftermath_cetus_wusdc<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::constants::sui_input_amount();
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 1);
        let v2 = 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::coin_helpers::split_coin<0x2::sui::SUI>(&mut arg0, v0, arg3);
        assert!(0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_aftermath::validate_swap_params<0x2::sui::SUI, T0>(&v2, arg1, 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_aftermath::calculate_minimum_output(v0, 50)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_cetus::swap_wusdc_to_sui<T0>(0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_aftermath::swap_sui_to_wusdc<T0>(v2, arg1, arg3), arg2, arg3), v1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    public entry fun arb_cetus_aftermath_wusdc<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_single_intermediate_token<T0>();
        let v0 = 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::constants::sui_input_amount();
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 1);
        let v2 = 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::coin_helpers::split_coin<0x2::sui::SUI>(&mut arg0, v0, arg3);
        assert!(0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_cetus::validate_swap_params<0x2::sui::SUI, T0>(&v2, arg1, 0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_cetus::calculate_minimum_output(v0, 100)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_aftermath::swap_wusdc_to_sui<T0>(0xe7872fc789b4b970b01e7c64ab75dd5adeeff8197c3b89bb9adbef8c9343f187::dex_cetus::swap_sui_to_wusdc<T0>(v2, arg1, arg3), arg2, arg3), v1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    fun validate_single_intermediate_token<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN", 2);
    }

    // decompiled from Move bytecode v6
}

