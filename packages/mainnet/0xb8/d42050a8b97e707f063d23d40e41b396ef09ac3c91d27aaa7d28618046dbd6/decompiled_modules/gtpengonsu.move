module 0xb8d42050a8b97e707f063d23d40e41b396ef09ac3c91d27aaa7d28618046dbd6::gtpengonsu {
    struct GTPENGONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPENGONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPENGONSU>(arg0, 9, 0x1::string::utf8(b"GTPENGONSU"), 0x1::string::utf8(b"Penguin_onsui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/QbgnBQ7QK43Jc6QWtjgyuU7_jo-IQjU_dvaRNqRuPVHX3wj2LjEPU9LbgL3up919uDPRNw_SSonktkkGTzpLWQCLim4cYWzTCMjyDbEEjZoAN1jMn2v8OZYG1ertiUqRMBOiRrHfoE8yRvU3E3VbxpC0KGf3wkYN4Gs-uwfRDsx7dPoY7sBrSH_lLwWCNcwn06kdVFwPnvnsMmUr59DvIVN8ZlhJ886kb6f0A7pthbS0RRSUJ8zxYj_8DM74oFQqlM9rn6Zf7SS_e4ACcsGse_6r89AKDTs3fq_AUonTU4xwAqOLFgpbM43afZFGyXUxMPnqSTmzFVSF7E0QKOikvw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPENGONSU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPENGONSU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

