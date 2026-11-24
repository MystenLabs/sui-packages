module 0x19007dae98c2a0081e83f4d084ab3049b162dbe05914bb86e22ab70337dbba91::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"846e62d6e77fe8df74508d8e15fa6583cf3a4894a35108e549b7b448fa71acde")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"846e62d6e77fe8df74508d8e15fa6583cf3a4894a35108e549b7b448fa71acde"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<D>(arg0, 9, 0x1::string::utf8(b"D"), 0x1::string::utf8(b"D"), 0x1::string::utf8(b"D"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MTIgNTEyIj48cmVjdCB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgZmlsbD0iIzAwMCIvPjx0ZXh0IHg9IjI1NiIgeT0iMzgwIiBmb250LWZhbWlseT0iQXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMzYwIiBmb250LXdlaWdodD0iOTAwIiBmaWxsPSIjZmZmIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIj5EPC90ZXh0Pjwvc3ZnPg=="), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<D>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<D>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

