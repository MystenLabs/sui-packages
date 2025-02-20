module 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MINTER has drop {
        dummy_field: bool,
    }

    struct EventUpdateEpoch has copy, drop, store {
        new_period: u64,
        new_epoch: u64,
        new_emissions: u64,
    }

    struct EventPauseEmission has copy, drop, store {
        dummy_field: bool,
    }

    struct EventUnpauseEmission has copy, drop, store {
        dummy_field: bool,
    }

    struct EventGrantAdmin has copy, drop, store {
        who: address,
        admin_cap: 0x2::object::ID,
    }

    struct Minter<phantom T0> has store, key {
        id: 0x2::object::UID,
        revoked_admins: 0x2::vec_set::VecSet<0x2::object::ID>,
        paused: bool,
        activated_at: u64,
        active_period: u64,
        epoch_count: u64,
        total_emissions: u64,
        last_epoch_update_time: u64,
        epoch_emissions: u64,
        minter_cap: 0x1::option::Option<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>,
        base_supply: u64,
        epoch_grow_rate: u64,
        epoch_decay_rate: u64,
        grow_epochs: u64,
        decay_epochs: u64,
        tail_emission_rate: u64,
        team_emission_rate: u64,
        team_wallet: address,
        reward_distributor_cap: 0x1::option::Option<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap>,
        notify_reward_cap: 0x1::option::Option<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap::NotifyRewardCap>,
        nudges: 0x2::vec_set::VecSet<u64>,
    }

    public fun total_supply<T0>(arg0: &Minter<T0>) : u64 {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::total_supply<T0>(0x1::option::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&arg0.minter_cap))
    }

    public fun activate<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::RewardDistributor<T0>, arg3: &0x2::clock::Clock) {
        check_admin<T0>(arg0, arg1);
        assert!(!is_active<T0>(arg0, arg3), 9223373106302222346);
        assert!(0x1::option::is_some<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), 9223373110598238234);
        let v0 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg3);
        arg0.activated_at = v0;
        arg0.active_period = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::to_period(arg0.activated_at);
        arg0.last_epoch_update_time = v0;
        arg0.epoch_emissions = arg0.base_supply;
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::start<T0>(arg2, 0x1::option::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), arg0.active_period, arg3);
    }

    public fun activated_at<T0>(arg0: &Minter<T0>) : u64 {
        arg0.activated_at
    }

    public fun active_period<T0>(arg0: &Minter<T0>) : u64 {
        arg0.active_period
    }

    public fun base_supply<T0>(arg0: &Minter<T0>) : u64 {
        arg0.base_supply
    }

    public fun calculate_epoch_emissions<T0>(arg0: &Minter<T0>) : (u64, u64) {
        if (arg0.epoch_emissions < 8969150000000) {
            (0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::total_supply<T0>(0x1::option::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&arg0.minter_cap)), arg0.tail_emission_rate, 10000), arg0.epoch_emissions)
        } else if (arg0.epoch_count < 14) {
            let v2 = if (arg0.epoch_emissions == 0) {
                arg0.base_supply
            } else {
                arg0.epoch_emissions
            };
            (v2, v2 + 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(v2, arg0.epoch_grow_rate, 10000))
        } else {
            let v3 = arg0.epoch_emissions;
            (v3, v3 - 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(v3, arg0.epoch_decay_rate, 10000))
        }
    }

    public fun calculate_rebase_growth(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_ceil(arg0, arg1 - arg2, arg1), arg1 - arg2, arg1) / 2
    }

    public fun check_admin<T0>(arg0: &Minter<T0>, arg1: &AdminCap) {
        let v0 = 0x2::object::id<AdminCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_admins, &v0), 9223372809948889087);
    }

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x1::option::Option<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>, arg2: &mut 0x2::tx_context::TxContext) : (Minter<T0>, AdminCap) {
        let v0 = Minter<T0>{
            id                     : 0x2::object::new(arg2),
            revoked_admins         : 0x2::vec_set::empty<0x2::object::ID>(),
            paused                 : false,
            activated_at           : 0,
            active_period          : 0,
            epoch_count            : 0,
            total_emissions        : 0,
            last_epoch_update_time : 0,
            epoch_emissions        : 0,
            minter_cap             : arg1,
            base_supply            : 10000000000000,
            epoch_grow_rate        : 10300,
            epoch_decay_rate       : 9900,
            grow_epochs            : 14,
            decay_epochs           : 67,
            tail_emission_rate     : 67,
            team_emission_rate     : 500,
            team_wallet            : @0x0,
            reward_distributor_cap : 0x1::option::none<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap>(),
            notify_reward_cap      : 0x1::option::none<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap::NotifyRewardCap>(),
            nudges                 : 0x2::vec_set::empty<u64>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg2)};
        (v0, v1)
    }

    public fun epoch<T0>(arg0: &Minter<T0>) : u64 {
        arg0.epoch_count
    }

    public fun epoch_emissions<T0>(arg0: &Minter<T0>) : u64 {
        arg0.epoch_emissions
    }

    public fun grant_admin(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = EventGrantAdmin{
            who       : arg1,
            admin_cap : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::event::emit<EventGrantAdmin>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    fun init(arg0: MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MINTER>(arg0, arg1);
    }

    public fun is_active<T0>(arg0: &Minter<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.activated_at > 0 && !arg0.paused && 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_period(arg1) >= arg0.active_period
    }

    public fun last_epoch_update_time<T0>(arg0: &Minter<T0>) : u64 {
        arg0.last_epoch_update_time
    }

    public fun max_bps() : u64 {
        10000
    }

    public fun pause<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap) {
        check_admin<T0>(arg0, arg1);
        arg0.paused = true;
        let v0 = EventPauseEmission{dummy_field: false};
        0x2::event::emit<EventPauseEmission>(v0);
    }

    public fun revoke_admin<T0>(arg0: &mut Minter<T0>, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_admins, arg2);
    }

    public fun set_minter_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>) {
        check_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_none<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&arg0.minter_cap), 9223372831423725567);
        0x1::option::fill<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&mut arg0.minter_cap, arg2);
    }

    public fun set_notify_reward_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap::NotifyRewardCap) {
        check_admin<T0>(arg0, arg1);
        0x1::option::fill<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap::NotifyRewardCap>(&mut arg0.notify_reward_cap, arg2);
    }

    public fun set_reward_distributor_cap<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap) {
        check_admin<T0>(arg0, arg1);
        0x1::option::fill<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap>(&mut arg0.reward_distributor_cap, arg2);
    }

    public fun set_team_emission_rate<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: u64) {
        check_admin<T0>(arg0, arg1);
        assert!(arg2 <= 500, 9223372921618038783);
        arg0.team_emission_rate = arg2;
    }

    public fun set_team_wallet<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap, arg2: address) {
        check_admin<T0>(arg0, arg1);
        arg0.team_wallet = arg2;
    }

    public fun team_emission_rate<T0>(arg0: &Minter<T0>) : u64 {
        arg0.team_emission_rate
    }

    public fun unpause<T0>(arg0: &mut Minter<T0>, arg1: &AdminCap) {
        check_admin<T0>(arg0, arg1);
        arg0.paused = false;
        let v0 = EventUnpauseEmission{dummy_field: false};
        0x2::event::emit<EventUnpauseEmission>(v0);
    }

    public fun update_period<T0>(arg0: &mut Minter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg2: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg3: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::RewardDistributor<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_active<T0>(arg0, arg4), 9223373394064900104);
        assert!(arg0.active_period + 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::week() < 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg4), 9223373406950588436);
        let (v0, v1) = calculate_epoch_emissions<T0>(arg0);
        let v2 = calculate_rebase_growth(v0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::total_supply<T0>(0x1::option::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&arg0.minter_cap)), 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::total_locked<T0>(arg2));
        let v3 = 0x2::object::id_address<Minter<T0>>(arg0);
        if (arg0.team_emission_rate > 0 && arg0.team_wallet != @0x0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::mint<T0>(0x1::option::borrow_mut<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&mut arg0.minter_cap), 0x17cc5a58c7e6f6473c5e20c4770411b0df7ecdaa40dd15d8ba778061bea28cc1::full_math_u64::mul_div_floor(arg0.team_emission_rate, v2 + v0, 10000 - arg0.team_emission_rate), v3, arg5), arg0.team_wallet);
        };
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::checkpoint_token<T0>(arg3, 0x1::option::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::mint<T0>(0x1::option::borrow_mut<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&mut arg0.minter_cap), v2, v3, arg5), arg4);
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::notify_rewards<T0>(arg1, 0x1::option::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap::NotifyRewardCap>(&arg0.notify_reward_cap), 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::mint<T0>(0x1::option::borrow_mut<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(&mut arg0.minter_cap), v0, 0x2::object::id_address<Minter<T0>>(arg0), arg5));
        arg0.active_period = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_period(arg4);
        arg0.epoch_count = arg0.epoch_count + 1;
        arg0.epoch_emissions = v1;
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::update_active_period<T0>(arg3, 0x1::option::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor_cap::RewardDistributorCap>(&arg0.reward_distributor_cap), arg0.active_period);
        let v4 = EventUpdateEpoch{
            new_period    : arg0.active_period,
            new_epoch     : arg0.epoch_count,
            new_emissions : arg0.epoch_emissions,
        };
        0x2::event::emit<EventUpdateEpoch>(v4);
    }

    // decompiled from Move bytecode v6
}

