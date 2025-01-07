module 0xd351caa7676648017d518fafda17c84d0ce6e0c4eb677b96a9c5dc09945c0a2b::super_kiosk {
    struct SuperKiosk has store, key {
        id: 0x2::object::UID,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    public fun borrow_kiosk_cap(arg0: &SuperKiosk) : &0x2::kiosk::KioskOwnerCap {
        &arg0.kiosk_cap
    }

    public fun borrow_kiosk_mut(arg0: &mut SuperKiosk) : &mut 0x2::kiosk::Kiosk {
        &mut arg0.kiosk
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = SuperKiosk{
            id        : 0x2::object::new(arg0),
            kiosk     : v0,
            kiosk_cap : v1,
        };
        0x2::transfer::share_object<SuperKiosk>(v2);
    }

    // decompiled from Move bytecode v6
}

