module 0x23a10fe5bd4a7b78087d6e716a1e810168e0b3332ff022637606a02d001fc9f1::vessel {
    struct Vessel has store, key {
        id: 0x2::object::UID,
        harbor_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        created_at: u64,
        last_cast: u64,
        cast_count: u64,
        active_dock: address,
        burn_after_cast: bool,
    }

    struct VesselCap has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        harbor_id: 0x2::object::ID,
        owner: address,
        tier: u8,
    }

    struct VesselLaunched has copy, drop {
        vessel_id: address,
        harbor_id: address,
        tier: u8,
        launched_at: u64,
        burn_after_cast: bool,
    }

    struct VesselActive has copy, drop {
        vessel_id: address,
        cast_count: u64,
        expires_at: u64,
    }

    struct VesselSunk has copy, drop {
        vessel_id: address,
        cast_count: u64,
        sunk_at: u64,
        reason: u8,
    }

    struct VesselDockedIn has copy, drop {
        vessel_id: address,
        dock_id: address,
        docked_at: u64,
    }

    struct VesselDockedOut has copy, drop {
        vessel_id: address,
        dock_id: address,
        undocked_at: u64,
    }

    public fun active_dock(arg0: &Vessel) : address {
        arg0.active_dock
    }

    public fun assert_alive(arg0: &Vessel, arg1: &0x2::clock::Clock) {
        assert!(is_alive(arg0, arg1), 1);
    }

    public fun burn_after_cast(arg0: &Vessel) : bool {
        arg0.burn_after_cast
    }

    public fun cast_count(arg0: &Vessel) : u64 {
        arg0.cast_count
    }

    public fun enter_dock(arg0: &mut Vessel, arg1: &VesselCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.vessel_id == 0x2::object::id<Vessel>(arg0), 2);
        assert!(is_alive(arg0, arg3), 1);
        assert!(arg0.active_dock == @0x0, 4);
        arg0.active_dock = arg2;
        let v0 = 0x2::object::id<Vessel>(arg0);
        let v1 = VesselDockedIn{
            vessel_id : 0x2::object::id_to_address(&v0),
            dock_id   : arg2,
            docked_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VesselDockedIn>(v1);
    }

    public fun expires_at(arg0: &Vessel) : u64 {
        arg0.last_cast + 31536000000
    }

    public fun ghost() : u8 {
        0
    }

    public fun harbor_id(arg0: &Vessel) : 0x2::object::ID {
        arg0.harbor_id
    }

    public fun in_dock(arg0: &Vessel) : bool {
        arg0.active_dock != @0x0
    }

    public fun is_alive(arg0: &Vessel, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.last_cast + 31536000000
    }

    public fun last_cast(arg0: &Vessel) : u64 {
        arg0.last_cast
    }

    public fun launch(arg0: 0x2::object::ID, arg1: u8, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VesselCap {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = Vessel{
            id              : 0x2::object::new(arg4),
            harbor_id       : arg0,
            owner           : v1,
            tier            : arg1,
            created_at      : v2,
            last_cast       : v2,
            cast_count      : 0,
            active_dock     : @0x0,
            burn_after_cast : arg2,
        };
        let v4 = 0x2::object::id<Vessel>(&v3);
        let v5 = VesselLaunched{
            vessel_id       : 0x2::object::id_to_address(&v4),
            harbor_id       : 0x2::object::id_to_address(&arg0),
            tier            : arg1,
            launched_at     : v2,
            burn_after_cast : arg2,
        };
        0x2::event::emit<VesselLaunched>(v5);
        let v6 = VesselCap{
            id        : 0x2::object::new(arg4),
            vessel_id : v4,
            harbor_id : arg0,
            owner     : v1,
            tier      : arg1,
        };
        0x2::transfer::transfer<Vessel>(v3, v1);
        v6
    }

    public fun leave_dock(arg0: &mut Vessel, arg1: &VesselCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.vessel_id == 0x2::object::id<Vessel>(arg0), 2);
        arg0.active_dock = @0x0;
        let v0 = 0x2::object::id<Vessel>(arg0);
        let v1 = VesselDockedOut{
            vessel_id   : 0x2::object::id_to_address(&v0),
            dock_id     : arg0.active_dock,
            undocked_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VesselDockedOut>(v1);
    }

    public fun open() : u8 {
        2
    }

    public fun owner(arg0: &Vessel) : address {
        arg0.owner
    }

    public fun shadow() : u8 {
        1
    }

    public fun sink(arg0: Vessel, arg1: VesselCap, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.vessel_id == 0x2::object::id<Vessel>(&arg0), 2);
        let v0 = 0x2::object::id<Vessel>(&arg0);
        let Vessel {
            id              : v1,
            harbor_id       : _,
            owner           : _,
            tier            : _,
            created_at      : _,
            last_cast       : _,
            cast_count      : _,
            active_dock     : _,
            burn_after_cast : _,
        } = arg0;
        let VesselCap {
            id        : v10,
            vessel_id : _,
            harbor_id : _,
            owner     : _,
            tier      : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::object::delete(v10);
        let v15 = VesselSunk{
            vessel_id  : 0x2::object::id_to_address(&v0),
            cast_count : arg0.cast_count,
            sunk_at    : 0x2::clock::timestamp_ms(arg3),
            reason     : arg2,
        };
        0x2::event::emit<VesselSunk>(v15);
    }

    public fun tier(arg0: &Vessel) : u8 {
        arg0.tier
    }

    public fun touch(arg0: &mut Vessel, arg1: &VesselCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : bool {
        assert!(arg1.vessel_id == 0x2::object::id<Vessel>(arg0), 2);
        assert!(is_alive(arg0, arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.last_cast = v0;
        arg0.cast_count = arg0.cast_count + 1;
        let v1 = 0x2::object::id<Vessel>(arg0);
        let v2 = VesselActive{
            vessel_id  : 0x2::object::id_to_address(&v1),
            cast_count : arg0.cast_count,
            expires_at : v0 + 31536000000,
        };
        0x2::event::emit<VesselActive>(v2);
        arg0.burn_after_cast
    }

    // decompiled from Move bytecode v7
}

