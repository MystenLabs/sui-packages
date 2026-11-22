module 0x48439d5ebb737d160cd870f19ff62fcea071d669b0be7435898f96427596f788::pxp {
    struct PXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f009a44c0d1dbab5407f8a1c5cf29479dc2dbecf5a832ea8f91b02f7951bd5e7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PXP>(arg0, 9, 0x1::string::utf8(b"PXP"), 0x1::string::utf8(b"PixelPup"), 0x1::string::utf8(x"536d616c6c20506177732e2042696720576f6f66732e20f09f90be"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d6a422b174e070ffc7078d9d115e2a259e1b56253a5ac132c8bee1657fc3c16c.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PXP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PXP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

