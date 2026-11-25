module 0xde409c3aa29a30a9ffede934cb1937ebc4671fb1ebaa415e2849dbcde0734d3f::gtvagabond {
    struct GTVAGABOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVAGABOND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVAGABOND>(arg0, 9, 0x1::string::utf8(b"GTVAGABOND"), 0x1::string::utf8(b"Vagabond"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/SnU31wxPg4gcbtn_zZgu0QpBrjXEqDbuPDiwENx8sGzOXtqqKKX6WgwyZZHQ40BbLmmq0A85ts0IjdElJB_ghOkIjpe5ApU6lQP8IvHmkyH4VZXS40bYYZstl-IjLnBf-aigPNuApUDLjFjHiskzZhlLOd4Jx3nqivLem19vSr7pk7QSR15vqNb2AJIryD9SuvZddoOVS-7IOuH6fwU2YeWVYIWyC3v6GMYG7S5qzjMcuWBpqwzmIL_JPKKy3ppUliIaBMgOFG2n0Q7VFiOybw9lID1elMJ3bVwuz1W1bWPuUottIEeb-9eFqgnf37QnQCz0_zUj31uT9FUVjZCetQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVAGABOND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVAGABOND>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

