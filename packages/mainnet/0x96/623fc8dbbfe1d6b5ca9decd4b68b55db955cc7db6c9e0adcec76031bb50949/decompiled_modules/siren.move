module 0x8cde30c2af7523193689e2f3eaca6dc4fadf6fd486471a6c31b14bc9db5164b2::siren {
    struct Siren has key {
        id: 0x2::object::UID,
        owner_vessel_id: 0x2::object::ID,
        owner: address,
        dock_id: 0x2::object::ID,
        hook: vector<u8>,
        created_at: u64,
        last_response: u64,
        response_count: u64,
    }

    struct SirenSounded has copy, drop {
        siren_id: address,
        dock_id: address,
        hook: vector<u8>,
        sounded_at: u64,
        expires_at: u64,
    }

    struct SirenAnswered has copy, drop {
        siren_id: address,
        dock_id: address,
        answered_at: u64,
        expires_at: u64,
    }

    struct SirenDark has copy, drop {
        siren_id: address,
        dark_at: u64,
    }

    public fun answer(arg0: &mut Siren, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_alive(arg0, arg1), 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.response_count = arg0.response_count + 1;
        arg0.last_response = v0;
        let v1 = 0x2::object::id<Siren>(arg0);
        let v2 = SirenAnswered{
            siren_id    : 0x2::object::id_to_address(&v1),
            dock_id     : 0x2::object::id_to_address(&arg0.dock_id),
            answered_at : v0,
            expires_at  : v0 + 2592000000,
        };
        0x2::event::emit<SirenAnswered>(v2);
        arg0.dock_id
    }

    public fun dock_id(arg0: &Siren) : 0x2::object::ID {
        arg0.dock_id
    }

    public fun expires_at(arg0: &Siren) : u64 {
        arg0.last_response + 2592000000
    }

    public fun go_dark(arg0: Siren, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner_vessel_id == arg1, 2);
        let v0 = 0x2::object::id<Siren>(&arg0);
        let Siren {
            id              : v1,
            owner_vessel_id : _,
            owner           : _,
            dock_id         : _,
            hook            : _,
            created_at      : _,
            last_response   : _,
            response_count  : _,
        } = arg0;
        0x2::object::delete(v1);
        let v9 = SirenDark{
            siren_id : 0x2::object::id_to_address(&v0),
            dark_at  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SirenDark>(v9);
    }

    public fun hook(arg0: &Siren) : vector<u8> {
        arg0.hook
    }

    public fun is_alive(arg0: &Siren, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.last_response + 2592000000
    }

    public fun response_count(arg0: &Siren) : u64 {
        arg0.response_count
    }

    public fun sound(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = Siren{
            id              : 0x2::object::new(arg4),
            owner_vessel_id : arg0,
            owner           : 0x2::tx_context::sender(arg4),
            dock_id         : arg1,
            hook            : arg2,
            created_at      : v0,
            last_response   : v0,
            response_count  : 0,
        };
        let v2 = 0x2::object::id<Siren>(&v1);
        let v3 = SirenSounded{
            siren_id   : 0x2::object::id_to_address(&v2),
            dock_id    : 0x2::object::id_to_address(&arg1),
            hook       : v1.hook,
            sounded_at : v0,
            expires_at : v0 + 2592000000,
        };
        0x2::event::emit<SirenSounded>(v3);
        0x2::transfer::share_object<Siren>(v1);
    }

    // decompiled from Move bytecode v7
}

