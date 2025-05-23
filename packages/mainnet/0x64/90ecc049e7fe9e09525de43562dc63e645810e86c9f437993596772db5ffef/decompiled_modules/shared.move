module 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared {
    struct SHARED has drop {
        dummy_field: bool,
    }

    struct Pi has key {
        id: 0x2::object::UID,
    }

    public fun get_id(arg0: &Pi) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_id_mut(arg0: &mut Pi) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun init(arg0: SHARED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pi{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Pi>(v0);
    }

    // decompiled from Move bytecode v6
}

