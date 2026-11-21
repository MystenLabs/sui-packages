module 0x4cf93969ec92060090c819c2d8a3186211e705e0a8535e88ca77315ec1b47bdb::preamp {
    struct PREAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"7e665b12975e5ecf1685eb68836caaeca7da1ad540c26fc306d75da383b0b4ab")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"7e665b12975e5ecf1685eb68836caaeca7da1ad540c26fc306d75da383b0b4ab"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PREAMP>(arg0, 9, 0x1::string::utf8(b"PREAMP"), 0x1::string::utf8(b"Preamp"), 0x1::string::utf8(b"Tune in to new tokens. preampfm.xyz"), 0x1::string::utf8(b"https://preamp-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PREAMP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PREAMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

