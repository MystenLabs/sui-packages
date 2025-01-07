module 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool {
    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        lp_custodian: 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
        reward_token_custodian: 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<T2>,
        flx_custodian: 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>,
        token_per_seconds: u64,
        flx_per_seconds: u64,
        acc_token_per_share: u256,
        acc_flx_per_share: u256,
        last_reward_at_ms: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        creator: address,
        is_emergency: bool,
    }

    struct PoolCreated has copy, drop {
        id: 0x2::object::ID,
        lp_name: 0x1::string::String,
        reward_token_type: 0x1::string::String,
        total_reward_token: u64,
        total_flx: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        user: address,
    }

    fun new<T0, T1, T2>(arg0: &mut 0x2::tx_context::TxContext) : Pool<T0, T1, T2> {
        Pool<T0, T1, T2>{
            id                     : 0x2::object::new(arg0),
            lp_custodian           : 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::new<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
            reward_token_custodian : 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::new<T2>(),
            flx_custodian          : 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::new<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(),
            token_per_seconds      : 0,
            flx_per_seconds        : 0,
            acc_token_per_share    : 0,
            acc_flx_per_share      : 0,
            last_reward_at_ms      : 0,
            started_at_ms          : 0,
            ended_at_ms            : 0,
            creator                : 0x2::tx_context::sender(arg0),
            is_emergency           : false,
        }
    }

    public fun acc_flx_per_share<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u256 {
        arg0.acc_flx_per_share
    }

    public fun acc_token_per_share<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u256 {
        arg0.acc_token_per_share
    }

    public fun borrow_flx_custodian<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX> {
        &arg0.flx_custodian
    }

    public fun borrow_lp_custodian<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        &arg0.lp_custodian
    }

    public(friend) fun borrow_mut_flx_custodian<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>) : &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX> {
        &mut arg0.flx_custodian
    }

    public(friend) fun borrow_mut_lp_custodian<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>) : &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        &mut arg0.lp_custodian
    }

    public(friend) fun borrow_mut_reward_token_custodian<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>) : &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<T2> {
        &mut arg0.reward_token_custodian
    }

    public fun borrow_reward_token_custodian<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::Custodian<T2> {
        &arg0.reward_token_custodian
    }

    public fun calc_pending_rewards<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position) : (u64, u64) {
        let (v0, v1) = calc_rewards_for<T0, T1, T2>(arg0, arg1);
        (v0 - 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::token_reward_debt(arg1), v1 - 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::flx_reward_debt(arg1))
    }

    public fun calc_rewards_for<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position) : (u64, u64) {
        ((((0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::value(arg1) as u256) * arg0.acc_token_per_share / 1000000) as u64), (((0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::value(arg1) as u256) * arg0.acc_flx_per_share / 1000000) as u64))
    }

    public(friend) fun create_pool<T0, T1, T2>(arg0: 0x2::coin::Coin<T2>, arg1: 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0, T1, T2> {
        let v0 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_milliseconds(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(arg3));
        let v1 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_milliseconds(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(arg2));
        assert!(v1 > 0x2::clock::timestamp_ms(arg4), 0);
        assert!(v0 > v1, 1);
        let v2 = v0 - v1;
        let v3 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::calculate_reward_per_seconds(0x2::coin::value<T2>(&arg0), v2);
        let v4 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::calculate_reward_in_duration(v3, v2);
        let v5 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::calculate_reward_per_seconds(0x2::coin::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg1), v2);
        let v6 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::calculate_reward_in_duration(v5, v2);
        assert!(v3 + v5 > 0, 2);
        let v7 = 0x2::tx_context::sender(arg5);
        let v8 = new<T0, T1, T2>(arg5);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::deposit<T2>(&mut v8.reward_token_custodian, 0x2::coin::split<T2>(&mut arg0, v4, arg5));
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::deposit<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v8.flx_custodian, 0x2::coin::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg1, v6, arg5));
        v8.token_per_seconds = v3;
        v8.flx_per_seconds = v5;
        v8.last_reward_at_ms = v1;
        v8.started_at_ms = v1;
        v8.ended_at_ms = v0;
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::transfer_or_destroy_zero<T2>(arg0, v7);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::transfer_or_destroy_zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(arg1, v7);
        let v9 = PoolCreated{
            id                 : 0x2::object::id<Pool<T0, T1, T2>>(&v8),
            lp_name            : 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_lp_name<T0, T1>(),
            reward_token_type  : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>())),
            total_reward_token : v4,
            total_flx          : v6,
            started_at_ms      : v1,
            ended_at_ms        : v0,
            user               : v7,
        };
        0x2::event::emit<PoolCreated>(v9);
        v8
    }

    public fun creator<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : address {
        arg0.creator
    }

    public fun ended_at<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.ended_at_ms
    }

    public fun estimate_pending_rewards<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::reserve<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.lp_custodian);
        let v2 = arg0.acc_token_per_share;
        let v3 = v2;
        let v4 = arg0.acc_flx_per_share;
        let v5 = v4;
        if (0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(v0) > 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(arg0.last_reward_at_ms) && v1 != 0) {
            let v6 = get_multiplier<T0, T1, T2>(arg0, v0);
            v3 = v2 + ((v6 * arg0.token_per_seconds) as u256) * 1000000 / (v1 as u256);
            v5 = v4 + ((v6 * arg0.flx_per_seconds) as u256) * 1000000 / (v1 as u256);
        };
        ((((0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::value(arg1) as u256) * v3 / 1000000) as u64) - 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::token_reward_debt(arg1), (((0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::value(arg1) as u256) * v5 / 1000000) as u64) - 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::flx_reward_debt(arg1))
    }

    public fun flx_per_seconds<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.flx_per_seconds
    }

    public fun get_multiplier<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = arg0.last_reward_at_ms;
        let v1 = arg0.ended_at_ms;
        if (arg1 <= v1) {
            0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(arg1) - 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(v0)
        } else if (v0 > v1) {
            0
        } else {
            0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(v1) - 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(v0)
        }
    }

    public fun is_emergency<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : bool {
        arg0.is_emergency
    }

    public fun last_reward_at<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.last_reward_at_ms
    }

    public(friend) fun set_emergency<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>) {
        arg0.is_emergency = true;
    }

    public(friend) fun set_end_time<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 3);
        assert!(0x2::clock::timestamp_ms(arg2) + 172800000 < arg0.started_at_ms, 4);
        assert!(arg1 > arg0.started_at_ms, 1);
        arg0.ended_at_ms = arg1;
    }

    public fun started_at<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.started_at_ms
    }

    public(friend) fun stop_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        arg0.ended_at_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun token_per_seconds<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u64 {
        arg0.token_per_seconds
    }

    public fun update_pool<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        if (0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(0x2::clock::timestamp_ms(arg1)) <= 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(arg0.last_reward_at_ms)) {
            return
        };
        let v0 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::reserve<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.lp_custodian);
        if (v0 == 0) {
            arg0.last_reward_at_ms = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_milliseconds(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(0x2::clock::timestamp_ms(arg1)));
            return
        };
        let v1 = get_multiplier<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg1));
        arg0.acc_token_per_share = arg0.acc_token_per_share + ((v1 * arg0.token_per_seconds) as u256) * 1000000 / (v0 as u256);
        arg0.acc_flx_per_share = arg0.acc_flx_per_share + ((v1 * arg0.flx_per_seconds) as u256) * 1000000 / (v0 as u256);
        arg0.last_reward_at_ms = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_milliseconds(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::to_seconds(0x2::clock::timestamp_ms(arg1)));
    }

    // decompiled from Move bytecode v6
}

