module 0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::atomic_arbitrage_simple {
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

    struct DeepBookSwapCompleted has copy, drop {
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

    struct FlowXSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    struct SuiSwapSwapCompleted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        method: vector<u8>,
        timestamp: u64,
    }

    public fun calculate_cetus_output(arg0: u64) : u64 {
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_cetus::calculate_cetus_output(arg0)
    }

    public fun calculate_turbos_output(arg0: u64) : u64 {
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_turbos::calculate_turbos_output(arg0)
    }

    public fun get_cetus_config() : (address, address, u128) {
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_cetus::get_pool_config()
    }

    public fun get_cetus_packages() : (address, address) {
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_cetus::get_cetus_packages()
    }

    public fun get_supported_dexes() : vector<vector<u8>> {
        vector[b"cetus", b"turbos", b"kriya", b"aftermath", b"suiswap", b"bluefin", b"flowx"]
    }

    public fun get_turbos_config() : address {
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_turbos::get_pool_config()
    }

    public fun get_turbos_packages() : (address, address) {
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_turbos::get_turbos_packages()
    }

    public entry fun swap_sui_to_usdc_aftermath_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_aftermath::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
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
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_bluefin::swap_sui_to_usdc_gateway(arg2, arg0, arg1, arg3);
        let v1 = BlueFinSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"bluefin_simple",
            timestamp      : 0,
        };
        0x2::event::emit<BlueFinSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_cetus::swap_sui_to_usdc_cetus(arg2, arg0, arg1, arg3);
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
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_cetus::swap_sui_to_usdc_verified(arg0, arg1, arg2, arg3);
        let v1 = CetusSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"verified_entry",
            timestamp      : 0,
        };
        0x2::event::emit<CetusSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_flowx_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_flowx::swap_sui_to_usdc_factory(arg0, arg1, arg2, arg3);
        let v1 = FlowXSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"flowx_simple",
            timestamp      : 0,
        };
        0x2::event::emit<FlowXSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_kriya_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_kriya::swap_sui_to_usdc<0x2::sui::SUI, USDC>(0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::constants::kriya_sui_usdc_pool(), arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v1 = KriyaSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"kriya_simple",
            timestamp      : 0,
        };
        0x2::event::emit<KriyaSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_suiswap_exact_input(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_suiswap::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
        let v1 = SuiSwapSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"suiswap_exact_input",
            timestamp      : 0,
        };
        0x2::event::emit<SuiSwapSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_suiswap_router(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_suiswap::swap_sui_to_usdc_router(arg0, arg1, arg2, arg3);
        let v1 = SuiSwapSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"suiswap_router",
            timestamp      : 0,
        };
        0x2::event::emit<SuiSwapSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_suiswap_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_suiswap::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
        let v1 = SuiSwapSwapCompleted{
            sender         : 0x2::tx_context::sender(arg3),
            amount_in      : v0,
            min_amount_out : arg1,
            method         : b"suiswap_simple_primary",
            timestamp      : 0,
        };
        0x2::event::emit<SuiSwapSwapCompleted>(v1);
    }

    public entry fun swap_sui_to_usdc_turbos_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2001);
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_turbos::swap_sui_to_usdc_simple(arg0, arg1, arg2, arg3);
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
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_cetus::validate_swap_params(arg0, arg1)
    }

    public fun validate_turbos_params(arg0: u64, arg1: u64) : bool {
        0xa65c8188cf267aeb69420df4142e1d6774575c9ca440ffb2949e87521481dc5c::dex_turbos::validate_swap_params(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

