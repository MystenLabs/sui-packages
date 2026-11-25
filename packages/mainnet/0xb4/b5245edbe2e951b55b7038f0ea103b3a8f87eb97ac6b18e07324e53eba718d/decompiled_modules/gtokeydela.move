module 0xb4b5245edbe2e951b55b7038f0ea103b3a8f87eb97ac6b18e07324e53eba718d::gtokeydela {
    struct GTOKEYDELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOKEYDELA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOKEYDELA>(arg0, 9, 0x1::string::utf8(b"GTOKEYDELA"), 0x1::string::utf8(b"Xavi"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/CSq9ANj2brPN3ww7MOP_L4EvZiMiSLY8U5qY8xCAVdhKfU0h6CflljHW7SDt5-4nbcTNJUxkQnmOPNyxtoSW4z-g_osP0EWX4GNWANrwBH2la_LG27-T4qhidZ1vNcc8nAvgtYzGB0JlAMuxRyc0v7U_thP1xscAS4zWpik7NY5RQBYiG7Tdzht48FV76DZeUdibD8USM4ayyO5bXt913C7Zg_8a5pTMBy1BqUdTHso8Y1pJjPzaYgBqayJvLREDZGZsgEOE3LqTGZ8-Hrw4wmS8zFWj1S5GZYIRy49gpaYz5mdT3zc3Kpd2wSrf95yCseA2SYNEgO7CIjm5gIQ0iA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOKEYDELA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOKEYDELA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

