module 0x1ce8c8698f57e0cc7bfd5e58dc15fcb840e84741d76b5cff0c1442ea0a90fcce::nogas {
    struct NOGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e8303008a48a6aef11e6fb9d8c6c168e8806eacd3d60c2177a6f3c41df16daa4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e8303008a48a6aef11e6fb9d8c6c168e8806eacd3d60c2177a6f3c41df16daa4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NOGAS>(arg0, 9, 0x1::string::utf8(b"NOGAS"), 0x1::string::utf8(b"NOGAS"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a45e70f06cf5acdff47fcde1ca3cd1b3882e82c0671f3476e4cb3d5a5821bf46.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NOGAS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOGAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

