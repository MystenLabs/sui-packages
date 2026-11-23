module 0x5dbf80e5b0f83e5a5eb031fba892865ddc9bb617660aba7ad3d9ad3d231d3890::wheels {
    struct WHEELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHEELS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8f01bfa9669a339ca9a570a9aee73e0e329e2d9afb24244f8eb0a74df2944159")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8f01bfa9669a339ca9a570a9aee73e0e329e2d9afb24244f8eb0a74df2944159"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<WHEELS>(arg0, 9, 0x1::string::utf8(b"WHEELS"), 0x1::string::utf8(b"Blast Wheels"), 0x1::string::utf8(x"426c61737420576865656c7320e2809320506c61792e20526163652e204561726e2e20f09f8f810a546865205365616d6c6573732050324520526163696e672047616d65204f6e20537569"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e9109c39fa4b41200fe710d390af6f0268bb6b57ddf08f2dfb6ac0ae5abe6305.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<WHEELS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<WHEELS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

