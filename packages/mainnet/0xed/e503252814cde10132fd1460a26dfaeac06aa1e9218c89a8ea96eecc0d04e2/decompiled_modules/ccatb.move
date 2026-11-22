module 0xede503252814cde10132fd1460a26dfaeac06aa1e9218c89a8ea96eecc0d04e2::ccatb {
    struct CCATB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCATB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"73f5f938b5f5535b752b3afb59cd402f06ea4b81e12de54ceb31665c1bbcaa4e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"73f5f938b5f5535b752b3afb59cd402f06ea4b81e12de54ceb31665c1bbcaa4e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CCATB>(arg0, 9, 0x1::string::utf8(b"CCATB"), 0x1::string::utf8(b"Cute cat blast"), 0x1::string::utf8(b"The cute and cool cat from the Sui Network"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e357d980562680a3650a81e67a8cac40c588435c02518d1aba330279ff7c33d9.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CCATB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CCATB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

