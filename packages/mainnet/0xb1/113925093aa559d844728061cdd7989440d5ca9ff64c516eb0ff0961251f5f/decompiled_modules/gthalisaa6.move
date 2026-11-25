module 0xb1113925093aa559d844728061cdd7989440d5ca9ff64c516eb0ff0961251f5f::gthalisaa6 {
    struct GTHALISAA6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHALISAA6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHALISAA6>(arg0, 9, 0x1::string::utf8(b"GTHALISAA6"), 0x1::string::utf8(b"kazuya"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/SIjVPJRRqXiO058ruhmGdWSR9grXS9sXFi4G4MYuLT2xhN2gO3xYzvc1H98Uu3N4xoN_F63Axo_lvKH5wV15GLr4EQmzNP1rDsebEwMRTUGB3dkLpWGF7sqtuZO_yaee_-IxFan52LHsgY2uNjh64DJO9wudrd8zPyDj-HXLee29tfqEuAqCX9067kDqWEEBkh04DeUU_dx6v7R-VxZGJYxGbX6qallYGAygxxjDyXc2xJixsWJIrG74sNBPRJRKD1mrI4P83K6vo3SO3EG38ZX6hXcMpsc-lF_m3zihFC8mKmyBkI1a9RAPN7vBPbvzxCChVtqIqYRbI5sP5C5mqg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHALISAA6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHALISAA6>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

