module 0x90a3c9dfde7b36a761dbf1a7630c4a3eb5c32d925a40d1363fcd776fbe044054::autolife_robotics_swap {
    struct Tick has copy, drop, store {
        lower: u128,
        upper: u128,
    }

    struct Position<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        tick: Tick,
        liquidity: u128,
    }

    struct BeforeSwapEvent has copy, drop, store {
        pool_address: address,
        token_in: u64,
        token_out: u64,
    }

    struct AfterSwapEvent has copy, drop, store {
        pool_address: address,
        token_in: u64,
        token_out: u64,
    }

    struct FlashLoanState has copy, drop, store {
        token_a_owed: u64,
        token_b_owed: u64,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        token_a: 0x2::balance::Balance<T0>,
        token_b: 0x2::balance::Balance<T1>,
        fee_percent: u64,
        total_liquidity: u128,
        flash_loan_state: 0x1::option::Option<FlashLoanState>,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg4 > 0, 0);
        assert!((arg3 as u128) < 18446744073709551615 && (arg4 as u128) < 18446744073709551615, 4);
        0x2::balance::join<T0>(&mut arg0.token_a, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg3));
        0x2::balance::join<T1>(&mut arg0.token_b, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg2), arg4));
        let v0 = calculate_liquidity((arg3 as u128), (arg4 as u128));
        arg0.total_liquidity = arg0.total_liquidity + v0;
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = Tick{
            lower : arg5,
            upper : arg6,
        };
        let v3 = mint_position<T0, T1>(v1, v2, v0, arg7);
        0x2::transfer::public_transfer<Position<T0, T1>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun add_liquidity_to_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Position<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg1.owner == v0, 7);
        assert!(arg4 > 0 && arg5 > 0, 0);
        assert!((arg4 as u128) < 18446744073709551615 && (arg5 as u128) < 18446744073709551615, 4);
        0x2::balance::join<T0>(&mut arg0.token_a, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4));
        0x2::balance::join<T1>(&mut arg0.token_b, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg3), arg5));
        let v1 = calculate_liquidity((arg4 as u128), (arg5 as u128));
        arg1.liquidity = arg1.liquidity + v1;
        arg0.total_liquidity = arg0.total_liquidity + v1;
        0x2::transfer::public_transfer<Position<T0, T1>>(arg1, v0);
    }

    fun binary_search_sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    fun burn_position<T0, T1>(arg0: Position<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let Position {
            id        : v0,
            owner     : _,
            tick      : _,
            liquidity : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun calculate_a_to_b_output(arg0: u128, arg1: u128, arg2: u128) : u64 {
        ((arg2 * (arg1 + arg0 * 79228162514264337593543950336 / arg2 - arg1) / 79228162514264337593543950336) as u64)
    }

    fun calculate_b_to_a_output(arg0: u128, arg1: u128, arg2: u128) : u64 {
        ((arg2 * (arg1 + arg0 * 79228162514264337593543950336 / arg2 - arg1) / 79228162514264337593543950336) as u64)
    }

    public fun calculate_liquidity(arg0: u128, arg1: u128) : u128 {
        let v0 = binary_search_sqrt(arg0 * arg1);
        if (v0 == 0 && (arg0 > 0 || arg1 > 0)) {
            1
        } else {
            v0
        }
    }

    fun calculate_sqrt_price(arg0: u64, arg1: u64) : u128 {
        let v0 = (arg1 as u256) * (79228162514264337593543950336 as u256) / (arg0 as u256);
        print_string(b"Price:");
        0x1::debug::print<u256>(&v0);
        binary_search_sqrt((v0 as u128))
    }

    fun calculate_swap_output<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        let v3 = arg0.total_liquidity;
        if (v3 == 0) {
            return 0
        };
        if (arg2) {
            calculate_a_to_b_output((arg1 as u128) - (arg1 as u128) * (arg0.fee_percent as u128) / 10000, calculate_sqrt_price(v0, v1), v3)
        } else {
            calculate_b_to_a_output((arg1 as u128) - (arg1 as u128) * (arg0.fee_percent as u128) / 10000, calculate_sqrt_price(v0, v1), v3)
        }
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id               : 0x2::object::new(arg0),
            token_a          : 0x2::balance::zero<T0>(),
            token_b          : 0x2::balance::zero<T1>(),
            fee_percent      : (30 as u64),
            total_liquidity  : 0,
            flash_loan_state : 0x1::option::none<FlashLoanState>(),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public entry fun flash_loan<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLoanState{
            token_a_owed : arg1,
            token_b_owed : arg2,
        };
        0x1::option::fill<FlashLoanState>(&mut arg0.flash_loan_state, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_a, arg1, arg4), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token_b, arg2, arg4), arg3);
        let v1 = 0x2::balance::value<T1>(&arg0.token_b) + arg2;
        assert!(0x2::balance::value<T0>(&arg0.token_a) >= 0x2::balance::value<T0>(&arg0.token_a) + arg1, 6);
        assert!(0x2::balance::value<T1>(&arg0.token_b) >= v1, 6);
        0x1::option::extract<FlashLoanState>(&mut arg0.flash_loan_state);
        assert!(0x2::balance::value<T1>(&arg0.token_b) >= v1, 6);
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u128) {
        (0x2::balance::value<T0>(&arg0.token_a), 0x2::balance::value<T1>(&arg0.token_b), arg0.total_liquidity)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun mint_position<T0, T1>(arg0: address, arg1: Tick, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : Position<T0, T1> {
        Position<T0, T1>{
            id        : 0x2::object::new(arg3),
            owner     : arg0,
            tick      : arg1,
            liquidity : arg2,
        }
    }

    fun print_string(arg0: vector<u8>) {
        let v0 = 0x1::string::utf8(arg0);
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Position<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.owner == v0, 7);
        let v1 = arg1.liquidity;
        let (v2, v3) = remove_liquidity_inner<T0, T1>(arg0, v1, arg2);
        arg0.total_liquidity = arg0.total_liquidity - v1;
        burn_position<T0, T1>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    fun remove_liquidity_inner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = get_amounts<T0, T1>(arg0);
        (0x2::coin::take<T0>(&mut arg0.token_a, (((v0 as u128) * arg1 / v2) as u64), arg2), 0x2::coin::take<T1>(&mut arg0.token_b, (((v1 as u128) * arg1 / v2) as u64), arg2))
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 8);
        0x2::balance::join<T0>(&mut arg0.token_a, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg2));
        let v0 = calculate_swap_output<T0, T1>(arg0, arg2, true);
        let v1 = AfterSwapEvent{
            pool_address : 0x2::object::uid_to_address(&arg0.id),
            token_in     : arg2,
            token_out    : v0,
        };
        0x2::event::emit<AfterSwapEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token_b, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(arg1) >= arg2, 8);
        0x2::balance::join<T1>(&mut arg0.token_b, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg2));
        let v0 = calculate_swap_output<T0, T1>(arg0, arg2, false);
        let v1 = AfterSwapEvent{
            pool_address : 0x2::object::uid_to_address(&arg0.id),
            token_in     : arg2,
            token_out    : v0,
        };
        0x2::event::emit<AfterSwapEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_a, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

