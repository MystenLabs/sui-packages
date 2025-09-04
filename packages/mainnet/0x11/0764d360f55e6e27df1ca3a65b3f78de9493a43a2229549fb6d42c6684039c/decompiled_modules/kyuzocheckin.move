module 0x110764d360f55e6e27df1ca3a65b3f78de9493a43a2229549fb6d42c6684039c::kyuzocheckin {
    struct HouseData has key {
        id: 0x2::object::UID,
    }

    struct KYUZOCHECKIN has drop {
        dummy_field: bool,
    }

    struct CheckinEvent has copy, drop {
        user: address,
    }

    public fun checkin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CheckinEvent{user: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<CheckinEvent>(v0);
    }

    fun init(arg0: KYUZOCHECKIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KYUZOCHECKIN>(arg0, arg1);
        let v0 = HouseData{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<HouseData>(v0);
    }

    // decompiled from Move bytecode v6
}

