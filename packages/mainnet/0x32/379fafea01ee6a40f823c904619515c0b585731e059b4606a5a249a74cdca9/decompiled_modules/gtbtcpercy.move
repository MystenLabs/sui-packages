module 0x32379fafea01ee6a40f823c904619515c0b585731e059b4606a5a249a74cdca9::gtbtcpercy {
    struct GTBTCPERCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBTCPERCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBTCPERCY>(arg0, 9, 0x1::string::utf8(b"GTBTCPERCY"), 0x1::string::utf8(b"Percy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/PLGN97ofQ6pzWrVSjsMkJmicMSwAJENzgRsn0n1i_gcWIPitVCg1FQVM3wtECkEyiNMXbYEUjXM_SMOzJmhGOSf6W-znH3cOPDqvCFsp_qUS1FhU-O_qNQR_86isJKvtbGiuda7JoHTtGtOY-6uru4-YtAMvQ7zyZ_h984Gh9b3FVeJrSP_EO_cS-KSuNfOFG3POU7Yfl1f03cmhuRo28BR3IarVz7gfAg3zOhfPacDekKfmJ57RBLQ4gjLu78-U0Eg_lXRfBcLsK2m4KZf2Ek0i3wkzpkP_JWL2DH8iVC7O7lcOoKiaBgxggWot7IR64xpXjhPioyt4uQvQxkzAjA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBTCPERCY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBTCPERCY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

