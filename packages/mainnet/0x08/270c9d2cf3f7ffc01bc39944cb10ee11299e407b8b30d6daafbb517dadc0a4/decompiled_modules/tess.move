module 0x8270c9d2cf3f7ffc01bc39944cb10ee11299e407b8b30d6daafbb517dadc0a4::tess {
    struct TESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"44bc56676671e84c3603c8eb429f802316f4b831ed4eda04b60e385b407c5bbd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"44bc56676671e84c3603c8eb429f802316f4b831ed4eda04b60e385b407c5bbd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TESS>(arg0, 9, 0x1::string::utf8(b"TESS"), 0x1::string::utf8(b"Tessera"), 0x1::string::utf8(b"Mint tiles, build mosaics, mine TESS."), 0x1::string::utf8(b"https://tessera-psi-flax.vercel.app/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TESS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TESS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

