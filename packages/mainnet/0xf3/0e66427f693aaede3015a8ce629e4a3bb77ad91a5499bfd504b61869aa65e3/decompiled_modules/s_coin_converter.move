module 0xf30e66427f693aaede3015a8ce629e4a3bb77ad91a5499bfd504b61869aa65e3::s_coin_converter {
    struct SCoinTreasury<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        s_coin_supply: 0x2::balance::Supply<T0>,
        market_coin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>,
    }

    public fun burn_s_coin<T0, T1>(arg0: &mut SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>> {
        0x2::balance::decrease_supply<T0>(&mut arg0.s_coin_supply, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.market_coin_balance, 0x2::coin::value<T0>(&arg1)), arg2)
    }

    fun create_s_coin_treasury<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &mut 0x2::tx_context::TxContext) : SCoinTreasury<T0, T1> {
        let v0 = 0x2::coin::treasury_into_supply<T0>(arg0);
        assert!(0x2::balance::supply_value<T0>(&v0) == 0, 401);
        assert!(0x2::coin::get_decimals<T0>(arg1) == 0x2::coin::get_decimals<T1>(arg2), 402);
        SCoinTreasury<T0, T1>{
            id                  : 0x2::object::new(arg3),
            s_coin_supply       : v0,
            market_coin_balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(),
        }
    }

    public fun init_s_coin_treasury<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SCoinTreasury<T0, T1>>(create_s_coin_treasury<T0, T1>(arg0, arg1, arg2, arg3));
    }

    public fun mint_s_coin<T0, T1>(arg0: &mut SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.market_coin_balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.s_coin_supply, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg1)), arg2)
    }

    public fun total_supply<T0, T1>(arg0: &SCoinTreasury<T0, T1>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.s_coin_supply)
    }

    // decompiled from Move bytecode v6
}

