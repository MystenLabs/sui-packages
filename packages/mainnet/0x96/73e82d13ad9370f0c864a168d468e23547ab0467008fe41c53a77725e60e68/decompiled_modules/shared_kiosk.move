module 0x9673e82d13ad9370f0c864a168d468e23547ab0467008fe41c53a77725e60e68::shared_kiosk {
    struct KioskCapWrapper has store, key {
        id: 0x2::object::UID,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        kiosk_id: 0x2::object::ID,
    }

    public fun id(arg0: &KioskCapWrapper) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun kiosk_cap(arg0: &KioskCapWrapper) : &0x2::kiosk::KioskOwnerCap {
        &arg0.kiosk_cap
    }

    public fun new_shared_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = KioskCapWrapper{
            id        : 0x2::object::new(arg0),
            kiosk_cap : v1,
            kiosk_id  : 0x2::object::uid_to_inner(0x2::kiosk::uid(&v2)),
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x2::transfer::share_object<KioskCapWrapper>(v3);
    }

    // decompiled from Move bytecode v6
}

