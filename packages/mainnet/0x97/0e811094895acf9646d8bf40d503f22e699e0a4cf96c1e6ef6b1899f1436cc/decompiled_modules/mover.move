module 0x970e811094895acf9646d8bf40d503f22e699e0a4cf96c1e6ef6b1899f1436cc::mover {
    struct Mover has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::KioskOwnerCap {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = Mover{id: 0x2::object::new(arg0)};
        0x2::kiosk::place<Mover>(&mut v3, &v2, v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

