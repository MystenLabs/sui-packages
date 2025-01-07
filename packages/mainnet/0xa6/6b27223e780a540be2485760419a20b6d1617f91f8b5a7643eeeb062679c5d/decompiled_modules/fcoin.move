module 0xa66b27223e780a540be2485760419a20b6d1617f91f8b5a7643eeeb062679c5d::fcoin {
    struct CoinReserve has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<FCOIN>,
    }

    struct UserVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct ProtocolVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct FCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: u64, arg2: &mut CoinReserve, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<FCOIN>(arg0, 0x2::coin::from_balance<FCOIN>(0x2::balance::split<FCOIN>(&mut arg2.balance, arg1), arg3));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: u64, arg2: &mut CoinReserve, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<FCOIN>(&mut arg2.balance, 0x2::coin::into_balance<FCOIN>(0x2::coin::mint<FCOIN>(arg0, arg1, arg3)));
    }

    public entry fun collect_yield<T0>(arg0: &mut ProtocolVault<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.balance), arg4), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: FCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCOIN>(arg0, 2, b"fCoin", b"FC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_vault<T0>(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserVault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        let v1 = ProtocolVault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        let v2 = CoinReserve{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<FCOIN>(),
        };
        0x2::transfer::share_object<UserVault<T0>>(v0);
        0x2::transfer::share_object<ProtocolVault<T0>>(v1);
        0x2::transfer::share_object<CoinReserve>(v2);
    }

    public entry fun unwrap<T0>(arg0: 0x2::coin::Coin<FCOIN>, arg1: &mut UserVault<T0>, arg2: &mut ProtocolVault<T0>, arg3: &mut CoinReserve, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<FCOIN>(&arg0);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg4, arg5, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, v1), arg7), arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2, v1, arg7), v0);
        if (0x2::coin::value<T0>(&v2) != 0) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg2.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg4, arg5, v2, arg6, arg7)));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        };
        0x2::balance::join<FCOIN>(&mut arg3.balance, 0x2::coin::into_balance<FCOIN>(arg0));
    }

    public entry fun wrap<T0>(arg0: &mut UserVault<T0>, arg1: &mut CoinReserve, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg5), arg6), arg7), arg4, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<FCOIN>>(0x2::coin::from_balance<FCOIN>(0x2::balance::split<FCOIN>(&mut arg1.balance, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0)), arg7), 0x2::tx_context::sender(arg7));
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v0));
    }

    // decompiled from Move bytecode v6
}

