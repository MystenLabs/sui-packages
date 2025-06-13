module 0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::phase {
    struct PhaseCreated has copy, drop {
        phase_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        is_public: bool,
    }

    struct PhaseDeleted has copy, drop {
        phase_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct Phase has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        is_public: bool,
    }

    public fun new(arg0: &0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::collection::Collection, arg1: &0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::admin::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < arg5, 2);
        let v0 = 0x2::object::id<0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::collection::Collection>(arg0);
        let v1 = 0x2::object::new(arg7);
        let v2 = PhaseCreated{
            phase_id      : 0x2::object::uid_to_inner(&v1),
            collection_id : v0,
            name          : arg2,
            start_time    : arg4,
            end_time      : arg5,
            is_public     : arg6,
        };
        0x2::event::emit<PhaseCreated>(v2);
        let v3 = Phase{
            id            : v1,
            collection_id : v0,
            name          : arg2,
            description   : arg3,
            start_time    : arg4,
            end_time      : arg5,
            is_public     : arg6,
        };
        0x2::transfer::share_object<Phase>(v3);
    }

    public fun collection_id(arg0: &Phase) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun delete_phase(arg0: Phase, arg1: &0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::admin::AdminCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let Phase {
            id            : v1,
            collection_id : v2,
            name          : v3,
            description   : _,
            start_time    : v5,
            end_time      : v6,
            is_public     : _,
        } = arg0;
        assert!(v0 < v5 || v0 > v6, 0);
        0x2::object::delete(v1);
        let v8 = PhaseDeleted{
            phase_id      : 0x2::object::uid_to_inner(&arg0.id),
            collection_id : v2,
            name          : v3,
        };
        0x2::event::emit<PhaseDeleted>(v8);
    }

    public fun description(arg0: &Phase) : 0x1::string::String {
        arg0.description
    }

    public fun end_time(arg0: &Phase) : u64 {
        arg0.end_time
    }

    public fun is_mint_active(arg0: &Phase, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.start_time && v0 <= arg0.end_time
    }

    public fun name(arg0: &Phase) : 0x1::string::String {
        arg0.name
    }

    public fun phase_id(arg0: &Phase) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun start_time(arg0: &Phase) : u64 {
        arg0.start_time
    }

    public fun update_metadata(arg0: &mut Phase, arg1: &0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::admin::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg0.name = arg2;
        arg0.description = arg3;
    }

    public fun update_timing(arg0: &mut Phase, arg1: &0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::admin::AdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2 < arg3, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg0.start_time || v0 > arg0.end_time, 0);
        arg0.start_time = arg2;
        arg0.end_time = arg3;
    }

    public(friend) fun validate_and_record_mint(arg0: &Phase, arg1: &0x2::clock::Clock) {
        assert!(is_mint_active(arg0, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

