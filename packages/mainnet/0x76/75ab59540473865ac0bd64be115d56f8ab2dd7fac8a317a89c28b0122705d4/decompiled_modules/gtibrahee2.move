module 0x7675ab59540473865ac0bd64be115d56f8ab2dd7fac8a317a89c28b0122705d4::gtibrahee2 {
    struct GTIBRAHEE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIBRAHEE2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIBRAHEE2>(arg0, 9, 0x1::string::utf8(b"GTIBRAHEE2"), 0x1::string::utf8(b"Ibrahimovic"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/S5blaHdGDtR9t9YivaDbuQrZUctsUzgUOjWVyLp5Z0oO7MHdCN--nxaZf1MsfcbwNImfkLdXWbwWjozZuboZXL8Y3KP57HLI5tGnJWMgBtREQl3D9qSro86z9H5NDOhn5rH4nDOhJHV8w6YuA_vK-sTWUg_OzP8Bqv_R9i7u9dS4ZB7rUehiCO4wHoLB54JVu5wTQm34Es_QLN0eTqLaYtBROjS4kZLrtMxYRM1IrjbAYHMr6WYkZti201114xLpIc0wl31AcFs6c0A6cVp-7R553NeJ9Wr2OWmqaARDSmJP3ec40yd8Nm2lcszRq0I7cFY_VApFnVyRo_AWG8kglA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIBRAHEE2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIBRAHEE2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

