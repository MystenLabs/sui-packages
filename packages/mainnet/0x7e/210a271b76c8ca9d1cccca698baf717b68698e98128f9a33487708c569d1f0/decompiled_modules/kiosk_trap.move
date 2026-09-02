module 0x7e210a271b76c8ca9d1cccca698baf717b68698e98128f9a33487708c569d1f0::kiosk_trap {
    public entry fun trap_kiosk_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::place<0x2::coin::Coin<0x2::sui::SUI>>(&mut v3, &v2, arg0);
        0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v3, arg1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

