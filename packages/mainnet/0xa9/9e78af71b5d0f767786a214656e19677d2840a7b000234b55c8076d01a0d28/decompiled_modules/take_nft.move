module 0xa99e78af71b5d0f767786a214656e19677d2840a7b000234b55c8076d01a0d28::take_nft {
    entry fun take_and_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

