module 0x28f38f26a730c1e443213cb43c282db98d704e1f136859e6f30c838bc0f1508d::bikeljordan {
    struct BIKELJORDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIKELJORDAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"67e727646387d7e0c5b124354da0f47277aec277fff403853650ddf3fc694c10")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"67e727646387d7e0c5b124354da0f47277aec277fff403853650ddf3fc694c10"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BIKELJORDAN>(arg0, 9, 0x1::string::utf8(b"BIKELJORDAN"), 0x1::string::utf8(b"bikel jordan"), 0x1::string::utf8(b"bike + michael jordan"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c6dc250bb60ebcac21de223f00db034a4e30ea756e02b3f746f11c013d548ade.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BIKELJORDAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BIKELJORDAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

