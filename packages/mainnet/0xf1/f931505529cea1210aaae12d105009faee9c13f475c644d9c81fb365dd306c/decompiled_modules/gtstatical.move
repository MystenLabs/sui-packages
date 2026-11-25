module 0xf1f931505529cea1210aaae12d105009faee9c13f475c644d9c81fb365dd306c::gtstatical {
    struct GTSTATICAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTATICAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTATICAL>(arg0, 9, 0x1::string::utf8(b"GTSTATICAL"), 0x1::string::utf8(b"Plauusss"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/oM7gZNczr1FHmeao-ksBBEQtpD2gh1m4UI8YtCK25o-UuvOcqmDMcUxaCVqgwOo9NXXNqOvj--dIn4ZqZc31AeQ4EZHcYKQn7myc7ounzmkt_Iq9JwYUPc36_E8I1_A837kI3tvH9Yop71yVoSVvkapIvrZ4ssSBA-qcaQ8QEOYyRw7DguINfu_Y9LkRX-KpYA-bdyxQE3Zaf-uhR4sjFDlDqhfofh1WbcXb-JOVfvmCCdHx61A_qeGAxKpxDvKsGn2rJcTEBFw3kYGVJ_Trv0nNOi08hkiA5cJPLSEwhO5IAyU65nmCNji7JS6pt5CRatXipDqk5DvA8k3_rfC95A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTATICAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTATICAL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

