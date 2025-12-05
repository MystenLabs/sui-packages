module 0xf049539c93a89ce031133f7f448564333efc60e9c7543d4c87f1203db09a51b3::asphalt_surfer {
    struct ConcreteWave has key {
        id: 0x2::object::UID,
        park_name: 0x1::string::String,
        riders: 0x2::object_table::ObjectTable<address, RiderProfile>,
    }

    struct RiderProfile has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        stunts_mastered: vector<Stunt>,
        style_points: u32,
        total_bails: u16,
    }

    struct Stunt has copy, drop, store {
        stunt_name: 0x1::string::String,
        difficulty: u8,
        attempts_until_landed: u16,
    }

    public fun build_park(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ConcreteWave{
            id        : 0x2::object::new(arg1),
            park_name : arg0,
            riders    : 0x2::object_table::new<address, RiderProfile>(arg1),
        };
        0x2::transfer::share_object<ConcreteWave>(v0);
    }

    public fun get_points(arg0: &ConcreteWave, arg1: address) : u32 {
        0x2::object_table::borrow<address, RiderProfile>(&arg0.riders, arg1).style_points
    }

    public fun is_pro(arg0: &ConcreteWave, arg1: address) : bool {
        0x2::object_table::borrow<address, RiderProfile>(&arg0.riders, arg1).style_points > 500
    }

    public fun learn_stunt(arg0: &mut ConcreteWave, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: u16) {
        let v0 = 0x2::object_table::borrow_mut<address, RiderProfile>(&mut arg0.riders, arg1);
        let v1 = Stunt{
            stunt_name            : arg2,
            difficulty            : arg3,
            attempts_until_landed : arg4,
        };
        0x1::vector::push_back<Stunt>(&mut v0.stunts_mastered, v1);
        v0.style_points = v0.style_points + (arg3 as u32) * 10;
    }

    public fun log_bail(arg0: &mut ConcreteWave, arg1: address) {
        let v0 = 0x2::object_table::borrow_mut<address, RiderProfile>(&mut arg0.riders, arg1);
        v0.total_bails = v0.total_bails + 1;
    }

    public fun register_rider(arg0: &mut ConcreteWave, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RiderProfile{
            id              : 0x2::object::new(arg2),
            name            : arg1,
            stunts_mastered : 0x1::vector::empty<Stunt>(),
            style_points    : 0,
            total_bails     : 0,
        };
        0x2::object_table::add<address, RiderProfile>(&mut arg0.riders, 0x2::tx_context::sender(arg2), v0);
    }

    public fun total_stunts(arg0: &ConcreteWave, arg1: address) : u64 {
        0x1::vector::length<Stunt>(&0x2::object_table::borrow<address, RiderProfile>(&arg0.riders, arg1).stunts_mastered)
    }

    // decompiled from Move bytecode v6
}

