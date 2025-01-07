module 0xbf51eb45d2b4faf7f9cda88433760dc65c6ac98bded0b0d30aeb696c74251ad3::mtoken {
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

    struct MintMTokensEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
        mtoken_minted: u64,
        mtoken_type: 0x1::type_name::TypeName,
        vesting_type: 0x1::type_name::TypeName,
        penalty_type: 0x1::type_name::TypeName,
    }

    struct RedeemMTokensEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
        withdraw_amount: u64,
        penalty_amount: u64,
        mtoken_type: 0x1::type_name::TypeName,
        vesting_type: 0x1::type_name::TypeName,
        penalty_type: 0x1::type_name::TypeName,
    }

    struct PenaltyCollectedEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
        amount_collected: u64,
        mtoken_type: 0x1::type_name::TypeName,
        vesting_type: 0x1::type_name::TypeName,
        penalty_type: 0x1::type_name::TypeName,
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
        let v0 = 0x2::balance::withdraw_all<T2>(&mut arg0.penalty_balance);
        let v1 = PenaltyCollectedEvent{
            manager_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_collected : 0x2::balance::value<T2>(&v0),
            mtoken_type      : 0x1::type_name::get<T0>(),
            vesting_type     : 0x1::type_name::get<T1>(),
            penalty_type     : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<PenaltyCollectedEvent>(v1);
        0x2::coin::from_balance<T2>(v0, arg2)
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

    public fun migrate<T0: drop, T1, T2>(arg0: &AdminCap<T0, T1, T2>, arg1: &mut VestingManager<T0, T1, T2>) {
        assert!(arg1.version < 0, 999);
        arg1.version = 0;
    }

    public fun mint_more_mtokens<T0, T1, T2>(arg0: &mut VestingManager<T0, T1, T2>, arg1: &AdminCap<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        mint_mtokens_internal<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun mint_mtokens<T0: drop, T1, T2>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (AdminCap<T0, T1, T2>, VestingManager<T0, T1, T2>, 0x2::coin::Coin<T0>) {
        assert!(arg6 > arg5, 0);
        assert!(0x2::balance::supply_value<T0>(0x2::coin::supply<T0>(&mut arg0)) == 0, 4);
        let v0 = VestingManager<T0, T1, T2>{
            id                      : 0x2::object::new(arg7),
            version                 : 0,
            vesting_balance         : 0x2::balance::zero<T1>(),
            penalty_balance         : 0x2::balance::zero<T2>(),
            mtoken_treasury_cap     : arg0,
            start_penalty_numerator : arg2,
            end_penalty_numerator   : arg3,
            penalty_denominator     : arg4,
            start_time_s            : arg5,
            end_time_s              : arg6,
        };
        let v1 = AdminCap<T0, T1, T2>{
            id      : 0x2::object::new(arg7),
            manager : 0x2::object::uid_to_inner(&v0.id),
        };
        let v2 = &mut v0;
        (v1, v0, mint_mtokens_internal<T0, T1, T2>(v2, &v1, arg1, arg7))
    }

    fun mint_mtokens_internal<T0, T1, T2>(arg0: &mut VestingManager<T0, T1, T2>, arg1: &AdminCap<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version_and_upgrade<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::mint<T0>(&mut arg0.mtoken_treasury_cap, 0x2::coin::value<T1>(&arg2), arg3);
        0x2::balance::join<T1>(&mut arg0.vesting_balance, 0x2::coin::into_balance<T1>(arg2));
        let v1 = MintMTokensEvent{
            manager_id    : 0x2::object::uid_to_inner(&arg0.id),
            mtoken_minted : 0x2::coin::value<T0>(&v0),
            mtoken_type   : 0x1::type_name::get<T0>(),
            vesting_type  : 0x1::type_name::get<T1>(),
            penalty_type  : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<MintMTokensEvent>(v1);
        v0
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
        let v4 = RedeemMTokensEvent{
            manager_id      : 0x2::object::uid_to_inner(&arg0.id),
            withdraw_amount : v0,
            penalty_amount  : v2,
            mtoken_type     : 0x1::type_name::get<T0>(),
            vesting_type    : 0x1::type_name::get<T1>(),
            penalty_type    : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<RedeemMTokensEvent>(v4);
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

