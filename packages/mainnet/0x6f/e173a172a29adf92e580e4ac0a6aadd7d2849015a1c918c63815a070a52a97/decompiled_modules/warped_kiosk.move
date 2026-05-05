module 0x6fe173a172a29adf92e580e4ac0a6aadd7d2849015a1c918c63815a070a52a97::warped_kiosk {
    public fun finalize(arg0: 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address) {
        0x2::kiosk::set_owner_custom(&mut arg0, &arg1, arg2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg1, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg0);
    }

    // decompiled from Move bytecode v7
}

