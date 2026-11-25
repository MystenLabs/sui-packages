module 0x48d91fa8c322f75e23c7cb0eb8e8e8c28285a67bb621611d4b43649a27c068a5::gtwifdogss {
    struct GTWIFDOGSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWIFDOGSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWIFDOGSS>(arg0, 9, 0x1::string::utf8(b"GTWIFDOGSS"), 0x1::string::utf8(b"Citty"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/M7JwVS3UhviZwHIBDtbEuoqA9gmhh7C2ESvGdbwpm8O-lfn34l1B2z0ctTyutxqeGll_uU6orTDxvP71BBOluDJxElfwSsGEBHssvTppY5wwqEe8sfYlCRwH_ttLp0qF1AlkE_KVwegJL7t0O940YLp7PkSTP4FTv7BnmaYUQ2_JD2fyQm_pJxEiSpLvOqq-YgMmkZTYtgW04v4FX9JXNZppgm_k4dJpMWz5uuTO0KAeLFrLCdpDWABaYK2jnfltGUxq0lU1wD8dLKA_hIZdZPmiu2QtydjwKtKYd61mq-dlvUz288UE6vQei-nBQL7FSubuAPVTwBGip8q4WyNZRQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWIFDOGSS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWIFDOGSS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

