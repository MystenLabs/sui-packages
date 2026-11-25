module 0x56cf66a5134d6767fc8fb73a09915e3fb5f319f9ba33694c5124f4570123d746::gtcatankin {
    struct GTCATANKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCATANKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCATANKIN>(arg0, 9, 0x1::string::utf8(b"GTCATANKIN"), 0x1::string::utf8(b"Khalid"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/IxktoqfdJmVQqm0Xktsn7dNlg_lVODY55kJtGYjmldCldDayMLOXsaJyVBwKSod7LcKq8vRbeZwezpNxJTv0C7IKZaZQYdmvueZtTSAZ9vbPum7Ydnff627gXcqeXjv4OVXTJJSTyntbk-i_X6w2s6baipo3evN0WCHPjpY_4En5x3-fPsRkfrfquXn69CnXEPGJmlWHbndDnrW44fVpGFOqxys_VFFgrQ-mtQpsRgizrXeVkXXqosrvUG5LmUmo9nb8IuaxAdbJEqOE8f3YGLDKF944qyb3DG2yLtypWIsFPsWiVxeBJr5EUf4WWw4Nmu_uisHIjpALyjVmBZF4-Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCATANKIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCATANKIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

