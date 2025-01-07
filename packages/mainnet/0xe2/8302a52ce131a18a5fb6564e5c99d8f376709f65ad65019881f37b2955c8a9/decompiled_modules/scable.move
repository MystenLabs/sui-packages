module 0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::scable {
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

    struct SpoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun total_supply(arg0: &ScableTreasury) : u64 {
        0x2::coin::total_supply<SCABLE>(&arg0.cap)
    }

    public fun add_spool_account<T0>(arg0: &AdminCap, arg1: &mut ScableVault<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SpoolKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<SpoolKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg1.id, v0, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, arg3, arg4));
    }

    public fun claim<T0>(arg0: &AdminCap, arg1: &mut ScableVault<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.scoin_balance, scoin_balance<T0>(arg1) - 0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::math::calc_coin_to_scoin(arg2, arg3, 0x1::type_name::get<T0>(), arg4, coin_balance<T0>(arg1)), arg5), arg4, arg5);
        0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::event::emit_claim<T0>(&v0);
        v0
    }

    public fun claim_spool_reward<T0, T1>(arg0: &AdminCap, arg1: &mut ScableVault<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1>(arg2, arg3, spool_account_mut<T0>(arg1), arg4, arg5)
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
        let v1 = 0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::math::calc_scoin_to_coin(arg2, arg3, 0x1::type_name::get<T0>(), arg4, v0);
        arg0.coin_balance = coin_balance<T0>(arg0) + v1;
        0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::event::emit_mint<T0>(v0, v1);
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, arg5);
        0x2::coin::mint<SCABLE>(&mut arg1.cap, v1, arg6)
    }

    fun err_spool_account_not_exists() {
        abort 0
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
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun scoin_balance<T0>(arg0: &ScableVault<T0>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.scoin_balance)
    }

    fun spool_account<T0>(arg0: &ScableVault<T0>) : &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        if (!spool_account_exists<T0>(arg0)) {
            err_spool_account_not_exists();
        };
        let v0 = SpoolKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<SpoolKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.id, v0)
    }

    public fun spool_account_exists<T0>(arg0: &ScableVault<T0>) : bool {
        let v0 = SpoolKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<SpoolKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&arg0.id, v0)
    }

    fun spool_account_mut<T0>(arg0: &mut ScableVault<T0>) : &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        if (!spool_account_exists<T0>(arg0)) {
            err_spool_account_not_exists();
        };
        let v0 = SpoolKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<SpoolKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v0)
    }

    public fun spool_balance<T0>(arg0: &ScableVault<T0>) : u64 {
        if (spool_account_exists<T0>(arg0)) {
            0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(spool_account<T0>(arg0))
        } else {
            0
        }
    }

    public fun stake<T0>(arg0: &mut ScableVault<T0>, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (spool_account_exists<T0>(arg0) && scoin_balance<T0>(arg0) > 0) {
            let v0 = 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance), arg3);
            0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1, spool_account_mut<T0>(arg0), v0, arg2, arg3);
        };
    }

    public fun total_scoin_balance<T0>(arg0: &ScableVault<T0>) : u64 {
        spool_balance<T0>(arg0) + scoin_balance<T0>(arg0)
    }

    public fun update_spool_points<T0>(arg0: &AdminCap, arg1: &mut ScableVault<T0>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock) {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::update_points<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, spool_account_mut<T0>(arg1), arg3);
    }

    public fun withdraw_coin<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<SCABLE>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = withdraw_scoin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, v0, arg4, arg6)
    }

    public fun withdraw_coin_from_spool<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<SCABLE>, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = withdraw_scoin_from_spool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, v0, arg4, arg7)
    }

    public fun withdraw_scoin<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<SCABLE>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = 0x2::coin::value<SCABLE>(&arg5);
        let v1 = 0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::math::calc_coin_to_scoin(arg2, arg3, 0x1::type_name::get<T0>(), arg4, v0);
        if (coin_balance<T0>(arg0) < v0) {
            err_vault_balance_not_enough();
        };
        arg0.coin_balance = coin_balance<T0>(arg0) - v0;
        0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::event::emit_burn<T0>(v0, v1);
        0x2::coin::burn<SCABLE>(&mut arg1.cap, arg5);
        0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, v1, arg6)
    }

    public fun withdraw_scoin_from_spool<T0>(arg0: &mut ScableVault<T0>, arg1: &mut ScableTreasury, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<SCABLE>, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = 0x2::coin::value<SCABLE>(&arg5);
        let v1 = 0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::math::calc_coin_to_scoin(arg2, arg3, 0x1::type_name::get<T0>(), arg4, v0);
        if (coin_balance<T0>(arg0) < v0) {
            err_vault_balance_not_enough();
        };
        arg0.coin_balance = coin_balance<T0>(arg0) - v0;
        0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::event::emit_burn<T0>(v0, v1);
        0x2::coin::burn<SCABLE>(&mut arg1.cap, arg5);
        let v2 = scoin_balance<T0>(arg0);
        if (v1 > v2) {
            let v3 = spool_account_mut<T0>(arg0);
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg6, v3, v1 - v2, arg4, arg7)));
        };
        0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, v1, arg7)
    }

    // decompiled from Move bytecode v6
}

