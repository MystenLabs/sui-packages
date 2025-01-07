module 0x3c95e83292f7bdd4bf2349ef1f55960c58bfd1f06a3d587b2eda88ef6f802551::scable {
    struct SCABLE has drop {
        dummy_field: bool,
    }

    struct ScableTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SCABLE>,
    }

    struct ScableVault<phantom T0> has key {
        id: 0x2::object::UID,
        scoin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        coin_balance: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun total_supply(arg0: &ScableTreasury) : u64 {
        0x2::coin::total_supply<SCABLE>(&arg0.cap)
    }

    public fun claim<T0>(arg0: &AdminCap, arg1: &mut ScableVault<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.scoin_balance, scoin_balance<T0>(arg1) - 0x3c95e83292f7bdd4bf2349ef1f55960c58bfd1f06a3d587b2eda88ef6f802551::math::calc_coin_to_scoin(arg2, arg3, 0x1::type_name::get<T0>(), arg4, coin_balance<T0>(arg1)), arg5), arg4, arg5)
    }

    public fun coin_balance<T0>(arg0: &ScableVault<T0>) : u64 {
        arg0.coin_balance
    }

    public fun create<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScableVault<T0>{
            id            : 0x2::object::new(arg1),
            scoin_balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            coin_balance  : 0,
        };
        0x2::transfer::share_object<ScableVault<T0>>(v0);
    }

    public fun deposit_coin<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SCABLE> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg5, arg4, arg6);
        deposit_scoin<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg6)
    }

    public fun deposit_scoin<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SCABLE> {
        let v0 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg5);
        let v1 = 0x3c95e83292f7bdd4bf2349ef1f55960c58bfd1f06a3d587b2eda88ef6f802551::math::calc_scoin_to_coin(arg2, arg3, 0x1::type_name::get<T0>(), arg4, v0);
        arg0.coin_balance = coin_balance<T0>(arg0) + v1;
        0x3c95e83292f7bdd4bf2349ef1f55960c58bfd1f06a3d587b2eda88ef6f802551::event::emit_mint<T0>(v0, v1);
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, arg5);
        0x2::coin::mint<SCABLE>(&mut arg1.cap, v1, arg6)
    }

    fun err_vault_balance_not_enough() {
        abort 0
    }

    fun init(arg0: SCABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCABLE>(arg0, 6, b"SCABLE", b"SCA-STABLE-LP", b"Stablecoin minted by Scallop Stablecoin LP (sUSDC/sUSDT)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCABLE>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = ScableTreasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<ScableTreasury>(v2);
    }

    public fun scoin_balance<T0>(arg0: &ScableVault<T0>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.scoin_balance)
    }

    public fun withdraw_coin<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<SCABLE>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = withdraw_scoin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, v0, arg4, arg6)
    }

    public fun withdraw_scoin<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<SCABLE>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = 0x2::coin::value<SCABLE>(&arg5);
        let v1 = 0x3c95e83292f7bdd4bf2349ef1f55960c58bfd1f06a3d587b2eda88ef6f802551::math::calc_coin_to_scoin(arg2, arg3, 0x1::type_name::get<T0>(), arg4, v0);
        if (coin_balance<T0>(arg0) < v0) {
            err_vault_balance_not_enough();
        };
        arg0.coin_balance = coin_balance<T0>(arg0) - v0;
        0x3c95e83292f7bdd4bf2349ef1f55960c58bfd1f06a3d587b2eda88ef6f802551::event::emit_burn<T0>(v0, v1);
        0x2::coin::burn<SCABLE>(&mut arg1.cap, arg5);
        0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, v1, arg6)
    }

    // decompiled from Move bytecode v6
}

