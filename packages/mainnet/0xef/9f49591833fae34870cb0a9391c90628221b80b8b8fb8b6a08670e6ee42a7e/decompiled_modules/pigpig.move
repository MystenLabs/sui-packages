module 0xef9f49591833fae34870cb0a9391c90628221b80b8b8fb8b6a08670e6ee42a7e::pigpig {
    struct PIGPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"03a56f8927dd50b07b51ae8fd519f8b9b8eeb295dc08f97526096322d2e1e120")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"03a56f8927dd50b07b51ae8fd519f8b9b8eeb295dc08f97526096322d2e1e120"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PIGPIG>(arg0, 9, 0x1::string::utf8(b"PIGPIG"), 0x1::string::utf8(b"PIGGY"), 0x1::string::utf8(x"f09f90b7204d6565742050494747592e0a0a4a75737420612073747265657420706967656f6e207769746820612067616e67737465722061747469747564652c206120676f6c6420636861696e2c20616e64206162736f6c7574656c79207a65726f2074726164696e6720736b696c6c732e20f09f98820a0a4e6f20666561722c206e6f2073747261746567792c206a75737420766962657320616e64205355492e0a0a546865207374726565747320617265206869732074726164696e6720666c6f6f722e0a546865206d61726b65742069732068697320706c617967726f756e642e0a0a504947475920697320686572652e20f09f90a6f09f92b8"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/87df4de5209a763ed37fa729522ca681df93d1866c0a332f73f20ef3adceda3d.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PIGPIG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PIGPIG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

