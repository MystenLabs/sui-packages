module 0x17127ea0d35f02a94721e648d3db367a8ab30f7b0892a77b0c9069cfb47731c::gtavi {
    struct GTAVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAVI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"180162066cf6e36d32d24dd279ba413d3a31c01d5b1ae68ffb4e47d974c73174")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"180162066cf6e36d32d24dd279ba413d3a31c01d5b1ae68ffb4e47d974c73174"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAVI>(arg0, 9, 0x1::string::utf8(b"GTAVI"), 0x1::string::utf8(b"GTA VI Meme"), 0x1::string::utf8(b"The best game ever"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/4ede87079a072b843cc2038c7179228a2f4b3e19a315ead0e7aab87bc5e7452a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAVI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAVI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

