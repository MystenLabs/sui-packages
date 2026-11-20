module 0xaf99f0d48317edb55f7d9d0c56d3f3d7daa5fc18c076f16a08e4b67ed8f218f6::mbtc {
    struct MBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"07f1c587a06a78cf911842ef3228b9078d12843d5b96f019214140617ece3ce5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"07f1c587a06a78cf911842ef3228b9078d12843d5b96f019214140617ece3ce5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MBTC>(arg0, 9, 0x1::string::utf8(b"MBTC"), 0x1::string::utf8(b"memebitcoin"), 0x1::string::utf8(b"memebitcoin trend"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/717215446c42ab568a0202890fab792ee3d4985770bd8af2d540589c867f118c.webp"), v0, true, 100, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MBTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MBTC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

