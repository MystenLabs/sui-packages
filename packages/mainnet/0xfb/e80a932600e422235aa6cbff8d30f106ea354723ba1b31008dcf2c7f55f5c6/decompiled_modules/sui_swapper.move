module 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::sui_swapper {
    struct SwapperConfig has key {
        id: 0x2::object::UID,
        admin: address,
        fund_op: address,
        cex: address,
        swap_op: address,
        is_paused: bool,
        total_volume: u64,
    }

    struct CoinVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct ConfigUpdateEvent has copy, drop {
        fund_op: address,
        cex: address,
        swap_op: address,
    }

    struct PauseEvent has copy, drop {
        is_paused: bool,
        admin: address,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        operator: address,
    }

    struct BluefinSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        dex_type: 0x1::string::String,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        operator: address,
    }

    public entry fun bluefin_flash_swap_a2b<T0, T1>(arg0: &SwapperConfig, arg1: &mut 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>, arg2: &mut CoinVault<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.swap_op, 5);
        let (v0, v1, v2) = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::flash_swap<T0, T1>(arg5, arg1, true, false, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_flash_swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T0>(&arg2.balance) >= v4, 2);
        let v5 = CoinVault<T1>{
            id      : 0x2::object::new(arg6),
            balance : v1,
        };
        0x2::transfer::share_object<CoinVault<T1>>(v5);
        0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::repay_flash_swap<T0, T1>(arg1, 0x2::balance::split<T0>(&mut arg2.balance, v4), 0x2::balance::zero<T1>(), v3, arg6);
        0x2::balance::destroy_zero<T0>(v0);
        let v6 = BluefinSwapEvent{
            pool_id           : 0x2::object::id<0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>>(arg1),
            dex_type          : 0x1::string::utf8(b"Bluefin Flash"),
            a2b               : true,
            amount_in         : v4,
            amount_out        : arg3,
            fee_amount        : 0,
            sqrt_price_before : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            sqrt_price_after  : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            operator          : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<BluefinSwapEvent>(v6);
    }

    public entry fun bluefin_flash_swap_b2a<T0, T1>(arg0: &SwapperConfig, arg1: &mut 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>, arg2: &mut CoinVault<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.swap_op, 5);
        let (v0, v1, v2) = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::flash_swap<T0, T1>(arg5, arg1, false, false, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_flash_swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T1>(&arg2.balance) >= v4, 2);
        let v5 = CoinVault<T0>{
            id      : 0x2::object::new(arg6),
            balance : v0,
        };
        0x2::transfer::share_object<CoinVault<T0>>(v5);
        0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::repay_flash_swap<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2.balance, v4), v3, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        let v6 = BluefinSwapEvent{
            pool_id           : 0x2::object::id<0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>>(arg1),
            dex_type          : 0x1::string::utf8(b"Bluefin Flash"),
            a2b               : false,
            amount_in         : v4,
            amount_out        : arg3,
            fee_amount        : 0,
            sqrt_price_before : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            sqrt_price_after  : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            operator          : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<BluefinSwapEvent>(v6);
    }

    public entry fun bluefin_swap_exact_input<T0, T1>(arg0: &mut SwapperConfig, arg1: &mut 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>, arg2: &mut CoinVault<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 6);
        assert!(0x2::tx_context::sender(arg7) == arg0.swap_op, 5);
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg2.balance) >= arg3, 2);
        arg0.total_volume = arg0.total_volume + arg3;
        let v0 = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::calculate_swap_results<T0, T1>(arg1, true, true, arg3, arg5);
        assert!(0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::swap_result_amount_calculated(&v0) >= arg4, 4);
        let (v1, v2) = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::swap<T0, T1>(arg6, arg1, 0x2::balance::split<T0>(&mut arg2.balance, arg3), 0x2::balance::zero<T1>(), true, true, arg3, arg4, arg5, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = CoinVault<T1>{
            id      : 0x2::object::new(arg7),
            balance : v3,
        };
        0x2::transfer::share_object<CoinVault<T1>>(v4);
        let v5 = BluefinSwapEvent{
            pool_id           : 0x2::object::id<0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>>(arg1),
            dex_type          : 0x1::string::utf8(b"Bluefin"),
            a2b               : true,
            amount_in         : arg3,
            amount_out        : 0x2::balance::value<T1>(&v3),
            fee_amount        : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::swap_result_fee_amount(&v0),
            sqrt_price_before : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            sqrt_price_after  : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            operator          : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<BluefinSwapEvent>(v5);
    }

    public entry fun bluefin_swap_exact_input_reverse<T0, T1>(arg0: &SwapperConfig, arg1: &mut 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>, arg2: &mut CoinVault<T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.swap_op, 5);
        assert!(arg3 > 0, 3);
        assert!(0x2::balance::value<T1>(&arg2.balance) >= arg3, 2);
        let v0 = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::calculate_swap_results<T0, T1>(arg1, false, true, arg3, arg5);
        assert!(0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::swap_result_amount_calculated(&v0) >= arg4, 4);
        let (v1, v2) = 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::swap<T0, T1>(arg6, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2.balance, arg3), false, true, arg3, arg4, arg5, arg7);
        let v3 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        let v4 = CoinVault<T0>{
            id      : 0x2::object::new(arg7),
            balance : v3,
        };
        0x2::transfer::share_object<CoinVault<T0>>(v4);
        let v5 = BluefinSwapEvent{
            pool_id           : 0x2::object::id<0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>>(arg1),
            dex_type          : 0x1::string::utf8(b"Bluefin"),
            a2b               : false,
            amount_in         : arg3,
            amount_out        : 0x2::balance::value<T0>(&v3),
            fee_amount        : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::swap_result_fee_amount(&v0),
            sqrt_price_before : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            sqrt_price_after  : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::get_current_sqrt_price<T0, T1>(arg1),
            operator          : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<BluefinSwapEvent>(v5);
    }

    public fun calculate_bluefin_swap_result<T0, T1>(arg0: &0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualPool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::VirtualSwapResult {
        0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex::calculate_swap_results<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun deposit_coin<T0>(arg0: &SwapperConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<CoinVault<T0>>(v0);
        let v1 = DepositEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun get_config(arg0: &SwapperConfig) : (address, address, address, address) {
        (arg0.admin, arg0.fund_op, arg0.cex, arg0.swap_op)
    }

    public fun get_vault_balance<T0>(arg0: &CoinVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0);
    }

    fun init_internal(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SwapperConfig{
            id           : 0x2::object::new(arg0),
            admin        : v0,
            fund_op      : v0,
            cex          : v0,
            swap_op      : v0,
            is_paused    : false,
            total_volume : 0,
        };
        let v2 = VaultRegistry{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<SwapperConfig>(v1);
        0x2::transfer::share_object<VaultRegistry>(v2);
    }

    public entry fun merge_coin<T0>(arg0: &mut CoinVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun pause_contract(arg0: &mut SwapperConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_paused = true;
        let v0 = PauseEvent{
            is_paused : true,
            admin     : arg0.admin,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun resume_contract(arg0: &mut SwapperConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.is_paused = false;
        let v0 = PauseEvent{
            is_paused : false,
            admin     : arg0.admin,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun update_config(arg0: &mut SwapperConfig, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        arg0.fund_op = arg1;
        arg0.cex = arg2;
        arg0.swap_op = arg3;
        let v0 = ConfigUpdateEvent{
            fund_op : arg1,
            cex     : arg2,
            swap_op : arg3,
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    public entry fun withdraw_coin<T0>(arg0: &SwapperConfig, arg1: &mut CoinVault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.fund_op, 1);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), arg0.cex);
        let v0 = WithdrawEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg2,
            recipient : arg0.cex,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

