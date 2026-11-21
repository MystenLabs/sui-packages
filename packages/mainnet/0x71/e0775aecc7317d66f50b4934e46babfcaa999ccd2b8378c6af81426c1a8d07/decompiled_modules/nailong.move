module 0x71e0775aecc7317d66f50b4934e46babfcaa999ccd2b8378c6af81426c1a8d07::nailong {
    struct NAILONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAILONG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"856bf9f41c7f400ccbb24141e2bf801cf107ae68636dab7294d5a8d36a4df1c3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"856bf9f41c7f400ccbb24141e2bf801cf107ae68636dab7294d5a8d36a4df1c3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NAILONG>(arg0, 9, 0x1::string::utf8(b"NAILONG"), 0x1::string::utf8(b"NailongSui"), 0x1::string::utf8(b"best fucking meme ever"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/32f488b15df3e6e003c890e1709af33aca2e735c029b593d5784652096bb4bec.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NAILONG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NAILONG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

