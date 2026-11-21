module 0x358a4ca9d51506fb4e009f843246d7c9ea1b8391a3d3c0ce4c764c240380ab7d::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9ee6181a15a2cae33b2db012ccee3d92cdb9022e042ca1ee397548e3a21826a0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9ee6181a15a2cae33b2db012ccee3d92cdb9022e042ca1ee397548e3a21826a0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NOVA>(arg0, 9, 0x1::string::utf8(b"NOVA"), 0x1::string::utf8(b"Nova"), 0x1::string::utf8(b"Every launch is a supernova. gonova.fun"), 0x1::string::utf8(b"https://gonova.fun/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NOVA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOVA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

