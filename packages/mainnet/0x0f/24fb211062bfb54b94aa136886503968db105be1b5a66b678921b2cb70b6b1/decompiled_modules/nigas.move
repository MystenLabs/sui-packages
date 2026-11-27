module 0xf24fb211062bfb54b94aa136886503968db105be1b5a66b678921b2cb70b6b1::nigas {
    struct NIGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIGAS>(arg0, 9, 0x1::string::utf8(b"NIGAS"), 0x1::string::utf8(b"NIGAS"), 0x1::string::utf8(b"Be bout it!"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/5ad486ffb1dd2ea11f179b09876e5224eff706c27edfa3c7e4d1fe387d731335.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIGAS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIGAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

