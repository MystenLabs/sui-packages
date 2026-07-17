module 0x2e8951bfe89fe63871926d486199b1a221d8121e86b9f7424aaee3a63f871cb2::recovery {
    public fun recover_no_lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap) : 0x2::transfer_policy::TransferRequest<T0> {
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, 0x2::object::id_from_address(arg1), arg2);
        0x2::kiosk::place<T0>(arg3, arg4, v0);
        v1
    }

    public fun recover_with_lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap) : 0x2::transfer_policy::TransferRequest<T0> {
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, 0x2::object::id_from_address(arg2), arg3);
        0x2::kiosk::lock<T0>(arg4, arg5, arg1, v0);
        v1
    }

    // decompiled from Move bytecode v7
}

