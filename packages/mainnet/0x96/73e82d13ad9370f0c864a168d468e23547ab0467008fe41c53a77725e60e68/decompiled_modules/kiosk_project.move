module 0x9673e82d13ad9370f0c864a168d468e23547ab0467008fe41c53a77725e60e68::kiosk_project {
    struct MacBook has store, key {
        id: 0x2::object::UID,
        model: u64,
    }

    struct MacBookPlacedEvent has copy, drop {
        model: u64,
    }

    public fun id(arg0: &MacBook) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun new_macbook(arg0: &mut 0x2::tx_context::TxContext) : MacBook {
        MacBook{
            id    : 0x2::object::new(arg0),
            model : 2025,
        }
    }

    public fun place_macbook_into_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: MacBook) {
        0x2::kiosk::place<MacBook>(arg0, arg1, arg2);
        let v0 = MacBookPlacedEvent{model: arg2.model};
        0x2::event::emit<MacBookPlacedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

