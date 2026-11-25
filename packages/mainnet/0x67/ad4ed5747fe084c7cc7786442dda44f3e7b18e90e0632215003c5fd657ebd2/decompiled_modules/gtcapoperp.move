module 0x67ad4ed5747fe084c7cc7786442dda44f3e7b18e90e0632215003c5fd657ebd2::gtcapoperp {
    struct GTCAPOPERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCAPOPERP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCAPOPERP>(arg0, 9, 0x1::string::utf8(b"GTCAPOPERP"), 0x1::string::utf8(b"Capo"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/SHbA33v5crxfZMNN7OpX4Rrt9DfDmkyvo5Bpj_Dc6bNbjQeRhHP70lnYhaOg9zhTLvwJaO-BzdolKnJ-lyn2OmG2bEpEQRQEGVbpjWxv5RYaiJY16l5KK5jliNdoqSA9q_OH8-Sizccnx77BEXukJAgBBtcs7IhjfTi6C-P_-bakE4f0bHsi-su3fOkOayL6uefK84FAZb4a5ERlgsjhnfveOvIbCPGXJ4iX0cNXem656q_2WAfZeCdrVDg4gqWCMytfYth_CA1i2E22F44yIHACKm4p992GgdeprXuw0zui3Je345dJ7NTzrLvs8wCW5Fu0xBNcy260loeKzylCSA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCAPOPERP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCAPOPERP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

