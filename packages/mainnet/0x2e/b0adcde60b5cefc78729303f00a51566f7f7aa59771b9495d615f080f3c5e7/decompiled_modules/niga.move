module 0x2eb0adcde60b5cefc78729303f00a51566f7f7aa59771b9495d615f080f3c5e7::niga {
    struct NIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1e1d0ff04be3954df1c467d701bfbdb87229c7137c22d407849993ac5d3d0596")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1e1d0ff04be3954df1c467d701bfbdb87229c7137c22d407849993ac5d3d0596"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIGA>(arg0, 9, 0x1::string::utf8(b"NIGA"), 0x1::string::utf8(b"niga"), 0x1::string::utf8(b"niga fan token"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/acdbe03537479fcea586959494bb68f9f0a334b1a8bc5a8e90b60233cc12b8d6.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIGA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

