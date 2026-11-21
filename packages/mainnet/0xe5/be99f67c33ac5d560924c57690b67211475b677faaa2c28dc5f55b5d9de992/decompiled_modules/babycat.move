module 0xe5be99f67c33ac5d560924c57690b67211475b677faaa2c28dc5f55b5d9de992::babycat {
    struct BABYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9bd20ffb503911de7188fbae193c2f63f3ff0a77d7a19becffffe3c7987dcb61")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9bd20ffb503911de7188fbae193c2f63f3ff0a77d7a19becffffe3c7987dcb61"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BABYCAT>(arg0, 9, 0x1::string::utf8(b"BABYCAT"), 0x1::string::utf8(b"Baby Cat"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e25c7f200c4916288e09ba97ae47c0b9e7cb03bef2ebb1351252e3ca4ba44284.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BABYCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BABYCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

