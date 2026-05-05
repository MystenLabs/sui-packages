module 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::warped_kiosk {
    public fun finalize(arg0: 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address) {
        0x2::kiosk::set_owner_custom(&mut arg0, &arg1, arg2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg1, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg0);
    }

    // decompiled from Move bytecode v7
}

