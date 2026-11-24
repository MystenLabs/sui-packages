module 0x73299dc5a48d34def9212c6682c36e9d3090c8dad3d0ca8404c9e60a40f6d80e::fsdv15 {
    struct FSDV15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDV15, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4f22dce2aa58b6d303191049f842f86d9bf5be185074e32c6a728ea44f7b0da7")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4f22dce2aa58b6d303191049f842f86d9bf5be185074e32c6a728ea44f7b0da7"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FSDV15>(arg0, 6, 0x1::string::utf8(b"FSDV15"), 0x1::string::utf8(b"FSDV15 Tesla"), 0x1::string::utf8(b"The city never sleeps. The car never asks for directions. Welcome to the open-world future of driving. Meme coin of Tesla GTA in real life."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d788e61fb8a550a6875dbce14f9fedab232820dd249677b70b262640e6f53cc3.webp"), v0, false, 100, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FSDV15>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FSDV15>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

