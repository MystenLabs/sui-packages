module 0x7668d3bbad0453cd3e9235cd5ef4cbf4e4874500cfd4a861d6e5f83fdfd88dc6::fags {
    struct FAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ce65eaf34e269ec7dfdc7d347972ff32a55f90cb1d0e024a9f4f6ad39e8e7808")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ce65eaf34e269ec7dfdc7d347972ff32a55f90cb1d0e024a9f4f6ad39e8e7808"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FAGS>(arg0, 9, 0x1::string::utf8(b"FAGS"), 0x1::string::utf8(b"Mysten Fags"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ed5e4849ae679ff2b0f9e4696e68712ce4d7fbbdf23341c53ece67de9adcf54a.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FAGS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FAGS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

