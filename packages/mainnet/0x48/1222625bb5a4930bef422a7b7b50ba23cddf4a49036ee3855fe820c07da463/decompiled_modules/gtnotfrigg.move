module 0x481222625bb5a4930bef422a7b7b50ba23cddf4a49036ee3855fe820c07da463::gtnotfrigg {
    struct GTNOTFRIGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNOTFRIGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNOTFRIGG>(arg0, 9, 0x1::string::utf8(b"GTNOTFRIGG"), 0x1::string::utf8(b"notfrigger"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Ui23vztEIiw1FKCbJUnt9_H1P575Aw66r7aYdxnHl0tAhsYh2hrqFq3USrUNJ7oJY7tw1mxzmYLE8_X-3auSq0vwO41iBguwdtG_h7ON7pyl3aww2y8S5x9j6S-GX14BDKfW-cyopQZXHNylOlRNTOyGF9pqQAtuPC52QrZ8MDLQzirqP6pB2PihwdcQKdcJMwx-hEoqNbnNgSp1FYvvtpmAivT2Ib-nXkyI_xrb8fVoSsURJkMK4W3jsnRwk-JBcid_AuWr1Y1-1Vs-w1fCtKFiCXK0nGCZVrJnqkekUv20e64DoVf_OfwYrC6dDKc6OFUQ3TT1VMNcEcoXYD-wbw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNOTFRIGG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNOTFRIGG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

