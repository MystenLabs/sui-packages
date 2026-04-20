module 0x8cde30c2af7523193689e2f3eaca6dc4fadf6fd486471a6c31b14bc9db5164b2::dock {
    struct Dock has key {
        id: 0x2::object::UID,
        owner_vessel_id: 0x2::object::ID,
        owner: address,
        seal_key_id: vector<u8>,
        created_at: u64,
        last_cast: u64,
        cast_count: u64,
        vessel_count: u64,
        active_vessels: 0x2::vec_set::VecSet<0x2::object::ID>,
        has_siren: bool,
    }

    struct DockCap has store, key {
        id: 0x2::object::UID,
        dock_id: 0x2::object::ID,
        owner: address,
    }

    struct DockOpened has copy, drop {
        dock_id: address,
        owner: address,
        opened_at: u64,
        expires_at: u64,
    }

    struct DockCastSent has copy, drop {
        dock_id: address,
        burn: bool,
        has_media: bool,
        sent_at: u64,
        expires_at: u64,
    }

    struct VesselEntered has copy, drop {
        dock_id: address,
        vessel_id: address,
        entered_at: u64,
    }

    struct VesselLeft has copy, drop {
        dock_id: address,
        vessel_id: address,
        left_at: u64,
    }

    struct DockCrumbled has copy, drop {
        dock_id: address,
        cast_count: u64,
        crumbled_at: u64,
    }

    public fun attach_siren(arg0: &mut Dock, arg1: &DockCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.dock_id == 0x2::object::id<Dock>(arg0), 2);
        arg0.has_siren = true;
    }

    public fun cast_count(arg0: &Dock) : u64 {
        arg0.cast_count
    }

    public fun cast_inside(arg0: &mut Dock, arg1: 0x2::object::ID, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(is_alive(arg0, arg4), 1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.active_vessels, &arg1), 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.last_cast = v0;
        arg0.cast_count = arg0.cast_count + 1;
        let v1 = 0x2::object::id<Dock>(arg0);
        let v2 = DockCastSent{
            dock_id    : 0x2::object::id_to_address(&v1),
            burn       : arg2,
            has_media  : arg3,
            sent_at    : v0,
            expires_at : v0 + 2592000000,
        };
        0x2::event::emit<DockCastSent>(v2);
    }

    public fun crumble(arg0: Dock, arg1: DockCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.dock_id == 0x2::object::id<Dock>(&arg0), 2);
        let v0 = 0x2::object::id<Dock>(&arg0);
        let Dock {
            id              : v1,
            owner_vessel_id : _,
            owner           : _,
            seal_key_id     : _,
            created_at      : _,
            last_cast       : _,
            cast_count      : _,
            vessel_count    : _,
            active_vessels  : _,
            has_siren       : _,
        } = arg0;
        let DockCap {
            id      : v11,
            dock_id : _,
            owner   : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::object::delete(v11);
        let v14 = DockCrumbled{
            dock_id     : 0x2::object::id_to_address(&v0),
            cast_count  : arg0.cast_count,
            crumbled_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DockCrumbled>(v14);
    }

    public fun enter(arg0: &mut Dock, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(is_alive(arg0, arg2), 1);
        assert!(arg0.vessel_count < 50, 3);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.active_vessels, &arg1), 4);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_vessels, arg1);
        arg0.vessel_count = arg0.vessel_count + 1;
        arg0.last_cast = 0x2::clock::timestamp_ms(arg2);
        let v0 = 0x2::object::id<Dock>(arg0);
        let v1 = VesselEntered{
            dock_id    : 0x2::object::id_to_address(&v0),
            vessel_id  : 0x2::object::id_to_address(&arg1),
            entered_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VesselEntered>(v1);
    }

    public fun expires_at(arg0: &Dock) : u64 {
        arg0.last_cast + 2592000000
    }

    public fun has_siren(arg0: &Dock) : bool {
        arg0.has_siren
    }

    public fun is_alive(arg0: &Dock, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.last_cast + 2592000000
    }

    public fun last_cast(arg0: &Dock) : u64 {
        arg0.last_cast
    }

    public fun leave(arg0: &mut Dock, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.active_vessels, &arg1), 5);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_vessels, &arg1);
        let v0 = 0x2::object::id<Dock>(arg0);
        let v1 = VesselLeft{
            dock_id   : 0x2::object::id_to_address(&v0),
            vessel_id : 0x2::object::id_to_address(&arg1),
            left_at   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VesselLeft>(v1);
    }

    public fun open(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : DockCap {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Dock{
            id              : 0x2::object::new(arg3),
            owner_vessel_id : arg0,
            owner           : v0,
            seal_key_id     : arg1,
            created_at      : v1,
            last_cast       : v1,
            cast_count      : 0,
            vessel_count    : 0,
            active_vessels  : 0x2::vec_set::empty<0x2::object::ID>(),
            has_siren       : false,
        };
        let v3 = 0x2::object::id<Dock>(&v2);
        let v4 = DockOpened{
            dock_id    : 0x2::object::id_to_address(&v3),
            owner      : v0,
            opened_at  : v1,
            expires_at : v1 + 2592000000,
        };
        0x2::event::emit<DockOpened>(v4);
        let v5 = DockCap{
            id      : 0x2::object::new(arg3),
            dock_id : v3,
            owner   : v0,
        };
        0x2::transfer::share_object<Dock>(v2);
        v5
    }

    public fun vessel_count(arg0: &Dock) : u64 {
        arg0.vessel_count
    }

    // decompiled from Move bytecode v7
}

