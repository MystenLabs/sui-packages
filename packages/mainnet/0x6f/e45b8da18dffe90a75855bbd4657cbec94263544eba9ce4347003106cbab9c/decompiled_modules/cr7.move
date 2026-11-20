module 0x6fe45b8da18dffe90a75855bbd4657cbec94263544eba9ce4347003106cbab9c::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"02c326f040e95b0be61fcaa641ca7015f390853e46a8517bac027c0411a88fd8")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"02c326f040e95b0be61fcaa641ca7015f390853e46a8517bac027c0411a88fd8"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CR7>(arg0, 9, 0x1::string::utf8(b"CR7"), 0x1::string::utf8(b"CR7"), 0x1::string::utf8(b"GOAT of all time"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/8755a08d156d064796ae2eb9dca1a8d3159e059bbb0ceb6413376ab7deacec09.webp"), v0, true, 1000, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CR7>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CR7>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

