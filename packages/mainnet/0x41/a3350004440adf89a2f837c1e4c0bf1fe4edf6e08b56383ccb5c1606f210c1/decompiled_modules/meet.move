module 0x41a3350004440adf89a2f837c1e4c0bf1fe4edf6e08b56383ccb5c1606f210c1::meet {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MEET has drop {
        dummy_field: bool,
    }

    struct Meet has store, key {
        id: 0x2::object::UID,
        location: 0x1::string::String,
        date: 0x1::string::String,
        description: 0x1::string::String,
        series: 0x1::option::Option<0x1::string::String>,
    }

    struct MeetCreated has copy, drop {
        id: 0x2::object::ID,
    }

    public fun new(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : Meet {
        let v0 = Meet{
            id          : 0x2::object::new(arg5),
            location    : arg1,
            date        : arg2,
            description : arg3,
            series      : arg4,
        };
        let v1 = MeetCreated{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<MeetCreated>(v1);
        v0
    }

    public fun date(arg0: &Meet) : 0x1::string::String {
        arg0.date
    }

    public fun description(arg0: &Meet) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &Meet) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: MEET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun location(arg0: &Meet) : 0x1::string::String {
        arg0.location
    }

    public fun series(arg0: &Meet) : 0x1::option::Option<0x1::string::String> {
        arg0.series
    }

    public fun update_date(arg0: &mut Meet, arg1: 0x1::string::String) {
        arg0.date = arg1;
    }

    public fun update_description(arg0: &mut Meet, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    public fun update_location(arg0: &mut Meet, arg1: 0x1::string::String) {
        arg0.location = arg1;
    }

    public fun update_series(arg0: &mut Meet, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.series = arg1;
    }

    // decompiled from Move bytecode v6
}

