module 0x313d461e1eb560b5215d9ac61f02e7f2413ddfca3d000df76ea3fa39ab680663::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        hair_type: vector<u8>,
        hair_length: vector<u8>,
        hair_texture: vector<u8>,
        owner: address,
        created_at: u64,
    }

    struct ProfileCreated has drop {
        profile_id: 0x2::object::ID,
        owner: address,
    }

    struct Treatment has store, key {
        id: 0x2::object::UID,
        treatment_type: vector<u8>,
        owner: address,
        timestamp: u64,
    }

    struct TreatmentRegistered has drop {
        treatment_id: 0x2::object::ID,
        treatment_type: vector<u8>,
        owner: address,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        event_type: vector<u8>,
        date: vector<u8>,
        description: vector<u8>,
        materials: vector<u8>,
        location: vector<u8>,
        cm_cut: vector<u8>,
        owner: address,
        timestamp: u64,
    }

    struct EventRegistered has drop {
        event_id: 0x2::object::ID,
        event_type: vector<u8>,
        owner: address,
    }

    public fun create_profile(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Profile {
        Profile{
            id           : 0x2::object::new(arg3),
            hair_type    : arg0,
            hair_length  : arg1,
            hair_texture : arg2,
            owner        : 0x2::tx_context::sender(arg3),
            created_at   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        }
    }

    public fun get_created_at(arg0: &Profile) : u64 {
        arg0.created_at
    }

    public fun get_event_date(arg0: &Event) : vector<u8> {
        arg0.date
    }

    public fun get_event_owner(arg0: &Event) : address {
        arg0.owner
    }

    public fun get_event_timestamp(arg0: &Event) : u64 {
        arg0.timestamp
    }

    public fun get_event_type(arg0: &Event) : vector<u8> {
        arg0.event_type
    }

    public fun get_hair_length(arg0: &Profile) : vector<u8> {
        arg0.hair_length
    }

    public fun get_hair_texture(arg0: &Profile) : vector<u8> {
        arg0.hair_texture
    }

    public fun get_hair_type(arg0: &Profile) : vector<u8> {
        arg0.hair_type
    }

    public fun get_owner(arg0: &Profile) : address {
        arg0.owner
    }

    public fun get_treatment_owner(arg0: &Treatment) : address {
        arg0.owner
    }

    public fun get_treatment_timestamp(arg0: &Treatment) : u64 {
        arg0.timestamp
    }

    public fun get_treatment_type(arg0: &Treatment) : vector<u8> {
        arg0.treatment_type
    }

    public fun register_event(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : Event {
        Event{
            id          : 0x2::object::new(arg6),
            event_type  : arg0,
            date        : arg1,
            description : arg2,
            materials   : arg3,
            location    : arg4,
            cm_cut      : arg5,
            owner       : 0x2::tx_context::sender(arg6),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg6),
        }
    }

    public fun register_treatment(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Treatment {
        Treatment{
            id             : 0x2::object::new(arg1),
            treatment_type : arg0,
            owner          : 0x2::tx_context::sender(arg1),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg1),
        }
    }

    public fun update_hair_length(arg0: &mut Profile, arg1: vector<u8>) {
        arg0.hair_length = arg1;
    }

    public fun update_hair_texture(arg0: &mut Profile, arg1: vector<u8>) {
        arg0.hair_texture = arg1;
    }

    public fun update_hair_type(arg0: &mut Profile, arg1: vector<u8>) {
        arg0.hair_type = arg1;
    }

    // decompiled from Move bytecode v6
}

