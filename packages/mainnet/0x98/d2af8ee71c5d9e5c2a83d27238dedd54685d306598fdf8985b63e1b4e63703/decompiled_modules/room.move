module 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::room {
    struct Seat has copy, drop, store {
        owner: address,
        lead_account_id: 0x2::object::ID,
        strategy_hash: vector<u8>,
    }

    struct Leg has copy, drop, store {
        seed: vector<u8>,
        status: u8,
        attacker_fuel: u8,
        defender_fuel: u8,
        replay_digest: vector<u8>,
    }

    struct Room<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        status: u8,
        tier: u64,
        rake_bps: u64,
        leg_window_ms: u64,
        settle_grace_ms: u64,
        pot: 0x2::balance::Balance<T0>,
        creator: Seat,
        joiner: 0x1::option::Option<Seat>,
        home: Leg,
        away: Leg,
        created_at_ms: u64,
        expires_at_ms: u64,
        filled_at_ms: u64,
        play_by_ms: u64,
        settle_by_ms: u64,
    }

    struct RoomCreated has copy, drop {
        room_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        creator: address,
        lead_account_id: 0x2::object::ID,
        strategy_hash: vector<u8>,
        tier: u64,
        rake_bps: u64,
        leg_window_ms: u64,
        settle_grace_ms: u64,
        created_at_ms: u64,
        expires_at_ms: u64,
    }

    struct RoomJoined has copy, drop {
        room_id: 0x2::object::ID,
        creator: address,
        joiner: address,
        lead_account_id: 0x2::object::ID,
        strategy_hash: vector<u8>,
        tier: u64,
        pot: u64,
        filled_at_ms: u64,
        play_by_ms: u64,
        settle_by_ms: u64,
    }

    struct LegSeedDrawn has copy, drop {
        room_id: 0x2::object::ID,
        leg: u8,
        attacker: address,
        seed: vector<u8>,
        drawn_at_ms: u64,
    }

    struct LegSettled has copy, drop {
        room_id: 0x2::object::ID,
        leg: u8,
        attacker: address,
        defender: address,
        attacker_fuel: u8,
        defender_fuel: u8,
        replay_digest: vector<u8>,
        forfeited: bool,
        verifier_cap_id: 0x1::option::Option<0x2::object::ID>,
        settled_at_ms: u64,
    }

    struct RoomSettled has copy, drop {
        room_id: 0x2::object::ID,
        outcome: u8,
        winner: 0x1::option::Option<address>,
        creator: address,
        joiner: address,
        creator_fuel: u64,
        joiner_fuel: u64,
        pot: u64,
        creator_payout: u64,
        joiner_payout: u64,
        house: address,
        house_amount: u64,
        settled_at_ms: u64,
    }

    struct RoomCancelled has copy, drop {
        room_id: 0x2::object::ID,
        creator: address,
        refund: u64,
        cancelled_at_ms: u64,
    }

    struct RoomExpired has copy, drop {
        room_id: 0x2::object::ID,
        creator: address,
        refund: u64,
        expired_at_ms: u64,
    }

    public fun leg_window_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.leg_window_ms
    }

    public fun rake_bps<T0>(arg0: &Room<T0>) : u64 {
        arg0.rake_bps
    }

    public fun settle_grace_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.settle_grace_ms
    }

    fun assert_config<T0>(arg0: &Room<T0>, arg1: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>) {
        0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::assert_version<T0>(arg1);
        assert!(arg0.config_id == 0x2::object::id<0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>>(arg1), 13906837043382059017);
    }

    fun assert_seed_drawable<T0>(arg0: &Room<T0>, arg1: u8, arg2: &0x2::clock::Clock) {
        assert!(arg1 <= 1, 13906837069153173533);
        assert!(arg0.status == 1, 13906837073448009755);
        let v0 = leg_ref<T0>(arg0, arg1);
        assert!(v0.status == 0, 13906837082038861865);
        assert!(0x1::vector::is_empty<u8>(&v0.seed), 13906837086334091309);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.settle_by_ms, 13906837090628534309);
    }

    public fun cancel_room<T0>(arg0: &mut Room<T0>, arg1: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_config<T0>(arg0, arg1);
        assert!(arg0.status == 0, 13906835892331216911);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator.owner, 13906835896626577429);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.pot);
        arg0.status = 3;
        let v1 = RoomCancelled{
            room_id         : 0x2::object::id<Room<T0>>(arg0),
            creator         : arg0.creator.owner,
            refund          : 0x2::balance::value<T0>(&v0),
            cancelled_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RoomCancelled>(v1);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun config_id<T0>(arg0: &Room<T0>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun create_room<T0>(arg0: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::assert_accepting_rooms<T0>(arg0);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906835458539257867);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::is_tier<T0>(arg0, v0), 13906835467129323533);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = Seat{
            owner           : v2,
            lead_account_id : arg2,
            strategy_hash   : arg3,
        };
        let v4 = Room<T0>{
            id              : 0x2::object::new(arg5),
            config_id       : 0x2::object::id<0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>>(arg0),
            status          : 0,
            tier            : v0,
            rake_bps        : 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::rake_bps<T0>(arg0),
            leg_window_ms   : 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::leg_window_ms<T0>(arg0),
            settle_grace_ms : 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::settle_grace_ms<T0>(arg0),
            pot             : 0x2::coin::into_balance<T0>(arg1),
            creator         : v3,
            joiner          : 0x1::option::none<Seat>(),
            home            : new_leg(),
            away            : new_leg(),
            created_at_ms   : v1,
            expires_at_ms   : v1 + 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::open_expiry_ms<T0>(arg0),
            filled_at_ms    : 0,
            play_by_ms      : 0,
            settle_by_ms    : 0,
        };
        let v5 = 0x2::object::id<Room<T0>>(&v4);
        let v6 = RoomCreated{
            room_id         : v5,
            config_id       : v4.config_id,
            creator         : v2,
            lead_account_id : arg2,
            strategy_hash   : arg3,
            tier            : v0,
            rake_bps        : v4.rake_bps,
            leg_window_ms   : v4.leg_window_ms,
            settle_grace_ms : v4.settle_grace_ms,
            created_at_ms   : v1,
            expires_at_ms   : v4.expires_at_ms,
        };
        0x2::event::emit<RoomCreated>(v6);
        0x2::transfer::share_object<Room<T0>>(v4);
        v5
    }

    public fun created_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Room<T0>) : address {
        arg0.creator.owner
    }

    public fun creator_lead_account_id<T0>(arg0: &Room<T0>) : 0x2::object::ID {
        arg0.creator.lead_account_id
    }

    public fun creator_strategy_hash<T0>(arg0: &Room<T0>) : vector<u8> {
        arg0.creator.strategy_hash
    }

    entry fun draw_leg_seed<T0>(arg0: &mut Room<T0>, arg1: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg2: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomVerifierCap, arg3: u8, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_config<T0>(arg0, arg1);
        0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::assert_verifier<T0>(arg1, arg2);
        assert_seed_drawable<T0>(arg0, arg3, arg5);
        let v0 = 0x2::random::new_generator(arg4, arg6);
        store_leg_seed<T0>(arg0, arg3, 0x2::random::generate_bytes(&mut v0, 32), arg5);
    }

    fun emit_leg_ended<T0>(arg0: &Room<T0>, arg1: u8, arg2: bool, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64) {
        let v0 = leg_ref<T0>(arg0, arg1);
        let (v1, v2) = if (arg1 == 0) {
            (arg0.creator.owner, 0x1::option::borrow<Seat>(&arg0.joiner).owner)
        } else {
            (0x1::option::borrow<Seat>(&arg0.joiner).owner, arg0.creator.owner)
        };
        let v3 = LegSettled{
            room_id         : 0x2::object::id<Room<T0>>(arg0),
            leg             : arg1,
            attacker        : v1,
            defender        : v2,
            attacker_fuel   : v0.attacker_fuel,
            defender_fuel   : v0.defender_fuel,
            replay_digest   : v0.replay_digest,
            forfeited       : arg2,
            verifier_cap_id : arg3,
            settled_at_ms   : arg4,
        };
        0x2::event::emit<LegSettled>(v3);
    }

    public fun expire_room<T0>(arg0: &mut Room<T0>, arg1: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_config<T0>(arg0, arg1);
        assert!(arg0.status == 0, 13906835995410432015);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg0.expires_at_ms, 13906836004000628755);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.pot);
        arg0.status = 4;
        let v2 = RoomExpired{
            room_id       : 0x2::object::id<Room<T0>>(arg0),
            creator       : arg0.creator.owner,
            refund        : 0x2::balance::value<T0>(&v1),
            expired_at_ms : v0,
        };
        0x2::event::emit<RoomExpired>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg0.creator.owner);
    }

    public fun expires_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun filled_at_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.filled_at_ms
    }

    public fun finalize<T0>(arg0: &mut Room<T0>, arg1: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_config<T0>(arg0, arg1);
        assert!(arg0.status == 1, 13906836506512326683);
        assert!(arg0.home.status != 0 && arg0.away.status != 0, 13906836510808342571);
        let (v0, v1) = fuel_totals<T0>(arg0);
        let v2 = if (v0 > v1) {
            0
        } else if (v0 < v1) {
            2
        } else {
            1
        };
        let v3 = 0x2::balance::value<T0>(&arg0.pot);
        let (v4, v5, v6) = if (arg0.home.status == 2 && arg0.away.status == 2) {
            let v5 = arg0.tier;
            let v4 = arg0.tier;
            (v4, v5, 0)
        } else {
            split_pot(v3, arg0.rake_bps, v2)
        };
        let v7 = arg0.creator.owner;
        let v8 = 0x1::option::borrow<Seat>(&arg0.joiner).owner;
        let v9 = 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::house<T0>(arg1);
        arg0.status = 2;
        pay<T0>(arg0, v4, v7, arg3);
        pay<T0>(arg0, v5, v8, arg3);
        pay<T0>(arg0, v6, v9, arg3);
        let v10 = if (v2 == 0) {
            0x1::option::some<address>(v7)
        } else if (v2 == 2) {
            0x1::option::some<address>(v8)
        } else {
            0x1::option::none<address>()
        };
        let v11 = RoomSettled{
            room_id        : 0x2::object::id<Room<T0>>(arg0),
            outcome        : v2,
            winner         : v10,
            creator        : v7,
            joiner         : v8,
            creator_fuel   : v0,
            joiner_fuel    : v1,
            pot            : v3,
            creator_payout : v4,
            joiner_payout  : v5,
            house          : v9,
            house_amount   : v6,
            settled_at_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RoomSettled>(v11);
    }

    public fun forfeit_leg<T0>(arg0: &mut Room<T0>, arg1: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg2: u8, arg3: &0x2::clock::Clock) {
        assert_config<T0>(arg0, arg1);
        assert!(arg2 <= 1, 13906836412023177245);
        assert!(arg0.status == 1, 13906836416318013467);
        assert!(leg_ref<T0>(arg0, arg2).status == 0, 13906836420613898281);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.settle_by_ms, 13906836429203701799);
        let v1 = leg_mut<T0>(arg0, arg2);
        v1.status = 2;
        emit_leg_ended<T0>(arg0, arg2, true, 0x1::option::none<0x2::object::ID>(), v0);
    }

    public fun fuel_totals<T0>(arg0: &Room<T0>) : (u64, u64) {
        ((arg0.home.attacker_fuel as u64) + (arg0.away.defender_fuel as u64), (arg0.away.attacker_fuel as u64) + (arg0.home.defender_fuel as u64))
    }

    public fun join_room<T0>(arg0: &mut Room<T0>, arg1: &mut 0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::assert_accepting_rooms<T0>(arg1);
        assert!(arg0.config_id == 0x2::object::id<0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>>(arg1), 13906835716237164553);
        assert!(arg0.status == 0, 13906835720532525071);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 <= arg0.expires_at_ms, 13906835729122590737);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(v1 != arg0.creator.owner, 13906835737712918551);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906835742007099403);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.tier, 13906835746302984217);
        0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::assert_pair_room_allowed<T0>(arg1, arg0.creator.owner, v1, v0);
        0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::record_pair_room<T0>(arg1, arg0.creator.owner, v1, v0);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg2));
        let v2 = Seat{
            owner           : v1,
            lead_account_id : arg3,
            strategy_hash   : arg4,
        };
        0x1::option::fill<Seat>(&mut arg0.joiner, v2);
        arg0.filled_at_ms = v0;
        arg0.play_by_ms = v0 + arg0.leg_window_ms;
        arg0.settle_by_ms = arg0.play_by_ms + arg0.settle_grace_ms;
        arg0.status = 1;
        let v3 = RoomJoined{
            room_id         : 0x2::object::id<Room<T0>>(arg0),
            creator         : arg0.creator.owner,
            joiner          : v1,
            lead_account_id : arg3,
            strategy_hash   : arg4,
            tier            : arg0.tier,
            pot             : 0x2::balance::value<T0>(&arg0.pot),
            filled_at_ms    : v0,
            play_by_ms      : arg0.play_by_ms,
            settle_by_ms    : arg0.settle_by_ms,
        };
        0x2::event::emit<RoomJoined>(v3);
    }

    public fun joiner<T0>(arg0: &Room<T0>) : 0x1::option::Option<address> {
        let v0 = &arg0.joiner;
        if (0x1::option::is_some<Seat>(v0)) {
            0x1::option::some<address>(0x1::option::borrow<Seat>(v0).owner)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun joiner_lead_account_id<T0>(arg0: &Room<T0>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = &arg0.joiner;
        if (0x1::option::is_some<Seat>(v0)) {
            0x1::option::some<0x2::object::ID>(0x1::option::borrow<Seat>(v0).lead_account_id)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun joiner_strategy_hash<T0>(arg0: &Room<T0>) : 0x1::option::Option<vector<u8>> {
        let v0 = &arg0.joiner;
        if (0x1::option::is_some<Seat>(v0)) {
            0x1::option::some<vector<u8>>(0x1::option::borrow<Seat>(v0).strategy_hash)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun leg_attacker<T0>(arg0: &Room<T0>, arg1: u8) : 0x1::option::Option<address> {
        assert!(arg1 <= 1, 13906836828635004957);
        if (arg1 == 0) {
            0x1::option::some<address>(arg0.creator.owner)
        } else {
            joiner<T0>(arg0)
        }
    }

    public fun leg_attacker_fuel<T0>(arg0: &Room<T0>, arg1: u8) : u8 {
        leg_ref<T0>(arg0, arg1).attacker_fuel
    }

    public fun leg_defender_fuel<T0>(arg0: &Room<T0>, arg1: u8) : u8 {
        leg_ref<T0>(arg0, arg1).defender_fuel
    }

    fun leg_mut<T0>(arg0: &mut Room<T0>, arg1: u8) : &mut Leg {
        if (arg1 == 0) {
            &mut arg0.home
        } else {
            &mut arg0.away
        }
    }

    fun leg_ref<T0>(arg0: &Room<T0>, arg1: u8) : &Leg {
        assert!(arg1 <= 1, 13906837167937421341);
        if (arg1 == 0) {
            &arg0.home
        } else {
            &arg0.away
        }
    }

    public fun leg_replay_digest<T0>(arg0: &Room<T0>, arg1: u8) : vector<u8> {
        leg_ref<T0>(arg0, arg1).replay_digest
    }

    public fun leg_seed<T0>(arg0: &Room<T0>, arg1: u8) : vector<u8> {
        leg_ref<T0>(arg0, arg1).seed
    }

    public fun leg_status<T0>(arg0: &Room<T0>, arg1: u8) : u8 {
        leg_ref<T0>(arg0, arg1).status
    }

    fun new_leg() : Leg {
        Leg{
            seed          : b"",
            status        : 0,
            attacker_fuel : 0,
            defender_fuel : 0,
            replay_digest : b"",
        }
    }

    fun pay<T0>(arg0: &mut Room<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, arg1), arg3), arg2);
    }

    public fun play_by_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.play_by_ms
    }

    public fun pot_value<T0>(arg0: &Room<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    public fun settle_by_ms<T0>(arg0: &Room<T0>) : u64 {
        arg0.settle_by_ms
    }

    public fun settle_leg<T0>(arg0: &mut Room<T0>, arg1: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomConfig<T0>, arg2: &0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomVerifierCap, arg3: u8, arg4: u8, arg5: u8, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        assert_config<T0>(arg0, arg1);
        0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::assert_verifier<T0>(arg1, arg2);
        assert!(arg3 <= 1, 13906836274584223773);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906836278879322143);
        assert!(arg0.status == 1 || arg0.status == 2, 13906836283174027291);
        let v0 = leg_ref<T0>(arg0, arg3);
        if (v0.status == 1) {
            let v1 = if (v0.attacker_fuel == arg4) {
                if (v0.defender_fuel == arg5) {
                    v0.replay_digest == arg6
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 13906836313239191585);
            return
        };
        assert!(v0.status == 0, 13906836330419191843);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        assert!(v2 <= arg0.settle_by_ms, 13906836339009257509);
        assert!(!0x1::vector::is_empty<u8>(&v0.seed), 13906836343304880175);
        let v3 = leg_mut<T0>(arg0, arg3);
        v3.status = 1;
        v3.attacker_fuel = arg4;
        v3.defender_fuel = arg5;
        v3.replay_digest = arg6;
        emit_leg_ended<T0>(arg0, arg3, false, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x98d2af8ee71c5d9e5c2a83d27238dedd54685d306598fdf8985b63e1b4e63703::config::RoomVerifierCap>(arg2)), v2);
    }

    fun split_pot(arg0: u64, arg1: u64, arg2: u8) : (u64, u64, u64) {
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        if (arg2 == 1) {
            let v4 = (arg0 - v0) / 2;
            (v4, v4, arg0 - 2 * v4)
        } else {
            let (v5, v6) = if (arg2 == 0) {
                (arg0 - v0, 0)
            } else {
                (0, arg0 - v0)
            };
            (v5, v6, v0)
        }
    }

    public fun status<T0>(arg0: &Room<T0>) : u8 {
        arg0.status
    }

    fun store_leg_seed<T0>(arg0: &mut Room<T0>, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = leg_mut<T0>(arg0, arg1);
        v0.seed = arg2;
        let v1 = if (arg1 == 0) {
            arg0.creator.owner
        } else {
            0x1::option::borrow<Seat>(&arg0.joiner).owner
        };
        let v2 = LegSeedDrawn{
            room_id     : 0x2::object::id<Room<T0>>(arg0),
            leg         : arg1,
            attacker    : v1,
            seed        : arg2,
            drawn_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LegSeedDrawn>(v2);
    }

    public fun tier<T0>(arg0: &Room<T0>) : u64 {
        arg0.tier
    }

    // decompiled from Move bytecode v7
}

