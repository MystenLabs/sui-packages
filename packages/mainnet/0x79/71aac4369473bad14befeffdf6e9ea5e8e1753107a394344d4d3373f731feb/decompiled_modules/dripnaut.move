module 0x7971aac4369473bad14befeffdf6e9ea5e8e1753107a394344d4d3373f731feb::dripnaut {
    struct DRIPNAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPNAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6fec7bd19c162595985f3d425427957f20f9ac2565e8d8dfad7dc3b641e8c54d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6fec7bd19c162595985f3d425427957f20f9ac2565e8d8dfad7dc3b641e8c54d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DRIPNAUT>(arg0, 9, 0x1::string::utf8(b"DRIPNAUT"), 0x1::string::utf8(b"Dripnaut"), 0x1::string::utf8(b"One drop of Sui in a space helmet, out to refill the stars. Original community meme on blast.fun. No team allocation, no presale. Not affiliated with the blast.fun team."), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MTIgNTEyIj48cmVjdCB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgcng9Ijk2IiBmaWxsPSIjMGIxNjQwIi8+PGcgZmlsbD0iI2ZmZTE0ZCI+PHBhdGggZD0iTTg2IDk2bDggMjIgMjIgOC0yMiA4LTggMjItOC0yMi0yMi04IDIyLTh6Ii8+PHBhdGggZD0iTTQyMCA3MGw2IDE2IDE2IDYtMTYgNi02IDE2LTYtMTYtMTYtNiAxNi02eiIvPjxwYXRoIGQ9Ik00MzIgMzgwbDcgMTggMTggNy0xOCA3LTcgMTgtNy0xOC0xOC03IDE4LTd6Ii8+PGNpcmNsZSBjeD0iMTEwIiBjeT0iNDAwIiByPSI3Ii8+PGNpcmNsZSBjeD0iMzgwIiBjeT0iMTkwIiByPSI1Ii8+PC9nPjxwYXRoIGQ9Ik0yNTYgNzBDMjU2IDcwIDEyMCAyMzAgMTIwIDMyMGExMzYgMTM2IDAgMCAwIDI3MiAwQzM5MiAyMzAgMjU2IDcwIDI1NiA3MHoiIGZpbGw9IiMyOWI2ZmYiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLXdpZHRoPSIxMiIvPjxlbGxpcHNlIGN4PSIyNTYiIGN5PSIzMTgiIHJ4PSI5MiIgcnk9Ijc0IiBmaWxsPSIjZWFmOGZmIiBzdHJva2U9IiNmZmYiIHN0cm9rZS13aWR0aD0iMTAiLz48ZWxsaXBzZSBjeD0iMjU2IiBjeT0iMzE4IiByeD0iNzYiIHJ5PSI1OCIgZmlsbD0iIzBiMTY0MCIvPjxjaXJjbGUgY3g9IjIyOCIgY3k9IjMxNCIgcj0iMTMiIGZpbGw9IiNmZmYiLz48Y2lyY2xlIGN4PSIyODQiIGN5PSIzMTQiIHI9IjEzIiBmaWxsPSIjZmZmIi8+PHBhdGggZD0iTTIzNiAzNDRxMjAgMTYgNDAgMCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjgiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPjxwYXRoIGQ9Ik0xOTYgMzAwcTEwLTI2IDM2LTMwIiBmaWxsPSJub25lIiBzdHJva2U9IiM3ZmQ4ZmYiIHN0cm9rZS13aWR0aD0iOCIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIi8+PHBhdGggZD0iTTI1NiA3MHYtMjYiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLXdpZHRoPSI4Ii8+PGNpcmNsZSBjeD0iMjU2IiBjeT0iMzgiIHI9IjEyIiBmaWxsPSIjZmY0ZDZkIi8+PC9zdmc+Cg=="), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DRIPNAUT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DRIPNAUT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

