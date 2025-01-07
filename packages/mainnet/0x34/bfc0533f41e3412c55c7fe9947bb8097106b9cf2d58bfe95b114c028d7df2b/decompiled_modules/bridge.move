module 0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::bridge {
    struct MoverBridgePool has drop {
        dummy_field: bool,
    }

    struct BridgeAdminCap has key {
        id: 0x2::object::UID,
    }

    struct SwapInEvent<phantom T0> has copy, drop, store {
        amount: u64,
        from: 0x1::string::String,
        to: address,
        src_chain: u64,
        nonce: u128,
    }

    struct SwapOutEvent<phantom T0> has copy, drop, store {
        amount: u64,
        from: address,
        to: 0x1::string::String,
        dest_chain: u64,
        dest_coin: u64,
        nonce: u128,
    }

    struct RelayersHolder has key {
        id: 0x2::object::UID,
        relayers: 0x2::table::Table<address, bool>,
    }

    struct BridgeSettings<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        fee_perc: u128,
        swap_in_nonce: 0x2::table::Table<u128, bool>,
        supported_coins: 0x2::table::Table<address, u64>,
        nonce: u128,
        paused: bool,
    }

    public entry fun add_chain<T0>(arg0: &BridgeAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeSettings<T0>{
            id              : 0x2::object::new(arg1),
            version         : 1,
            fee_perc        : 130000,
            swap_in_nonce   : 0x2::table::new<u128, bool>(arg1),
            supported_coins : 0x2::table::new<address, u64>(arg1),
            nonce           : 0,
            paused          : false,
        };
        0x2::transfer::share_object<BridgeSettings<T0>>(v0);
    }

    public entry fun add_native_coin<T0>(arg0: &BridgeAdminCap, arg1: &0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::LpAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MoverBridgePool{dummy_field: false};
        0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::register<MoverBridgePool, T0>(v0, arg1, arg2);
    }

    public entry fun add_release_cap_to_relayer<T0>(arg0: &BridgeAdminCap, arg1: &0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::LpAdminCap, arg2: &mut RelayersHolder, arg3: address, arg4: &mut 0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::LiquidityPool<MoverBridgePool, T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_relayer(arg2, arg3), 10);
        0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::transfer_release_cap<MoverBridgePool, T0>(arg1, arg4, arg3, arg5);
    }

    public entry fun add_to_relayers_list(arg0: &BridgeAdminCap, arg1: &mut RelayersHolder, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.relayers;
        assert!(!0x2::table::contains<address, bool>(v0, arg2), 110);
        0x2::table::add<address, bool>(v0, arg2, true);
    }

    fun assert_dest_coin(arg0: u64) {
        assert!(arg0 == 0 || arg0 == 1, 170);
    }

    public entry fun enable_coin<T0, T1>(arg0: &BridgeAdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &mut BridgeSettings<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(arg1);
        assert!(!0x2::table::contains<address, u64>(&arg2.supported_coins, v0), 70);
        0x2::table::add<address, u64>(&mut arg2.supported_coins, v0, 1);
    }

    public fun get_coin_type<T0, T1>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &BridgeSettings<T1>) : u64 {
        let v0 = 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(arg0);
        assert!(0x2::table::contains<address, u64>(&arg1.supported_coins, v0), 60);
        *0x2::table::borrow<address, u64>(&arg1.supported_coins, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeAdminCap{id: 0x2::object::new(arg0)};
        let v1 = RelayersHolder{
            id       : 0x2::object::new(arg0),
            relayers : 0x2::table::new<address, bool>(arg0),
        };
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::Aptos>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::Arbitrum>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::BNB>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::Polygon>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::Optimism>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::ZkPolygon>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::ZkSync>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::BobaETH>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::BobaBNB>(&v0, arg0);
        add_chain<0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::chains::Ethereum>(&v0, arg0);
        0x2::transfer::transfer<BridgeAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<RelayersHolder>(v1);
    }

    fun is_relayer(arg0: &RelayersHolder, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.relayers, arg1)
    }

    entry fun migrate<T0>(arg0: &BridgeAdminCap, arg1: &mut BridgeSettings<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 160);
        arg1.version = 1;
    }

    public entry fun pause_chain<T0>(arg0: &BridgeAdminCap, arg1: &mut BridgeSettings<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
    }

    public entry fun remove_coin<T0, T1>(arg0: &BridgeAdminCap, arg1: &mut BridgeSettings<T1>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<address, u64>(&mut arg1.supported_coins, 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(arg2));
    }

    public entry fun setFee<T0>(arg0: &BridgeAdminCap, arg1: &mut BridgeSettings<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_perc = arg2;
    }

    public entry fun swap_in_native<T0, T1>(arg0: u64, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: u128, arg5: &mut 0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::LiquidityPool<MoverBridgePool, T0>, arg6: &0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::ReleaseCap<MoverBridgePool, T0>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &RelayersHolder, arg9: &mut BridgeSettings<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg9.paused, 140);
        assert!(arg9.version == 1, 150);
        assert!(is_relayer(arg8, 0x2::tx_context::sender(arg10)), 10);
        assert!(!0x2::table::contains<u128, bool>(&arg9.swap_in_nonce, arg4), 40);
        assert!(get_coin_type<T0, T1>(arg7, arg9) == 1, 120);
        assert!(0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::reserves<MoverBridgePool, T0>(arg5) >= arg0, 80);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::release<MoverBridgePool, T0>(arg5, arg6, arg0, arg10), arg2);
        let v0 = SwapInEvent<T0>{
            amount    : arg0,
            from      : arg1,
            to        : arg2,
            src_chain : arg3,
            nonce     : arg4,
        };
        0x2::event::emit<SwapInEvent<T0>>(v0);
        0x2::table::add<u128, bool>(&mut arg9.swap_in_nonce, arg4, true);
    }

    public entry fun swap_out_native<T0, T1>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::LiquidityPool<MoverBridgePool, T0>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &mut BridgeSettings<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg7.paused, 140);
        assert!(arg7.version == 1, 150);
        assert_dest_coin(arg4);
        assert!(get_coin_type<T0, T1>(arg6, arg7) == 1, 120);
        0x34bfc0533f41e3412c55c7fe9947bb8097106b9cf2d58bfe95b114c028d7df2b::liquidity_pool::lock<MoverBridgePool, T0>(0x2::coin::split<T0>(arg0, arg1, arg8), arg5);
        let v0 = SwapOutEvent<T0>{
            amount     : arg1 - (((arg1 as u128) * arg7.fee_perc / 100000000) as u64),
            from       : 0x2::tx_context::sender(arg8),
            to         : arg2,
            dest_chain : arg3,
            dest_coin  : arg4,
            nonce      : arg7.nonce,
        };
        0x2::event::emit<SwapOutEvent<T0>>(v0);
        arg7.nonce = arg7.nonce + 1;
    }

    public entry fun unpause_chain<T0>(arg0: &BridgeAdminCap, arg1: &mut BridgeSettings<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = false;
    }

    // decompiled from Move bytecode v6
}

