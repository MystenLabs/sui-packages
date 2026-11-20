module 0xc52fb884897fc83b87fe9eebcb75f8a90ece3e8aeebec1f87a02bb2875a38cf1::uicrv {
    struct UICRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: UICRV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"cf89b225369cf457d00d60f4359f5273bbf476a03997291a35b2c0dab9b3b4fe")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"cf89b225369cf457d00d60f4359f5273bbf476a03997291a35b2c0dab9b3b4fe"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<UICRV>(arg0, 9, 0x1::string::utf8(b"UICRV"), 0x1::string::utf8(b"Blast UI Curve"), 0x1::string::utf8(b"QA test coin for the web UI end-to-end run. Test SUI only, no value."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b91dc476bfd5c0698767f4d4629a4ee4a568768a13e62d3f6cb2ef8c855f3f71.webp"), v0, true, 100, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<UICRV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<UICRV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

