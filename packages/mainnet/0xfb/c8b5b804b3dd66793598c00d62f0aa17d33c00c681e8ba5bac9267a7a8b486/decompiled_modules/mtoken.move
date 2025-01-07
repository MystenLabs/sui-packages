module 0xfbc8b5b804b3dd66793598c00d62f0aa17d33c00c681e8ba5bac9267a7a8b486::mtoken {
    struct VestingManager<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        vesting_balance: 0x2::balance::Balance<T1>,
        penalty_balance: 0x2::balance::Balance<T2>,
        mtoken_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        start_penalty_numerator: u64,
        end_penalty_numerator: u64,
        penalty_denominator: u64,
        start_time_s: u64,
        end_time_s: u64,
    }

    struct AdminCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        manager: 0x2::object::ID,
    }

    public fun collect_penalties<T0, T1, T2>(arg0: &mut VestingManager<T0, T1, T2>, arg1: &AdminCap<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg1.manager == 0x2::object::id<VestingManager<T0, T1, T2>>(arg0), 3);
        0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg0.penalty_balance), arg2)
    }

    public fun end_penalty_numerator<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.end_penalty_numerator
    }

    public fun end_time_s<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.end_time_s
    }

    public fun manager<T0, T1, T2>(arg0: &AdminCap<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun mint_mtokens<T0: drop, T1, T2>(arg0: T0, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (AdminCap<T0, T1, T2>, VestingManager<T0, T1, T2>, 0x2::coin::Coin<T0>) {
        assert!(arg7 > arg6, 0);
        let v0 = 0x1::ascii::string(b"WANG_");
        0x1::ascii::append(&mut v0, 0x2::coin::get_symbol<T1>(arg2));
        let v1 = 0x1::ascii::string(b"WANG Coin for ");
        0x1::ascii::append(&mut v1, 0x2::coin::get_symbol<T1>(arg2));
        let (v2, v3) = 0x2::coin::create_currency<T0>(arg0, 0x2::coin::get_decimals<T1>(arg2), 0x1::ascii::into_bytes(v0), 0x1::ascii::into_bytes(v0), 0x1::ascii::into_bytes(v1), 0x1::option::none<0x2::url::Url>(), arg8);
        let v4 = v2;
        let v5 = VestingManager<T0, T1, T2>{
            id                      : 0x2::object::new(arg8),
            vesting_balance         : 0x2::coin::into_balance<T1>(arg1),
            penalty_balance         : 0x2::balance::zero<T2>(),
            mtoken_treasury_cap     : v4,
            start_penalty_numerator : arg3,
            end_penalty_numerator   : arg4,
            penalty_denominator     : arg5,
            start_time_s            : arg6,
            end_time_s              : arg7,
        };
        let v6 = AdminCap<T0, T1, T2>{
            id      : 0x2::object::new(arg8),
            manager : 0x2::object::uid_to_inner(&v5.id),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v3);
        (v6, v5, 0x2::coin::mint<T0>(&mut v4, 0x2::coin::value<T1>(&arg1), arg8))
    }

    public fun penalty_denominator<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.penalty_denominator
    }

    public fun redeem_mtokens<T0, T1, T2>(arg0: &mut VestingManager<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v1 >= arg0.start_time_s, 1);
        let v2 = if (v1 < arg0.end_time_s) {
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.end_time_s), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.end_time_s), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.start_time_s)));
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.start_penalty_numerator), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.penalty_denominator)), v3), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.end_penalty_numerator), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.penalty_denominator)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), v3))))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.end_penalty_numerator), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0.penalty_denominator)))
        };
        assert!(0x2::coin::value<T2>(arg2) >= v2, 2);
        0x2::coin::burn<T0>(&mut arg0.mtoken_treasury_cap, arg1);
        0x2::balance::join<T2>(&mut arg0.penalty_balance, 0x2::balance::split<T2>(0x2::coin::balance_mut<T2>(arg2), v2));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.vesting_balance, v0), arg4)
    }

    public fun start_penalty_numerator<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.start_penalty_numerator
    }

    public fun start_time_s<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.start_time_s
    }

    // decompiled from Move bytecode v6
}

