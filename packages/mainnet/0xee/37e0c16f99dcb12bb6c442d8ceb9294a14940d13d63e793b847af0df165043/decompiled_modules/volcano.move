module 0xee37e0c16f99dcb12bb6c442d8ceb9294a14940d13d63e793b847af0df165043::volcano {
    struct UserStats has store {
        total_increases: u64,
        total_decreases: u64,
        last_action: u64,
    }

    struct Volcano has store, key {
        id: 0x2::object::UID,
        eruption_level: u64,
        total_eruptions: u64,
        total_decreases: u64,
        user_stats: 0x2::vec_map::VecMap<address, UserStats>,
        target_eruption_level: u64,
        admin: address,
    }

    struct EruptionIncreased has copy, drop {
        user: address,
        amount: u64,
        new_level: u64,
        total_increases: u64,
    }

    struct EruptionDecreased has copy, drop {
        user: address,
        amount: u64,
        new_level: u64,
        total_decreases: u64,
    }

    struct VolcanoErupted has copy, drop {
        user: address,
        level: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Volcano {
        Volcano{
            id                    : 0x2::object::new(arg0),
            eruption_level        : 0,
            total_eruptions       : 0,
            total_decreases       : 0,
            user_stats            : 0x2::vec_map::empty<address, UserStats>(),
            target_eruption_level : 10000000,
            admin                 : @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a,
        }
    }

    public entry fun create_shared(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a, 100);
        let v0 = Volcano{
            id                    : 0x2::object::new(arg0),
            eruption_level        : 0,
            total_eruptions       : 0,
            total_decreases       : 0,
            user_stats            : 0x2::vec_map::empty<address, UserStats>(),
            target_eruption_level : 10000000,
            admin                 : @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a,
        };
        0x2::transfer::share_object<Volcano>(v0);
    }

    public entry fun decrease_eruption(arg0: &mut Volcano, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg0.eruption_level > 0, 42);
        assert!(arg0.eruption_level < arg0.target_eruption_level, 43);
        assert!(arg0.eruption_level >= arg2, 2);
        let v0 = arg2 * 100000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a);
        let v1 = 0x2::tx_context::sender(arg3);
        get_or_create_user_stats(arg0, v1);
        let v2 = 0x2::vec_map::get_mut<address, UserStats>(&mut arg0.user_stats, &v1);
        v2.total_decreases = v2.total_decreases + arg2;
        v2.last_action = 0x2::tx_context::epoch(arg3);
        arg0.eruption_level = arg0.eruption_level - arg2;
        arg0.total_decreases = arg0.total_decreases + arg2;
        let v3 = EruptionDecreased{
            user            : v1,
            amount          : arg2,
            new_level       : arg0.eruption_level,
            total_decreases : v2.total_decreases,
        };
        0x2::event::emit<EruptionDecreased>(v3);
    }

    public fun get_eruption_level(arg0: &Volcano) : u64 {
        arg0.eruption_level
    }

    fun get_or_create_user_stats(arg0: &mut Volcano, arg1: address) {
        if (!0x2::vec_map::contains<address, UserStats>(&arg0.user_stats, &arg1)) {
            let v0 = UserStats{
                total_increases : 0,
                total_decreases : 0,
                last_action     : 0,
            };
            0x2::vec_map::insert<address, UserStats>(&mut arg0.user_stats, arg1, v0);
        };
    }

    public fun get_target_eruption_level(arg0: &Volcano) : u64 {
        arg0.target_eruption_level
    }

    public fun get_total_stats(arg0: &Volcano) : (u64, u64) {
        (arg0.total_eruptions, arg0.total_decreases)
    }

    public fun get_user_stats(arg0: &Volcano, arg1: address) : (u64, u64, u64) {
        if (!0x2::vec_map::contains<address, UserStats>(&arg0.user_stats, &arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::vec_map::get<address, UserStats>(&arg0.user_stats, &arg1);
        (v0.total_increases, v0.total_decreases, v0.last_action)
    }

    public entry fun increase_eruption(arg0: &mut Volcano, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg0.eruption_level < arg0.target_eruption_level, 43);
        let v0 = arg2 * 100000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a);
        let v1 = 0x2::tx_context::sender(arg3);
        get_or_create_user_stats(arg0, v1);
        let v2 = 0x2::vec_map::get_mut<address, UserStats>(&mut arg0.user_stats, &v1);
        v2.total_increases = v2.total_increases + arg2;
        v2.last_action = 0x2::tx_context::epoch(arg3);
        arg0.eruption_level = arg0.eruption_level + arg2;
        arg0.total_eruptions = arg0.total_eruptions + arg2;
        if (arg0.eruption_level >= arg0.target_eruption_level) {
            let v3 = VolcanoErupted{
                user  : v1,
                level : arg0.eruption_level,
            };
            0x2::event::emit<VolcanoErupted>(v3);
        };
        let v4 = EruptionIncreased{
            user            : v1,
            amount          : arg2,
            new_level       : arg0.eruption_level,
            total_increases : v2.total_increases,
        };
        0x2::event::emit<EruptionIncreased>(v4);
    }

    // decompiled from Move bytecode v6
}

