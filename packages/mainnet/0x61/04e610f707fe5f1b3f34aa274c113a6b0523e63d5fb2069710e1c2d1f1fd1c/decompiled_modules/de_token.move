module 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token {
    struct DE_TOKEN has drop {
        dummy_field: bool,
    }

    struct DeToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        max_time: u64,
        img_url: 0x1::ascii::String,
        name: 0x1::ascii::String,
        balance: 0x2::balance::Balance<T0>,
        end: u64,
        escrow_epoch: u64,
        point: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::Point,
        early_unlock: bool,
    }

    struct DeTokenUpdateEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        action: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::Action,
        prev_bal: u64,
        current_bal: u64,
        prev_duration: u64,
        current_duration: u64,
        prev_end: u64,
        current_end: u64,
        current_voting_weight: u64,
        prev_raw_voting_weight: u64,
        current_raw_voting_weight: u64,
        timestamp: u64,
    }

    public fun balance<T0, T1>(arg0: &DeToken<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun withdraw_all<T0, T1>(arg0: &mut DeToken<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::Action, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0.end;
        arg0.end = 0;
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg3);
        let v2 = DeTokenUpdateEvent{
            escrow_id                 : 0x2::object::id<DeToken<T0, T1>>(arg0),
            action                    : arg1,
            prev_bal                  : 0x2::coin::value<T0>(&v1),
            current_bal               : 0,
            prev_duration             : v0 - 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&arg0.point),
            current_duration          : 0,
            prev_end                  : v0,
            current_end               : 0,
            current_voting_weight     : 0,
            prev_raw_voting_weight    : raw_voting_weight<T0, T1>(arg0),
            current_raw_voting_weight : 0,
            timestamp                 : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DeTokenUpdateEvent>(v2);
        v1
    }

    public(friend) fun new<T0, T1>(arg0: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::Action, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : DeToken<T0, T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = DeToken<T0, T1>{
            id           : 0x2::object::new(arg7),
            pool         : arg2,
            max_time     : arg3,
            img_url      : 0x1::ascii::string(b"img_url"),
            name         : 0x1::ascii::string(b"name"),
            balance      : 0x2::coin::into_balance<T0>(arg1),
            end          : arg4,
            escrow_epoch : 0,
            point        : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::new(calculate_bias(v0, arg4, v1, arg3), calculate_slope(v0, arg3), v1),
            early_unlock : arg5,
        };
        let v3 = DeTokenUpdateEvent{
            escrow_id                 : 0x2::object::id<DeToken<T0, T1>>(&v2),
            action                    : arg0,
            prev_bal                  : 0,
            current_bal               : 0x2::balance::value<T0>(&v2.balance),
            prev_duration             : 0,
            current_duration          : arg4 - v1,
            prev_end                  : 0,
            current_end               : arg4,
            current_voting_weight     : voting_weight<T0, T1>(&v2, arg6),
            prev_raw_voting_weight    : 0,
            current_raw_voting_weight : raw_voting_weight<T0, T1>(&v2),
            timestamp                 : v1,
        };
        0x2::event::emit<DeTokenUpdateEvent>(v3);
        v2
    }

    public fun calculate_bias(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128 {
        let v0 = calculate_slope(arg0, arg3);
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::from(((arg1 - arg2) as u128));
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::mul(&v0, &v1);
        let v3 = multiplier_i128();
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::div(&v2, &v3)
    }

    public fun calculate_bias_by_slope(arg0: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128, arg1: u64, arg2: u64) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128 {
        let v0 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::from(((arg1 - arg2) as u128));
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::mul(&arg0, &v0);
        let v2 = multiplier_i128();
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::div(&v1, &v2)
    }

    public fun calculate_slope(arg0: u64, arg1: u64) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128 {
        let v0 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::from((arg0 as u128));
        let v1 = multiplier_i128();
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::mul(&v0, &v1);
        let v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::from((arg1 as u128));
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::div(&v2, &v3)
    }

    public(friend) fun destroy<T0, T1>(arg0: DeToken<T0, T1>) {
        let DeToken {
            id           : v0,
            pool         : _,
            max_time     : _,
            img_url      : _,
            name         : _,
            balance      : v5,
            end          : _,
            escrow_epoch : _,
            point        : _,
            early_unlock : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v5);
        0x2::object::delete(v0);
    }

    public fun early_unlock<T0, T1>(arg0: &DeToken<T0, T1>) : bool {
        arg0.early_unlock
    }

    public fun end<T0, T1>(arg0: &DeToken<T0, T1>) : u64 {
        arg0.end
    }

    public fun escrow_epoch<T0, T1>(arg0: &DeToken<T0, T1>) : u64 {
        arg0.escrow_epoch
    }

    public(friend) fun extend<T0, T1>(arg0: &mut DeToken<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::Action, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = arg0.end - 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&arg0.point);
        let v2 = raw_voting_weight<T0, T1>(arg0);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg2)) {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg2)));
        };
        if (arg3 != 0) {
            arg0.end = arg3;
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
        update_player_point_<T0, T1>(arg0, arg4);
        let v3 = DeTokenUpdateEvent{
            escrow_id                 : 0x2::object::id<DeToken<T0, T1>>(arg0),
            action                    : arg1,
            prev_bal                  : v0,
            current_bal               : 0x2::balance::value<T0>(&arg0.balance),
            prev_duration             : v1,
            current_duration          : arg0.end - 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&arg0.point),
            prev_end                  : arg0.end,
            current_end               : arg3,
            current_voting_weight     : voting_weight<T0, T1>(arg0, arg4),
            prev_raw_voting_weight    : v2,
            current_raw_voting_weight : raw_voting_weight<T0, T1>(arg0),
            timestamp                 : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeTokenUpdateEvent>(v3);
    }

    fun init(arg0: DE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DE_TOKEN>(arg0, arg1);
    }

    public fun is_expired<T0, T1>(arg0: &DeToken<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end
    }

    public fun max_time<T0, T1>(arg0: &DeToken<T0, T1>) : u64 {
        arg0.max_time
    }

    public fun multiplier_i128() : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128 {
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::from(1000000000)
    }

    public fun point<T0, T1>(arg0: &DeToken<T0, T1>) : &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::Point {
        &arg0.point
    }

    public fun pool_id<T0, T1>(arg0: &DeToken<T0, T1>) : 0x2::object::ID {
        arg0.pool
    }

    public fun raw_voting_weight<T0, T1>(arg0: &DeToken<T0, T1>) : u64 {
        voting_weight_at<T0, T1>(arg0, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&arg0.point))
    }

    fun update_player_point_<T0, T1>(arg0: &mut DeToken<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        arg0.escrow_epoch = arg0.escrow_epoch + 1;
        arg0.point = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::new(calculate_bias(v0, arg0.end, v1, arg0.max_time), calculate_slope(v0, arg0.max_time), v1);
    }

    public fun voting_weight<T0, T1>(arg0: &DeToken<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        voting_weight_at<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun voting_weight_at<T0, T1>(arg0: &DeToken<T0, T1>, arg1: u64) : u64 {
        let v0 = arg0.point;
        if (arg1 < 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&v0)) {
            return 0
        };
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::bias(&v0);
        let v2 = calculate_bias_by_slope(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::slope(&v0), arg1, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&v0));
        let v3 = &v1;
        v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::sub(v3, &v2);
        if (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_neg(&v1)) {
            v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        };
        (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::as_u128(&v1) as u64)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut DeToken<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::Action, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0.end;
        let v1 = v0 - 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&arg0.point);
        let v2 = raw_voting_weight<T0, T1>(arg0);
        let v3 = 0x2::balance::value<T0>(&arg0.balance);
        let v4 = voting_weight<T0, T1>(arg0, arg3);
        assert!(arg2 != v3, 102);
        assert!(arg2 < v3, 101);
        let v5 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4);
        update_player_point_<T0, T1>(arg0, arg3);
        let v6 = DeTokenUpdateEvent{
            escrow_id                 : 0x2::object::id<DeToken<T0, T1>>(arg0),
            action                    : arg1,
            prev_bal                  : 0x2::coin::value<T0>(&v5),
            current_bal               : 0x2::balance::value<T0>(&arg0.balance),
            prev_duration             : v1,
            current_duration          : v1,
            prev_end                  : v0,
            current_end               : v0,
            current_voting_weight     : v4,
            prev_raw_voting_weight    : v2,
            current_raw_voting_weight : raw_voting_weight<T0, T1>(arg0),
            timestamp                 : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeTokenUpdateEvent>(v6);
        v5
    }

    // decompiled from Move bytecode v6
}

