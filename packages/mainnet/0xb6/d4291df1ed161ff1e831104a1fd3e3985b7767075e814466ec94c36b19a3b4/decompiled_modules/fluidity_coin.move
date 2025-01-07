module 0xb6d4291df1ed161ff1e831104a1fd3e3985b7767075e814466ec94c36b19a3b4::fluidity_coin {
    struct Global has key {
        id: 0x2::object::UID,
        paused: bool,
        vaults_initialized: bool,
    }

    struct CoinReserve has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<FLUIDITY_COIN>,
    }

    struct UserVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct PrizePoolVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct FLUIDITY_COIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WorkerCap has key {
        id: 0x2::object::UID,
    }

    struct EmergencyCap has key {
        id: 0x2::object::UID,
    }

    struct DAOCap has key {
        id: 0x2::object::UID,
    }

    struct WrapEvent has copy, drop {
        user_vault_id: 0x2::object::ID,
        coin_reserve_id: 0x2::object::ID,
        global_id: 0x2::object::ID,
        underlying_coin_id: 0x2::object::ID,
        user_address: address,
        underlying_amount: u64,
        s_coin_amount: u64,
        f_coin_amount: u64,
        time: u64,
    }

    struct UnwrapEvent has copy, drop {
        user_vault_id: 0x2::object::ID,
        prize_pool_vault_id: 0x2::object::ID,
        coin_reserve_id: 0x2::object::ID,
        global_id: 0x2::object::ID,
        f_coin_id: 0x2::object::ID,
        user_address: address,
        f_coin_amount: u64,
        prize_pool_vault_amount: u64,
        underlying_amount: u64,
        time: u64,
    }

    struct InitEvent has copy, drop {
        global_id: 0x2::object::ID,
    }

    struct InitVaultEvent has copy, drop {
        user_vault_id: 0x2::object::ID,
        prize_pool_vault_id: 0x2::object::ID,
        coin_reserve_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop {
        coin_reserve_id: 0x2::object::ID,
        amount_minted: u64,
        caller: address,
    }

    struct BurnEvent has copy, drop {
        coin_reserve_id: 0x2::object::ID,
        amount_burned: u64,
        caller: address,
    }

    struct PauseEvent has copy, drop {
        global_id: 0x2::object::ID,
        caller: address,
    }

    struct UnpauseEvent has copy, drop {
        global_id: 0x2::object::ID,
        caller: address,
    }

    struct DistributeYieldEvent has copy, drop {
        prize_pool_vault_id: 0x2::object::ID,
        amount_distributed: u64,
        recipient: address,
    }

    struct EmergencyDrainEvent has copy, drop {
        prize_pool_vault_id: 0x2::object::ID,
        amount_drained: u64,
        recipient: address,
        time: u64,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLUIDITY_COIN>, arg1: &AdminCap, arg2: &Global, arg3: &mut CoinReserve, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.vaults_initialized, 5);
        assert!(0x2::balance::value<FLUIDITY_COIN>(&arg3.balance) >= arg4, 4);
        0x2::coin::burn<FLUIDITY_COIN>(arg0, 0x2::coin::from_balance<FLUIDITY_COIN>(0x2::balance::split<FLUIDITY_COIN>(&mut arg3.balance, arg4), arg5));
        let v0 = BurnEvent{
            coin_reserve_id : 0x2::object::uid_to_inner(&arg3.id),
            amount_burned   : arg4,
            caller          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLUIDITY_COIN>, arg1: &AdminCap, arg2: &Global, arg3: &mut CoinReserve, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.vaults_initialized, 5);
        0x2::balance::join<FLUIDITY_COIN>(&mut arg3.balance, 0x2::coin::into_balance<FLUIDITY_COIN>(0x2::coin::mint<FLUIDITY_COIN>(arg0, arg4, arg5)));
        let v0 = MintEvent{
            coin_reserve_id : 0x2::object::uid_to_inner(&arg3.id),
            amount_minted   : arg4,
            caller          : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun assert_scallop_market(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg0) == @0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9, 6);
    }

    fun assert_scallop_version(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version) {
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg0) == @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f6ac7, 7);
    }

    entry fun distribute_yield<T0>(arg0: &WorkerCap, arg1: &mut PrizePoolVault<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: vector<address>, arg6: vector<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_scallop_market(arg3);
        assert_scallop_version(arg2);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6), 8);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance), arg7), arg4, arg7);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg5)) {
            let v2 = 0x1::vector::borrow<address>(&arg5, v1);
            let v3 = 0x1::vector::borrow<u64>(&arg6, v1);
            assert!(*v3 <= 0x2::coin::value<T0>(&v0), 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, *v3, arg7), *v2);
            let v4 = DistributeYieldEvent{
                prize_pool_vault_id : 0x2::object::uid_to_inner(&arg1.id),
                amount_distributed  : *v3,
                recipient           : *v2,
            };
            0x2::event::emit<DistributeYieldEvent>(v4);
        };
        if (0x2::coin::value<T0>(&v0) != 0) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, v0, arg4, arg7)));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    entry fun emergency_drain_prize_pool_vault<T0>(arg0: &DAOCap, arg1: &mut PrizePoolVault<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1.balance) != 0, 4);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance), arg5), arg4, arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = EmergencyDrainEvent{
            prize_pool_vault_id : 0x2::object::uid_to_inner(&arg1.id),
            amount_drained      : 0x2::coin::value<T0>(&v0),
            recipient           : v1,
            time                : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<EmergencyDrainEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v1);
    }

    fun init(arg0: FLUIDITY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUIDITY_COIN>(arg0, 6, b"Fluid USDC", b"fUSDC", b"Fluid USDC is a wrapped asset that earns you yield per transaction. https://app.fluidity.money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/nvqvx1OGtfR4bqI7mg3MfPmubnxDoWReLgCML2DO_9c")), arg1);
        let v2 = Global{
            id                 : 0x2::object::new(arg1),
            paused             : false,
            vaults_initialized : false,
        };
        let v3 = InitEvent{global_id: 0x2::object::uid_to_inner(&v2.id)};
        0x2::event::emit<InitEvent>(v3);
        0x2::transfer::share_object<Global>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUIDITY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUIDITY_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = WorkerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WorkerCap>(v5, 0x2::tx_context::sender(arg1));
        let v6 = EmergencyCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<EmergencyCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = DAOCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DAOCap>(v7, 0x2::tx_context::sender(arg1));
    }

    entry fun initialize<T0>(arg0: &AdminCap, arg1: &mut Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.vaults_initialized, 0);
        let v0 = UserVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        let v1 = PrizePoolVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        let v2 = CoinReserve{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<FLUIDITY_COIN>(),
        };
        let v3 = InitVaultEvent{
            user_vault_id       : 0x2::object::uid_to_inner(&v0.id),
            prize_pool_vault_id : 0x2::object::uid_to_inner(&v1.id),
            coin_reserve_id     : 0x2::object::uid_to_inner(&v2.id),
        };
        0x2::event::emit<InitVaultEvent>(v3);
        0x2::transfer::share_object<UserVault<T0>>(v0);
        0x2::transfer::share_object<PrizePoolVault<T0>>(v1);
        0x2::transfer::share_object<CoinReserve>(v2);
        arg1.vaults_initialized = true;
    }

    fun pause(arg0: &mut Global, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        arg0.paused = true;
        let v0 = PauseEvent{
            global_id : 0x2::object::uid_to_inner(&arg0.id),
            caller    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    entry fun pause_admin(arg0: &AdminCap, arg1: &mut Global, arg2: &0x2::tx_context::TxContext) {
        pause(arg1, arg2);
    }

    entry fun pause_dao(arg0: &DAOCap, arg1: &mut Global, arg2: &0x2::tx_context::TxContext) {
        pause(arg1, arg2);
    }

    entry fun pause_emergency(arg0: &EmergencyCap, arg1: &mut Global, arg2: &0x2::tx_context::TxContext) {
        pause(arg1, arg2);
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun transfer_dao_cap(arg0: &AdminCap, arg1: DAOCap, arg2: address) {
        0x2::transfer::transfer<DAOCap>(arg1, arg2);
    }

    entry fun transfer_emergency_cap(arg0: &AdminCap, arg1: EmergencyCap, arg2: address) {
        0x2::transfer::transfer<EmergencyCap>(arg1, arg2);
    }

    entry fun transfer_worker_cap(arg0: &AdminCap, arg1: WorkerCap, arg2: address) {
        0x2::transfer::transfer<WorkerCap>(arg1, arg2);
    }

    fun unpause(arg0: &mut Global, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.paused, 3);
        arg0.paused = false;
        let v0 = UnpauseEvent{
            global_id : 0x2::object::uid_to_inner(&arg0.id),
            caller    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<UnpauseEvent>(v0);
    }

    entry fun unpause_admin(arg0: &AdminCap, arg1: &mut Global, arg2: &0x2::tx_context::TxContext) {
        unpause(arg1, arg2);
    }

    entry fun unpause_dao(arg0: &DAOCap, arg1: &mut Global, arg2: &0x2::tx_context::TxContext) {
        unpause(arg1, arg2);
    }

    entry fun unpause_emergency(arg0: &EmergencyCap, arg1: &mut Global, arg2: &0x2::tx_context::TxContext) {
        unpause(arg1, arg2);
    }

    public fun unwrap<T0>(arg0: &Global, arg1: 0x2::coin::Coin<FLUIDITY_COIN>, arg2: &mut UserVault<T0>, arg3: &mut PrizePoolVault<T0>, arg4: &mut CoinReserve, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.vaults_initialized, 5);
        assert_scallop_market(arg6);
        assert_scallop_version(arg5);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::coin::value<FLUIDITY_COIN>(&arg1);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg5, arg6, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg2.balance, v1), arg8), arg7, arg8);
        let v3 = 0x2::coin::split<T0>(&mut v2, v1, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v0);
        let v4 = 0;
        if (0x2::coin::value<T0>(&v2) != 0) {
            let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg5, arg6, v2, arg7, arg8);
            v4 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v5);
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg3.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v5));
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        let v6 = UnwrapEvent{
            user_vault_id           : 0x2::object::uid_to_inner(&arg2.id),
            prize_pool_vault_id     : 0x2::object::uid_to_inner(&arg3.id),
            coin_reserve_id         : 0x2::object::uid_to_inner(&arg4.id),
            global_id               : 0x2::object::uid_to_inner(&arg0.id),
            f_coin_id               : 0x2::object::id<0x2::coin::Coin<FLUIDITY_COIN>>(&arg1),
            user_address            : v0,
            f_coin_amount           : v1,
            prize_pool_vault_amount : v4,
            underlying_amount       : 0x2::coin::value<T0>(&v3),
            time                    : 0x2::clock::timestamp_ms(arg7) / 1000,
        };
        0x2::event::emit<UnwrapEvent>(v6);
        0x2::balance::join<FLUIDITY_COIN>(&mut arg4.balance, 0x2::coin::into_balance<FLUIDITY_COIN>(arg1));
    }

    public fun wrap<T0>(arg0: &Global, arg1: &mut UserVault<T0>, arg2: &mut CoinReserve, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.vaults_initialized, 5);
        assert_scallop_market(arg4);
        assert_scallop_version(arg3);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg4, arg6, arg5, arg7);
        let v2 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v1);
        let v3 = 0x2::balance::split<FLUIDITY_COIN>(&mut arg2.balance, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUIDITY_COIN>>(0x2::coin::from_balance<FLUIDITY_COIN>(v3, arg7), v0);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1));
        let v4 = WrapEvent{
            user_vault_id      : 0x2::object::uid_to_inner(&arg1.id),
            coin_reserve_id    : 0x2::object::uid_to_inner(&arg2.id),
            global_id          : 0x2::object::uid_to_inner(&arg0.id),
            underlying_coin_id : 0x2::object::id<0x2::coin::Coin<T0>>(&arg6),
            user_address       : v0,
            underlying_amount  : 0x2::coin::value<T0>(&arg6),
            s_coin_amount      : v2,
            f_coin_amount      : 0x2::balance::value<FLUIDITY_COIN>(&v3),
            time               : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<WrapEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

