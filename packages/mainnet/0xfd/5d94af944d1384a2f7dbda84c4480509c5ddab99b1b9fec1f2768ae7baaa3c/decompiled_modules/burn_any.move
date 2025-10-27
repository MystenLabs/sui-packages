module 0xfd5d94af944d1384a2f7dbda84c4480509c5ddab99b1b9fec1f2768ae7baaa3c::burn_any {
    public fun burn_from_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 1);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg0, arg1, arg2), @0x0);
    }

    // decompiled from Move bytecode v6
}

