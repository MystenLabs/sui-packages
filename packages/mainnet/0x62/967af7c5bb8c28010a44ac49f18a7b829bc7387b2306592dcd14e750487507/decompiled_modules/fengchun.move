module 0x62967af7c5bb8c28010a44ac49f18a7b829bc7387b2306592dcd14e750487507::fengchun {
    struct FENGCHUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENGCHUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e612ffa41149106d593942d450a1e297878d666613c29de95fd0994cd4cae0d0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e612ffa41149106d593942d450a1e297878d666613c29de95fd0994cd4cae0d0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FENGCHUN>(arg0, 9, 0x1::string::utf8(b"FENGCHUN"), 0x1::string::utf8(b"fengchun"), 0x1::string::utf8(b"fengchun"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f99cc8cb7367b0bf028cd1fd62b3aa46ed6d253d391c647ad844f6b01ba0d8cd.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FENGCHUN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FENGCHUN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

