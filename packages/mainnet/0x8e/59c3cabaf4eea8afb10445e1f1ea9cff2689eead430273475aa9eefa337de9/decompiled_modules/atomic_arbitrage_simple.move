module 0x8e59c3cabaf4eea8afb10445e1f1ea9cff2689eead430273475aa9eefa337de9::atomic_arbitrage_simple {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct CetusSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    struct TurbosSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    struct KriyaSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    struct AftermathSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    struct BlueFinSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    public entry fun swap_sui_to_usdc_aftermath_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x8e59c3cabaf4eea8afb10445e1f1ea9cff2689eead430273475aa9eefa337de9::dex_aftermath::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
        let v1 = AftermathSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"aftermath_simple",
            timestamp      : 0,
        };
        0x2::event::emit<AftermathSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_bluefin_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x8e59c3cabaf4eea8afb10445e1f1ea9cff2689eead430273475aa9eefa337de9::dex_bluefin::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
        let v1 = BlueFinSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"bluefin_simple",
            timestamp      : 0,
        };
        0x2::event::emit<BlueFinSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_cetus_verified(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x8e59c3cabaf4eea8afb10445e1f1ea9cff2689eead430273475aa9eefa337de9::dex_cetus::swap_sui_to_usdc_cetus(arg2, arg0, arg1, arg3);
        let v1 = CetusSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"cetus_verified",
            timestamp      : 0,
        };
        0x2::event::emit<CetusSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_kriya_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x8e59c3cabaf4eea8afb10445e1f1ea9cff2689eead430273475aa9eefa337de9::dex_kriya::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
        let v1 = KriyaSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"kriya_simple",
            timestamp      : 0,
        };
        0x2::event::emit<KriyaSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_turbos_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x8e59c3cabaf4eea8afb10445e1f1ea9cff2689eead430273475aa9eefa337de9::dex_turbos::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
        let v1 = TurbosSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"turbos_simple",
            timestamp      : 0,
        };
        0x2::event::emit<TurbosSwapCompleted>(v1);
    }

    // decompiled from Move bytecode v6
}

