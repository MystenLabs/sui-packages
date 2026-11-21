module 0x1bd21b3ae537eb36307833c553d71b51607735597064920bdec5fc3a529ab7e9::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"98dca5a234a5ad545f1290652aa331da2e33def8828b91db11e2f3947da71112")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"98dca5a234a5ad545f1290652aa331da2e33def8828b91db11e2f3947da71112"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CZ>(arg0, 9, 0x1::string::utf8(b"CZ"), 0x1::string::utf8(b"CZ"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/900fffbc9cde050cb1bdcdb0385ad81d05dfbe95fe57912d0ae926bf652c21b3.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

