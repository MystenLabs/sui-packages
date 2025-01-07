module 0x1031c4111f324603752fc1f3319ea3612139fbc1cd4fd02a10c709f47c30542::fluidity_coin {
    struct VaultsInitialized has store {
        dummy_field: bool,
    }

    struct Global has key {
        id: 0x2::object::UID,
        paused: bool,
        vaults_initialized: bool,
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
    }

    struct UnwrapEvent has copy, drop {
        user_vault_id: 0x2::object::ID,
        protocol_vault_id: 0x2::object::ID,
        coin_reserve_id: 0x2::object::ID,
        global_id: 0x2::object::ID,
        f_coin_id: 0x2::object::ID,
        user_address: address,
        f_coin_amount: u64,
        protocol_vault_amount: u64,
        underlying_amount: u64,
    }

    struct CoinReserve has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<FLUIDITY_COIN>,
    }

    struct UserVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct ProtocolVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct FLUIDITY_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLUIDITY_COIN>, arg1: &Global, arg2: u64, arg3: &mut CoinReserve, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vaults_initialized == true, 0);
        assert!(0x2::balance::value<FLUIDITY_COIN>(&arg3.balance) >= arg2, 2);
        0x2::coin::burn<FLUIDITY_COIN>(arg0, 0x2::coin::from_balance<FLUIDITY_COIN>(0x2::balance::split<FLUIDITY_COIN>(&mut arg3.balance, arg2), arg4));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLUIDITY_COIN>, arg1: &Global, arg2: u64, arg3: &mut CoinReserve, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vaults_initialized == true, 0);
        0x2::balance::join<FLUIDITY_COIN>(&mut arg3.balance, 0x2::coin::into_balance<FLUIDITY_COIN>(0x2::coin::mint<FLUIDITY_COIN>(arg0, arg2, arg4)));
    }

    public entry fun collect_yield<T0>(arg0: &mut 0x2::coin::TreasuryCap<FLUIDITY_COIN>, arg1: &mut ProtocolVault<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance), arg5), arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    fun init(arg0: FLUIDITY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUIDITY_COIN>(arg0, 9, b"FSUI", b"FSUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Global{
            id                 : 0x2::object::new(arg1),
            paused             : false,
            vaults_initialized : false,
        };
        0x2::transfer::share_object<Global>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLUIDITY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUIDITY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_vault<T0>(arg0: &mut 0x2::coin::TreasuryCap<FLUIDITY_COIN>, arg1: &mut Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vaults_initialized == false, 0);
        let v0 = UserVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        let v1 = ProtocolVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        let v2 = CoinReserve{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<FLUIDITY_COIN>(),
        };
        0x2::transfer::share_object<UserVault<T0>>(v0);
        0x2::transfer::share_object<ProtocolVault<T0>>(v1);
        0x2::transfer::share_object<CoinReserve>(v2);
        arg1.vaults_initialized = true;
    }

    public entry fun unwrap<T0>(arg0: &Global, arg1: 0x2::coin::Coin<FLUIDITY_COIN>, arg2: &mut UserVault<T0>, arg3: &mut ProtocolVault<T0>, arg4: &mut CoinReserve, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 1);
        assert!(arg0.vaults_initialized == true, 0);
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
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        };
        let v6 = UnwrapEvent{
            user_vault_id         : 0x2::object::uid_to_inner(&arg2.id),
            protocol_vault_id     : 0x2::object::uid_to_inner(&arg3.id),
            coin_reserve_id       : 0x2::object::uid_to_inner(&arg4.id),
            global_id             : 0x2::object::uid_to_inner(&arg0.id),
            f_coin_id             : 0x2::object::id<0x2::coin::Coin<FLUIDITY_COIN>>(&arg1),
            user_address          : v0,
            f_coin_amount         : v1,
            protocol_vault_amount : v4,
            underlying_amount     : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<UnwrapEvent>(v6);
        0x2::balance::join<FLUIDITY_COIN>(&mut arg4.balance, 0x2::coin::into_balance<FLUIDITY_COIN>(arg1));
    }

    public entry fun wrap<T0>(arg0: &Global, arg1: &mut UserVault<T0>, arg2: &mut CoinReserve, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 1);
        assert!(arg0.vaults_initialized == true, 0);
        let v0 = 0x2::coin::value<T0>(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg6), v0), arg7), arg5, arg7);
        let v3 = 0x2::balance::split<FLUIDITY_COIN>(&mut arg2.balance, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUIDITY_COIN>>(0x2::coin::from_balance<FLUIDITY_COIN>(v3, arg7), v1);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v2));
        let v4 = WrapEvent{
            user_vault_id      : 0x2::object::uid_to_inner(&arg1.id),
            coin_reserve_id    : 0x2::object::uid_to_inner(&arg2.id),
            global_id          : 0x2::object::uid_to_inner(&arg0.id),
            underlying_coin_id : 0x2::object::id<0x2::coin::Coin<T0>>(arg6),
            user_address       : v1,
            underlying_amount  : v0,
            s_coin_amount      : 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v2),
            f_coin_amount      : 0x2::balance::value<FLUIDITY_COIN>(&v3),
        };
        0x2::event::emit<WrapEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

