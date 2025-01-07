module 0x8e69f87223f1a6a4a7c3bd5d3c1317681c02593eed581448f71e6259abdd679c::mtoken {
    struct VestingManager<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        version: u64,
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

    public(friend) fun assert_version<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) {
        assert!(arg0.version == 0, 999);
    }

    public(friend) fun assert_version_and_upgrade<T0, T1, T2>(arg0: &mut VestingManager<T0, T1, T2>) {
        if (arg0.version < 0) {
            arg0.version = 0;
        };
        assert_version<T0, T1, T2>(arg0);
    }

    public fun collect_penalties<T0, T1, T2>(arg0: &mut VestingManager<T0, T1, T2>, arg1: &AdminCap<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_version_and_upgrade<T0, T1, T2>(arg0);
        assert!(arg1.manager == 0x2::object::id<VestingManager<T0, T1, T2>>(arg0), 3);
        0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg0.penalty_balance), arg2)
    }

    public fun end_penalty_numerator<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.end_penalty_numerator
    }

    public fun end_time_s<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.end_time_s
    }

    public fun init_manager<T0: drop, T1, T2>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (AdminCap<T0, T1, T2>, VestingManager<T0, T1, T2>) {
        assert!(arg10 > arg9, 0);
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg11);
        let v2 = VestingManager<T0, T1, T2>{
            id                      : 0x2::object::new(arg11),
            version                 : 0,
            vesting_balance         : 0x2::balance::zero<T1>(),
            penalty_balance         : 0x2::balance::zero<T2>(),
            mtoken_treasury_cap     : v0,
            start_penalty_numerator : arg6,
            end_penalty_numerator   : arg7,
            penalty_denominator     : arg8,
            start_time_s            : arg9,
            end_time_s              : arg10,
        };
        let v3 = AdminCap<T0, T1, T2>{
            id      : 0x2::object::new(arg11),
            manager : 0x2::object::uid_to_inner(&v2.id),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        (v3, v2)
    }

    public fun manager<T0, T1, T2>(arg0: &AdminCap<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun migrate<T0: drop, T1, T2>(arg0: &AdminCap<T0, T1, T2>, arg1: &mut VestingManager<T0, T1, T2>) {
        assert!(arg1.version < 0, 999);
        arg1.version = 0;
    }

    public fun mint_mtokens<T0: drop, T1, T2>(arg0: &AdminCap<T0, T1, T2>, arg1: &mut VestingManager<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version_and_upgrade<T0, T1, T2>(arg1);
        0x2::balance::join<T1>(&mut arg1.vesting_balance, 0x2::coin::into_balance<T1>(arg2));
        0x2::coin::mint<T0>(&mut arg1.mtoken_treasury_cap, 0x2::coin::value<T1>(&arg2), arg3)
    }

    public fun penalty_denominator<T0, T1, T2>(arg0: &VestingManager<T0, T1, T2>) : u64 {
        arg0.penalty_denominator
    }

    public fun redeem_mtokens<T0, T1, T2>(arg0: &mut VestingManager<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version_and_upgrade<T0, T1, T2>(arg0);
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

