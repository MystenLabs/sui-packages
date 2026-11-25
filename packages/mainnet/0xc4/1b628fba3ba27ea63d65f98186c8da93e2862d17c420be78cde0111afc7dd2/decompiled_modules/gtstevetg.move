module 0xc41b628fba3ba27ea63d65f98186c8da93e2862d17c420be78cde0111afc7dd2::gtstevetg {
    struct GTSTEVETG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTEVETG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTEVETG>(arg0, 9, 0x1::string::utf8(b"GTSTEVETG"), 0x1::string::utf8(b"Steve"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/ShVz-SgwDw4DgWTnmVVT_W488kGA4MUYoBtVb2AJGIC3JdQ9ulntCM6zpGttBuLZC3Fns4BqQgu5DwfpUXgpPlMCmPBBFZBl0CeS7w2PkDQWC9q4Za5ImVyIwB8dWm4C_sSpCsmbSqCWbkfmi0GLsiyZp7vLovyN9KNnYU2c3Pu00Mty9vYidKnJCqfZQVKdk1oY_9fL47-dIOnLMmiE7aHCJad5L6834L8VbVwKtynuVZDWz-VXs9wZnJ157prJrH74SEWl_i_h9oKQ5vNz5J4bA8ioViggAs9nJ16beFGJtAjVaZGMXDQhNctY3QDf0ocaLcLyPA66vkKM31FJ9g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTEVETG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTEVETG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

