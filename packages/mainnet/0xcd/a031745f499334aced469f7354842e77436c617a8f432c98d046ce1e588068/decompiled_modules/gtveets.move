module 0xcda031745f499334aced469f7354842e77436c617a8f432c98d046ce1e588068::gtveets {
    struct GTVEETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVEETS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVEETS>(arg0, 9, 0x1::string::utf8(b"GTVEETS"), 0x1::string::utf8(b"Veets"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/mWGafsrZtoqpz2k68vuoG6yKE9jtwlOs0FBZPCNZgwSWDw6-AORE5T3IokMVV0pedZPKFvSS-Urg7QDIrsa1RO680XE8ldVTh2pOB1Bz-yDPdQmclAYzzYq4lMOJa7IMeiruAsm7uViMV11RPoShGvaisk6jqiu2gkUWQYzzuhjMV5J72iawkcZ16YIv0d1RCXKQI9fsLxnVZiNcYjtosrMh8odrb4n1xDn8NfzNwJPeeg9fv6MVhiVpRwahd_rC-VRPe16qN5BGx2TDpWQl73CjWxmuIHPpz0HDfpBUqbyDluLoBQfjFsYNpr5dQ1GCGM08WALfSCYr37k4E8QAqQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVEETS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVEETS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

