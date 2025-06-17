module 0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::atomic_arbitrage_simple {
    struct CetusSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    public fun calculate_cetus_output(arg0: u64) : u64 {
        0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_cetus::calculate_cetus_output(arg0)
    }

    public fun get_cetus_config() : (address, address, u128) {
        0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_cetus::get_pool_config()
    }

    public fun get_cetus_packages() : (address, address) {
        0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_cetus::get_cetus_packages()
    }

    public entry fun swap_sui_to_usdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_cetus::swap_sui_to_usdc_cetus(arg2, arg0, arg1, arg3);
        let v1 = CetusSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"cetus_entry",
            timestamp      : 0,
        };
        0x2::event::emit<CetusSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_cetus_verified(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_cetus::swap_sui_to_usdc_verified(arg0, arg1, arg2, arg3);
        let v1 = CetusSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"verified_entry",
            timestamp      : 0,
        };
        0x2::event::emit<CetusSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_turbos_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_turbos::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
        let v1 = CetusSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"turbos_simple",
            timestamp      : 0,
        };
        0x2::event::emit<CetusSwapCompleted>(v1);
    }

    public fun validate_swap_params(arg0: u64, arg1: u64) : bool {
        0x9f36289db0bb87105360ba8f820993bf7394fa909eebf67bce0095b20583ecad::dex_cetus::validate_swap_params(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

