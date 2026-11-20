module 0xa84c727bccd2882d789bc41ba3492147b4062e9275027ddb77c2393959bec467::nogas {
    struct NOGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"70913c0efb9e2ad2d010ad564781ca8665616ccd9b179f3f7357f3b06f9a8204"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NOGAS>(arg0, 9, 0x1::string::utf8(b"NOGAS"), 0x1::string::utf8(b"Nogas"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9841cc7466cd6d5591adf16940096f0d95cf3068091da2f8e039523ccae9ea45.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NOGAS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOGAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

