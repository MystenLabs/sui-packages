module 0x91128127586a561edb2bff07bbe6331ebc4d3781f6628e56b31c8ac19da15ec8::spin_the_wheel {
    struct WheelSpinEvent has copy, drop {
        player: address,
        points_won: u64,
        random_num: u64,
        current_timestamp: u64,
        next_spin_time: u64,
    }

    struct SpinWheel has key {
        id: 0x2::object::UID,
        player_spins: 0x2::table::Table<address, LastSpin>,
    }

    struct LastSpin has store {
        last_spin_time: u64,
        points_earned: u64,
    }

    public entry fun can_spin(arg0: &SpinWheel, arg1: address, arg2: &0x2::clock::Clock) : bool {
        !0x2::table::contains<address, LastSpin>(&arg0.player_spins, arg1) || 0x2::clock::timestamp_ms(arg2) >= 0x2::table::borrow<address, LastSpin>(&arg0.player_spins, arg1).last_spin_time + 86400000
    }

    fun generate_weighted_points(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, 99);
        let v2 = if (v1 < 10) {
            0
        } else if (v1 < 35) {
            5
        } else if (v1 < 60) {
            10
        } else if (v1 < 85) {
            20
        } else if (v1 < 95) {
            40
        } else {
            60
        };
        (v2, v1)
    }

    public entry fun get_last_spin_time(arg0: &SpinWheel, arg1: address) : u64 {
        if (!0x2::table::contains<address, LastSpin>(&arg0.player_spins, arg1)) {
            0
        } else {
            0x2::table::borrow<address, LastSpin>(&arg0.player_spins, arg1).last_spin_time
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpinWheel{
            id           : 0x2::object::new(arg0),
            player_spins : 0x2::table::new<address, LastSpin>(arg0),
        };
        0x2::transfer::share_object<SpinWheel>(v0);
    }

    public fun spin(arg0: &mut SpinWheel, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let (v2, v3) = if (!0x2::table::contains<address, LastSpin>(&arg0.player_spins, v0)) {
            let (v4, v5) = generate_weighted_points(arg2, arg3);
            let v6 = LastSpin{
                last_spin_time : v1,
                points_earned  : v4,
            };
            0x2::table::add<address, LastSpin>(&mut arg0.player_spins, v0, v6);
            (v4, v5)
        } else {
            if (v1 < 0x2::table::borrow<address, LastSpin>(&arg0.player_spins, v0).last_spin_time + 86400000) {
                abort 0
            };
            let (v7, v8) = generate_weighted_points(arg2, arg3);
            let v9 = 0x2::table::borrow_mut<address, LastSpin>(&mut arg0.player_spins, v0);
            v9.last_spin_time = v1;
            v9.points_earned = v7;
            (v7, v8)
        };
        let v10 = WheelSpinEvent{
            player            : v0,
            points_won        : v2,
            random_num        : v3,
            current_timestamp : v1,
            next_spin_time    : v1 + 86400000,
        };
        0x2::event::emit<WheelSpinEvent>(v10);
    }

    // decompiled from Move bytecode v6
}

