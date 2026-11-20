module 0x3342346c6e25e349b82e7023bd44c505ec5b34dcf4c05f04078ceb048eb23880::be2e {
    struct BE2E has drop {
        dummy_field: bool,
    }

    fun init(arg0: BE2E, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"cf89b225369cf457d00d60f4359f5273bbf476a03997291a35b2c0dab9b3b4fe")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"cf89b225369cf457d00d60f4359f5273bbf476a03997291a35b2c0dab9b3b4fe"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BE2E>(arg0, 9, 0x1::string::utf8(b"BE2E"), 0x1::string::utf8(b"Blast E2E Test"), 0x1::string::utf8(b"End-to-end launch test before go-live. Do not buy."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/75df084c13c649fca43f1e09406a16459b9052e46849a78b0ad38cae8a04a690.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BE2E>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BE2E>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

