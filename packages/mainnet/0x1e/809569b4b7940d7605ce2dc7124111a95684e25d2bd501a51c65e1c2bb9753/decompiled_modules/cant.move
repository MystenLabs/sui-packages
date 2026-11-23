module 0x1e809569b4b7940d7605ce2dc7124111a95684e25d2bd501a51c65e1c2bb9753::cant {
    struct CANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"340f0a9f1c21394b4993fb2f4aadb13d8ec86f52d237f70e303b07a04ec54a62")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"340f0a9f1c21394b4993fb2f4aadb13d8ec86f52d237f70e303b07a04ec54a62"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CANT>(arg0, 9, 0x1::string::utf8(b"CANT"), 0x1::string::utf8(b"Effective Cynicism"), 0x1::string::utf8(b"Maximum expected disappointment per unit of capital deployed"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9c6ca85781bf9dcb190a8c06f3d4c48ba58c6ff9d5eb8c1bd7b065e56525a243.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CANT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CANT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

