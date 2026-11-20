module 0xcbe1c16bf29b58644332d916d50e3dc781a18a48a5d1292b9aa11ce016c21806::pegu {
    struct PEGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"23c3a54c0271582342bb7817cefa7e0d170f47d01329aad46213f4ed6f7dad11")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"23c3a54c0271582342bb7817cefa7e0d170f47d01329aad46213f4ed6f7dad11"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PEGU>(arg0, 9, 0x1::string::utf8(b"PEGU"), 0x1::string::utf8(b"penguin"), 0x1::string::utf8(b"pegu birth for penguin"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d509d8f700b12821b7a557e7b0a1f4fb8a7c35159e3ac57c1134e8b632f6d486.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PEGU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PEGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

