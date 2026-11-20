module 0x5db63f7900b77e5ab8580989d6151e586e85de69db80d7e6102bff356e7c18b7::sls {
    struct SLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f7b673d8815d535156fcf61e3f96ef66f2754c146398c13b565262e7d9dba47d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f7b673d8815d535156fcf61e3f96ef66f2754c146398c13b565262e7d9dba47d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SLS>(arg0, 9, 0x1::string::utf8(b"SLS"), 0x1::string::utf8(b"Slush"), 0x1::string::utf8(x"4c6f7665207468652062656175746966756c20536c7573682077616c6c6574e29da4efb88f"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ea4794b9074f12cf784eb8c4424caa81b6c346662700e8da2a2f0b16dd42bf62.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SLS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SLS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

