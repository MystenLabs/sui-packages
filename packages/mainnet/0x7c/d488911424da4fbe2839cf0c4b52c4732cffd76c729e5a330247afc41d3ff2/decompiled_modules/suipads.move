module 0x7cd488911424da4fbe2839cf0c4b52c4732cffd76c729e5a330247afc41d3ff2::suipads {
    struct SUIPADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPADS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"db331e77c20a24f4efaaa46b3b5bd31a56376f50dea752e70ae3a5f47d692ef2")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"db331e77c20a24f4efaaa46b3b5bd31a56376f50dea752e70ae3a5f47d692ef2"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SUIPADS>(arg0, 9, 0x1::string::utf8(b"SUIPADS"), 0x1::string::utf8(b"Suipads.fun"), 0x1::string::utf8(b"https://t.me/suipadsfun"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f3c270bb0504694791bda4ce4a391771c359e057ec0016bd060953762a6e6229.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SUIPADS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SUIPADS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

