module 0x8f3d641af9dcf6663f5fb75220e88e6ca843c87388cfb73a9668217173e68ec0::gttantaweb {
    struct GTTANTAWEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTANTAWEB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTANTAWEB>(arg0, 9, 0x1::string::utf8(b"GTTANTAWEB"), 0x1::string::utf8(b"Tanta"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/NFIdvGqV0bpfDioqvSacBza7UitQj-37zCd-8RK3iYDVL3bRjAeP5OPX-hjSNER9vuZ0TCzzR_G-YvFGFaCTYeTQct8dacyAFWCY5svUE_a_QXD7ChLKdp5Vo-_ASo0x2bjVIJArhXBojxdGklVjtk2tE6TrL6a9QBkVUh4R9jrBk8iTtogsRrsBk441JAick5IZhhe1niKHFnRThBs-WAzXhNsbHgqftpO0MLwbXJF-s5oQZq9GT66vW8QO4ZO5TY9t5SvHZb6SNK76p7uyy-xQq06JUuUR1AzKOvcBjoAxXOaXw3eJ3NAGytEsa96gynTCfG7le_bg7aVsRPLQvA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTANTAWEB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTANTAWEB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

