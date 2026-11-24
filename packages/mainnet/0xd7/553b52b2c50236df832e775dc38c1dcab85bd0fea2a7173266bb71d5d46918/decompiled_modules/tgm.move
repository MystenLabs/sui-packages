module 0xd7553b52b2c50236df832e775dc38c1dcab85bd0fea2a7173266bb71d5d46918::tgm {
    struct TGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4ade30af851559af7ec3f1203298e0eb7dc0a1b650e4bf3bae53a7670800b9ae")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4ade30af851559af7ec3f1203298e0eb7dc0a1b650e4bf3bae53a7670800b9ae"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TGM>(arg0, 9, 0x1::string::utf8(b"TGM"), 0x1::string::utf8(b"TGM"), 0x1::string::utf8(b"Tgm coin"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/39d23b35355d08c8533658ece35184b9f1c308174c18de0f4f65c5e96567da18.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TGM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TGM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

