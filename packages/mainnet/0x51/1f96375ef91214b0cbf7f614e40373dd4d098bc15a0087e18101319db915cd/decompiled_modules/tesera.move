module 0x511f96375ef91214b0cbf7f614e40373dd4d098bc15a0087e18101319db915cd::tesera {
    struct TESERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESERA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a84b8b07ca848898659f8168ac66361410435b63288b10617c8e379380574d2b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a84b8b07ca848898659f8168ac66361410435b63288b10617c8e379380574d2b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TESERA>(arg0, 9, 0x1::string::utf8(b"TESERA"), 0x1::string::utf8(b"Tesera Lab"), 0x1::string::utf8(b"On-Chain Infrastructure for AI Agents."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d583ab19d0eefc2ef3ec475da593c2520ccb2cc26db61043e47191f9d99f59e1.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TESERA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TESERA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

