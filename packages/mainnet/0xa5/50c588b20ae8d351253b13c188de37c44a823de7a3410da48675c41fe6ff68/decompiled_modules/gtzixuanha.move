module 0xa550c588b20ae8d351253b13c188de37c44a823de7a3410da48675c41fe6ff68::gtzixuanha {
    struct GTZIXUANHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTZIXUANHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTZIXUANHA>(arg0, 9, 0x1::string::utf8(b"GTZIXUANHA"), 0x1::string::utf8(b"Zixuan hauran"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/rqtE8DBg_qPSFUGy15Q3dXcO-PJZLkFPWhFVQBFzAtuIFPGnozPtcnSf8kBRXKCCPWLKUzBzqe3WJb0bUTd2IO4C95J-8rwxWdTDMlkCFSfdRx2Q1JeBKohvhSO3FklDZrQW1i0SZAoCGSoMEfRBteN44SvPs00-k1mV_3PiNrUJWKyN0VIWavnGx1KZR_FAbFhyLJaGcPCr3YTVbQBHB6ZYWkh5wx6mrsIdg3U_z4mVzUArvXyE34kpw4fGyHMl4oRFstsiH_VuYuS0P7yLX-ls-8BxpbqpvKXz9sN8NpIjHM38MGPz_7AXJ5bVMevsSrg7ta2qTX0CyxxN13g_dA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTZIXUANHA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTZIXUANHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

