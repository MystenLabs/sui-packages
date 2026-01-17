module 0xb5ae61a7b09231558b5b25c38e342d474b078affbdcb39b50e558f5f835e5e05::checkin {
    struct EventBadge has key {
        id: 0x2::object::UID,
        event_name: 0x1::string::String,
        participant_name: 0x1::string::String,
    }

    public entry fun burn_badge(arg0: EventBadge) {
        let EventBadge {
            id               : v0,
            event_name       : _,
            participant_name : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun do_checkin(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = EventBadge{
            id               : 0x2::object::new(arg2),
            event_name       : arg0,
            participant_name : arg1,
        };
        0x2::transfer::transfer<EventBadge>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

