module 0xcd5a25a07166e9c9ea0d73f1859b5faf0071d009a6a39445311dc09990028666::gtozcccaa {
    struct GTOZCCCAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOZCCCAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOZCCCAA>(arg0, 9, 0x1::string::utf8(b"GTOZCCCAA"), 0x1::string::utf8(b"Ulucay"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/dvpnZvoZ1faj0UTOX1lgpsRlBObbnFcui7Cycn7aCGCYj2K1WOVERB4ZeuBzWeqFkC5g8GuLAvxN8LBMmvf4zmPtkDLJHEWuciyClzvZW59mXeM6wfSVARBKplGdBHkT7KU8WA9iV_x-unbV2CW3gVOGN6jkAabMYjkQ269LNnlJoCwxRiGmE5hvESxr7KbzKjBZNWWouRHVl49GUXK6Rw7A5BqSkOxeg9Fa2NMKdqyAS1L-HmNlxmy4wYYlbxWGP1uA_wnYQnUvJeF9Q6GDcTqrRC9Tg0a1cIwRIRkOFgvZ0_hSVtk-ah0RiK8NM1AN4DWD09m5_r3GsrYkbEneqA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOZCCCAA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOZCCCAA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

