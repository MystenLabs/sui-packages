module 0x57ca3da762bfc3f2e35fc375ea47f50d469bf42adbdf63546a94f784f0c342ba::fcoin {
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

    fun burn(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: 0x2::coin::Coin<FCOIN>) {
        0x2::coin::burn<FCOIN>(arg0, arg1);
    }

    public entry fun collect_yield<T0>(arg0: &mut ProtocolVault<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.balance), arg4), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: FCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCOIN>(arg0, 2, b"fCoin", b"FC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserVault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        let v1 = ProtocolVault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        0x2::transfer::share_object<UserVault<T0>>(v0);
        0x2::transfer::share_object<ProtocolVault<T0>>(v1);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun unwrap<T0>(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: 0x2::coin::Coin<FCOIN>, arg2: &mut UserVault<T0>, arg3: &mut ProtocolVault<T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg4, arg5, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg2.balance, 0x2::coin::value<FCOIN>(&arg1)), arg7), arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, 0x2::coin::value<FCOIN>(&arg1), arg7), v0);
        if (0x2::coin::value<T0>(&v1) != 0) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg3.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg4, arg5, v1, arg6, arg7)));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        };
        burn(arg0, arg1);
    }

    public entry fun wrap<T0>(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: &mut UserVault<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg5), arg6), arg7), arg4, arg7);
        mint(arg0, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v1), v0, arg7);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1));
    }

    // decompiled from Move bytecode v6
}

