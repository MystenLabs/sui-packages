module 0x4f976f90a8ab7c489f105a3ccad46163ca8f79b7bb0e56fe2d1a9d8d061070d8::party {
    struct Balloon has key {
        id: 0x2::object::UID,
        popped: bool,
    }

    public entry fun fill_up_balloon(arg0: &mut 0x2::tx_context::TxContext) {
        new_balloon(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_balloon(arg0);
    }

    fun new_balloon(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Balloon{
            id     : 0x2::object::new(arg0),
            popped : false,
        };
        0x2::transfer::share_object<Balloon>(v0);
    }

    public entry fun pop_balloon(arg0: &mut Balloon) {
        arg0.popped = true;
    }

    // decompiled from Move bytecode v6
}

