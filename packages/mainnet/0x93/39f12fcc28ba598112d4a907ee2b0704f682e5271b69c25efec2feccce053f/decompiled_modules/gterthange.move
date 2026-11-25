module 0x9339f12fcc28ba598112d4a907ee2b0704f682e5271b69c25efec2feccce053f::gterthange {
    struct GTERTHANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTERTHANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTERTHANGE>(arg0, 9, 0x1::string::utf8(b"GTERTHANGE"), 0x1::string::utf8(b"Curtis Palmer"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/DZQ05cNKhff8LMpM5Dd4u-o_o0R4Fpzd1oG34t4ejLjOGjOSEk7mHpwRBHIZmFerlQ9IC1MeiJEDpWfNpt7fveVS0wNaowqy8QSj3YCbTvm_kBJ66LrZrFNVrifyStC9T02kcp8vQTEnh6W0DtL7FBCDmLqfki2M83WjZaVIeFTumylI2XdnWtVyA4bCwmZeIhte2MQthWRnw6egl9HF9Rm2_koVjL-KGWEqrP0GKrGHc41GfNLJCWSlGeOwJy-BON6BTR3xINymDvasxX1yPoqr7W_xn3IPezJ37pQPaIB_JYEwCPVLWOFFHxLOwdfCY87yU5nYACer7wo3CragRg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTERTHANGE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTERTHANGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

