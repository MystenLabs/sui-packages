module 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::warped_kiosk {
    public fun finalize(arg0: 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address) {
        0x2::kiosk::set_owner_custom(&mut arg0, &arg1, arg2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg1, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg0);
    }

    // decompiled from Move bytecode v7
}

