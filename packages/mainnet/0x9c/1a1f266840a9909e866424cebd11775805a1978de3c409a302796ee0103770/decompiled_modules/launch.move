module 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::launch {
    struct Launched has copy, drop {
        curve: 0x2::object::ID,
        creator: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        supply: u64,
        first_buy: u64,
    }

    public fun launch<T0>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::share<T0>(open<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun launch_with_pool_cap<T0, T1: store + key>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: T1, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = open<T0>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::attach_pool_cap<T0, T1>(&mut v0, arg4);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::share<T0>(v0);
    }

    fun open<T0>(arg0: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::Curve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 13906834599545339908);
        assert!(0x2::coin::get_decimals<T0>(&arg3) == 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::decimals(arg0), 13906834603840438278);
        let v0 = 0x2::coin::get_name<T0>(&arg3);
        let v1 = 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(&arg3));
        assert!(0x1::string::length(&v0) > 0 && 0x1::string::length(&v0) <= 32, 13906834616725471240);
        assert!(0x1::string::length(&v1) > 0 && 0x1::string::length(&v1) <= 10, 13906834621020569610);
        let v2 = *0x1::string::as_bytes(&v1);
        let v3 = b"launch $";
        0x1::vector::append<u8>(&mut v3, v2);
        let v4 = 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::headline(v3);
        0x1::vector::append<u8>(&mut v4, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Name", *0x1::string::as_bytes(&v0)));
        0x1::vector::append<u8>(&mut v4, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Ticker", v2));
        0x1::vector::append<u8>(&mut v4, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Launch fee", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::launch_fee(arg0), 9), b"SUI")));
        0x1::vector::append<u8>(&mut v4, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"First buy", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg4, 9), b"SUI")));
        if (arg4 > 0) {
            0x1::vector::append<u8>(&mut v4, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Get at least", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg5, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::decimals(arg0)), v2)));
        };
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::authorize(arg0, arg1, v4, arg6, arg7, arg8, arg9, arg10, arg11);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::collect(arg0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::take_sui(arg1, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::launch_fee(arg0)));
        let v5 = 0x2::object::id<0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account>(arg1);
        let v6 = 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::new<T0>(arg0, v5, v0, v1, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::decimals(arg0), 0x2::coin::mint_balance<T0>(&mut arg2, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::total_supply(arg0)), arg11);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg3);
        if (arg4 > 0) {
            let (v7, v8) = 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::buy_balance<T0>(arg0, &mut v6, v5, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::take_sui(arg1, arg4));
            let v9 = v7;
            assert!(0x2::balance::value<T0>(&v9) >= arg5, 13906834745574752268);
            0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::put_token<T0>(arg1, v9);
            0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::put_sui(arg1, v8);
        };
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::charge_relay_fee(arg1, arg6, arg11);
        let v10 = Launched{
            curve     : 0x2::object::id<0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::Curve<T0>>(&v6),
            creator   : v5,
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            name      : v0,
            symbol    : v1,
            supply    : 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::total_supply(arg0),
            first_buy : arg4,
        };
        0x2::event::emit<Launched>(v10);
        v6
    }

    // decompiled from Move bytecode v7
}

