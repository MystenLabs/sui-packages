module 0x602a25ab8dcbb9758228b614584d5d25e7215e805db0dd0ae01701d42cb92c1a::gtayo2678 {
    struct GTAYO2678 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAYO2678, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAYO2678>(arg0, 9, 0x1::string::utf8(b"GTAYO2678"), 0x1::string::utf8(b"Marvellous"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/XoADDfly8TtxcygV_PMIYWpRJQlE_1CVTZ6P5-FX6oPfYrfi8zoort5LjpAxLetzbaZDqXBwBg4Lp5QmPntZhVjJJtpYc21Oixqdh2RLFR27p4tcK79y5G0W5UcTnYmk3CL2Qzqn1U53_KwtA_IODrS8rpDrxJtSnM9i_Ri4UrkyM4LEx2-ULalpdRQS-ElssE4Sh_6L1B6llwtzf5roBKM63EUkyMl7q1Ns3zAypCiHMIN1D9bAK1oP7VVoDV9OQ-8FsvOiaUNqt_JvzDE9ZFAWf2IG8T-wjCAoU3JONPh0ta-2tY0rBDV9CfJUn-xD0XyKoP0EC2YmA5Q46FJ2FQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAYO2678>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAYO2678>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

