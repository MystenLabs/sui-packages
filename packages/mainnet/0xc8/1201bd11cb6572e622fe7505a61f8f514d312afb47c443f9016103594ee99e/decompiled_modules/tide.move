module 0xc81201bd11cb6572e622fe7505a61f8f514d312afb47c443f9016103594ee99e::tide {
    struct TIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8cb38918dab623fb296faf606a9e050170de8f34177703a54cd6aea968d4dc2f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8cb38918dab623fb296faf606a9e050170de8f34177703a54cd6aea968d4dc2f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TIDE>(arg0, 9, 0x1::string::utf8(b"TIDE"), 0x1::string::utf8(b"Tidehold"), 0x1::string::utf8(b"The deeper the water, the bigger the market. tidehold.xyz"), 0x1::string::utf8(b"https://tidehold.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TIDE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TIDE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

