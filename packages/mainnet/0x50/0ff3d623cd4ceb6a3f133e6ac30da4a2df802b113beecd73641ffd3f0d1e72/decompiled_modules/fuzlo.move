module 0x500ff3d623cd4ceb6a3f133e6ac30da4a2df802b113beecd73641ffd3f0d1e72::fuzlo {
    struct FUZLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUZLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6fec7bd19c162595985f3d425427957f20f9ac2565e8d8dfad7dc3b641e8c54d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6fec7bd19c162595985f3d425427957f20f9ac2565e8d8dfad7dc3b641e8c54d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FUZLO>(arg0, 9, 0x1::string::utf8(b"FUZLO"), 0x1::string::utf8(b"Fuzlo"), 0x1::string::utf8(b"Every blast starts with a spark. Fuzlo is the tiny grinning fuse that lights it. Original meme on blast.fun. No team allocation, no presale, no socials yet. Not affiliated with the blast.fun team."), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MTIgNTEyIj48cmVjdCB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgcng9Ijk2IiBmaWxsPSIjMmExNDYwIi8+PGNpcmNsZSBjeD0iMjU2IiBjeT0iMzAwIiByPSIxNTAiIGZpbGw9IiMzYjFmODYiLz48cGF0aCBkPSJNMjU2IDE5MGMtMTQtNDAgMTAtNzAgNDAtOTYiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzE0MTAyYSIgc3Ryb2tlLXdpZHRoPSIxMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIi8+PHBhdGggZD0iTTMwMCA0MGwxNCAzNCAzNiA2LTI4IDIyIDggMzYtMzAtMjAtMzAgMjAgOC0zNi0yOC0yMiAzNi02eiIgZmlsbD0iI2ZmZDIzZiIgc3Ryb2tlPSIjMTQxMDJhIiBzdHJva2Utd2lkdGg9IjEwIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+PHJlY3QgeD0iMTQ2IiB5PSIyMDAiIHdpZHRoPSIyMjAiIGhlaWdodD0iMjMwIiByeD0iNzAiIGZpbGw9IiNmZjVhMzYiIHN0cm9rZT0iIzE0MTAyYSIgc3Ryb2tlLXdpZHRoPSIxMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjxyZWN0IHg9IjE0NiIgeT0iMjUwIiB3aWR0aD0iMjIwIiBoZWlnaHQ9IjQwIiBmaWxsPSIjZmZkMjNmIiBzdHJva2U9IiMxNDEwMmEiIHN0cm9rZS13aWR0aD0iMTAiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz48Y2lyY2xlIGN4PSIyMTUiIGN5PSIzNDUiIHI9IjE2IiBmaWxsPSIjMTQxMDJhIi8+PGNpcmNsZSBjeD0iMjk3IiBjeT0iMzQ1IiByPSIxNiIgZmlsbD0iIzE0MTAyYSIvPjxjaXJjbGUgY3g9IjIyMSIgY3k9IjMzOSIgcj0iNSIgZmlsbD0iI2ZmZiIvPjxjaXJjbGUgY3g9IjMwMyIgY3k9IjMzOSIgcj0iNSIgZmlsbD0iI2ZmZiIvPjxwYXRoIGQ9Ik0yMjYgMzg1cTMwIDIyIDYwIDAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzE0MTAyYSIgc3Ryb2tlLXdpZHRoPSIxMCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIi8+PC9zdmc+Cg=="), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FUZLO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FUZLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

