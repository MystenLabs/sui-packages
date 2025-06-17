module 0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_deepbook {
    public fun calculate_deepbook_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9995 / 10000) as u64)
    }

    public fun calculate_deepbook_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9995 / 10000) as u64)
    }

    public fun get_deepbook_config() : (address, address, address) {
        (0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::constants::deepbook_package(), 0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::constants::deepbook_registry(), 0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::constants::deepbook_treasury())
    }

    public fun swap_sui_to_usdc<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3401);
        assert!(arg0 == 0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::constants::deepbook_sui_usdc_pool(), 3403);
        assert!(calculate_deepbook_output(v0) >= arg2, 3402);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::coin::zero<T1>(arg4)
    }

    public fun swap_usdc_to_sui<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3401);
        assert!(arg0 == 0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::constants::deepbook_sui_usdc_pool(), 3403);
        assert!(calculate_deepbook_usdc_to_sui_output(v0) >= arg2, 3402);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::coin::zero<T1>(arg4)
    }

    public fun validate_swap_params(arg0: u64, arg1: u64) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg0 >= 1000000
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

