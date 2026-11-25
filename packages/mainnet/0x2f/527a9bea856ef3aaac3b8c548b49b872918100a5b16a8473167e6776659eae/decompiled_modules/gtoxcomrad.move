module 0x2f527a9bea856ef3aaac3b8c548b49b872918100a5b16a8473167e6776659eae::gtoxcomrad {
    struct GTOXCOMRAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXCOMRAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXCOMRAD>(arg0, 9, 0x1::string::utf8(b"GTOXCOMRAD"), 0x1::string::utf8(b"OX Comrade"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/QV4sSI0l4ryv_2Hj2ff0ZMCTiajqbONr1Uj-w8kT6iV4aJvq5IeNH03iNcxlB62i67v0HcLWIBqpUHjwlv16zYbQx2R7MFSCdO1-ACfH2yFN678PKz-m-HW6849NilZOEuXuzDafDWNG-cHlqzqpVbjoA6CAfP3B8RCpe6E8mPZPNkqQso9JrlDTygp7GBT7JCB2bsmqGOVEX1Cj9rcoKvHemnEjUkST6ZEHdHuXVWpUn8ldC3U8eTrugmJHvxwY_qTzBpsZXlYqD-UUq3F0Tfzkm2qZ4wj8AuU4TupJEi-QG9XLjKiIBdu2wWOUswvsnXp_dp4lKIPvo4-zkUdlgg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXCOMRAD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXCOMRAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

