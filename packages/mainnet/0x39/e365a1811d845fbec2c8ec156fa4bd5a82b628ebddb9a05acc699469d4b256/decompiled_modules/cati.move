module 0x39e365a1811d845fbec2c8ec156fa4bd5a82b628ebddb9a05acc699469d4b256::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"98dca5a234a5ad545f1290652aa331da2e33def8828b91db11e2f3947da71112")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"98dca5a234a5ad545f1290652aa331da2e33def8828b91db11e2f3947da71112"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CATI>(arg0, 9, 0x1::string::utf8(b"CATI"), 0x1::string::utf8(b"Cat inu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/b606b86b812ae5effbd3524c13de8c8ce74fe59161547ab61166215268dc76fb.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CATI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CATI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

