module 0x10dc8710fbb685016ead2439681859613f49613b23f0ff95145b964de7b3b233::glugsy {
    struct GLUGSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUGSY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6fec7bd19c162595985f3d425427957f20f9ac2565e8d8dfad7dc3b641e8c54d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6fec7bd19c162595985f3d425427957f20f9ac2565e8d8dfad7dc3b641e8c54d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GLUGSY>(arg0, 9, 0x1::string::utf8(b"GLUGSY"), 0x1::string::utf8(b"Glugsy"), 0x1::string::utf8(b"Sui means water, so Glugsy drinks the whole ocean and hiccups green candles. Original meme on blast.fun. No team allocation, no presale, no socials yet. Not affiliated with the blast.fun team."), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MTIgNTEyIj48Y2xpcFBhdGggaWQ9ImMiPjxyZWN0IHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiByeD0iOTYiLz48L2NsaXBQYXRoPjxnIGNsaXAtcGF0aD0idXJsKCNjKSI+PHJlY3Qgd2lkdGg9IjUxMiIgaGVpZ2h0PSI1MTIiIGZpbGw9IiMwZDNiNjYiLz48cGF0aCBkPSJNMCA0MDBxNjQtMzAgMTI4IDB0MTI4IDAgMTI4IDAgMTI4IDB2MTEySDB6IiBmaWxsPSIjMWQ2ZmI4Ii8+PC9nPjxwYXRoIGQ9Ik0zODAgMjU2bDkwLTcwdjE0MHoiIGZpbGw9IiNmZjlmMWMiIHN0cm9rZT0iIzE0MTAyYSIgc3Ryb2tlLXdpZHRoPSIxMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxlbGxpcHNlIGN4PSIyNDAiIGN5PSIyNTYiIHJ4PSIxNjAiIHJ5PSIxMzAiIGZpbGw9IiNmZmJmM2YiIHN0cm9rZT0iIzE0MTAyYSIgc3Ryb2tlLXdpZHRoPSIxMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxjaXJjbGUgY3g9IjE4MCIgY3k9IjIyMCIgcj0iMzgiIGZpbGw9IiNmZmYiIHN0cm9rZT0iIzE0MTAyYSIgc3Ryb2tlLXdpZHRoPSIxMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxjaXJjbGUgY3g9IjE4OCIgY3k9IjIyNCIgcj0iMTgiIGZpbGw9IiMxNDEwMmEiLz48ZWxsaXBzZSBjeD0iMTIwIiBjeT0iMjkwIiByeD0iMzQiIHJ5PSIzMCIgZmlsbD0iIzE0MTAyYSIvPjxlbGxpcHNlIGN4PSIxMjAiIGN5PSIyOTAiIHJ4PSIxNiIgcnk9IjE0IiBmaWxsPSIjZmY2YjZiIi8+PHBhdGggZD0iTTI1MCAxODBxNDAgMjAgMzAgNzBNMzAwIDIwMHEzMCAyMCAyMCA2MCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmY5ZjFjIiBzdHJva2Utd2lkdGg9IjEwIiBzdHJva2UtbGluZWNhcD0icm91bmQiLz48ZyBmaWxsPSIjOWJlN2ZmIiBzdHJva2U9IiMxNDEwMmEiIHN0cm9rZS13aWR0aD0iMTAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiPjxjaXJjbGUgY3g9Ijk2IiBjeT0iMTYwIiByPSIyMCIvPjxjaXJjbGUgY3g9IjcwIiBjeT0iMTAwIiByPSIxMyIvPjxjaXJjbGUgY3g9IjExMCIgY3k9IjYwIiByPSI4Ii8+PC9nPjwvc3ZnPgo="), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GLUGSY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GLUGSY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

