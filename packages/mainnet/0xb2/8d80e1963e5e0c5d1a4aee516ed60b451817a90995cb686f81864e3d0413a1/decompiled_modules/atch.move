module 0xb28d80e1963e5e0c5d1a4aee516ed60b451817a90995cb686f81864e3d0413a1::atch {
    struct ATCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"c7ce60cbeaa36cd84b86e21c331c2279b3347a16aee81d31a57dbd2a96bcd855")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"c7ce60cbeaa36cd84b86e21c331c2279b3347a16aee81d31a57dbd2a96bcd855"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ATCH>(arg0, 9, 0x1::string::utf8(b"ATCH"), 0x1::string::utf8(b"ATTACH"), 0x1::string::utf8(b"ATT@CH is a small game drawn in ASCII. Things are coming apart: papers, names, then the Moon. You have one clip. Hold the world together. $ATCH is the game's coin. Play at attach.click"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/781a8112f82229d84f32d69b5d9a16d04f48ca5b27c517a39aeca7522579461f.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ATCH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ATCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

