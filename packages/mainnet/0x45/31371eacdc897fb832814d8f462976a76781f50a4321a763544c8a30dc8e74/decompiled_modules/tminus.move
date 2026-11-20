module 0x4531371eacdc897fb832814d8f462976a76781f50a4321a763544c8a30dc8e74::tminus {
    struct TMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"b715813ae41985c10a128de06d36ecba1913f107ec3cd13731567bb05640f383")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"b715813ae41985c10a128de06d36ecba1913f107ec3cd13731567bb05640f383"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TMINUS>(arg0, 9, 0x1::string::utf8(b"TMINUS"), 0x1::string::utf8(b"T-Minus"), 0x1::string::utf8(b"T-minus zero. A community meme coin on blast.fun. Not affiliated with the blast.fun team."), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNTYgMjU2IiB3aWR0aD0iMjU2IiBoZWlnaHQ9IjI1NiI+PHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIHJ4PSI1MiIgZmlsbD0iIzBiMTAyMCIvPjxjaXJjbGUgY3g9IjEyOCIgY3k9IjEyOCIgcj0iOTAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI2ZmNGM5OCIgc3Ryb2tlLXdpZHRoPSIxMCIvPjxwYXRoIGQ9Ik0xMjggMzB2MjZNMTI4IDIwMHYyNk0zMCAxMjhoMjZNMjAwIDEyOGgyNiIgc3Ryb2tlPSIjZmY0Yzk4IiBzdHJva2Utd2lkdGg9IjEwIiBzdHJva2UtbGluZWNhcD0icm91bmQiLz48dGV4dCB4PSIxMjgiIHk9IjE1MCIgZm9udC1mYW1pbHk9IkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmIiBmb250LXNpemU9IjYyIiBmb250LXdlaWdodD0iNzAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjZmZmZmZmIj5ULTA8L3RleHQ+PC9zdmc+Cg=="), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TMINUS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TMINUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

