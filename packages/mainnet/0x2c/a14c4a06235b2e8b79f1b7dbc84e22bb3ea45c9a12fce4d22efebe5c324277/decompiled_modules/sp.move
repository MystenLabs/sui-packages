module 0x2ca14c4a06235b2e8b79f1b7dbc84e22bb3ea45c9a12fce4d22efebe5c324277::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"db331e77c20a24f4efaaa46b3b5bd31a56376f50dea752e70ae3a5f47d692ef2")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"db331e77c20a24f4efaaa46b3b5bd31a56376f50dea752e70ae3a5f47d692ef2"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SP>(arg0, 9, 0x1::string::utf8(b"SP"), 0x1::string::utf8(b"SuiPads"), 0x1::string::utf8(x"537569506164732e66756e0a68747470733a2f2f742e6d652f7375697061647366756e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f3c270bb0504694791bda4ce4a391771c359e057ec0016bd060953762a6e6229.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

