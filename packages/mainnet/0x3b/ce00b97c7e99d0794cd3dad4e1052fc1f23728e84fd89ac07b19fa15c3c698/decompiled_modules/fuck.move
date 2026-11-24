module 0x3bce00b97c7e99d0794cd3dad4e1052fc1f23728e84fd89ac07b19fa15c3c698::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1a6233550489251672f239c6fe6c3f1101da01be9977d0ad671bfd3354aeec2b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1a6233550489251672f239c6fe6c3f1101da01be9977d0ad671bfd3354aeec2b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FUCK>(arg0, 9, 0x1::string::utf8(b"FUCK"), 0x1::string::utf8(b"fuck btc"), 0x1::string::utf8(x"7468697320697320666f7220616c6c2074686f73652077686f2077657265206c697175696461746564200a0a62656c69766520696e206c696665"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d3fd8ebb1074b1bd0219db56bb2675486535093fc45ff7170e490ed24d5ad99f.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FUCK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FUCK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

