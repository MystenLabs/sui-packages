module 0x206e2b690073584a869120adcbc86a6691b1c9fac29ee72e7ff94ab0f3247923::BobbyCoin {
    struct UpdateCap has store, key {
        id: 0x2::object::UID,
    }

    struct Recorder has store, key {
        id: 0x2::object::UID,
        counter: u64,
    }

    struct EventUpdateCounter has copy, drop {
        counter: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateCap{id: 0x2::object::new(arg0)};
        let v1 = Recorder{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        0x2::transfer::public_transfer<UpdateCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<Recorder>(v1);
    }

    public fun update(arg0: &UpdateCap, arg1: &mut Recorder, arg2: u64) {
        arg1.counter = arg2;
        let v0 = EventUpdateCounter{counter: arg2};
        0x2::event::emit<EventUpdateCounter>(v0);
    }

    // decompiled from Move bytecode v6
}

