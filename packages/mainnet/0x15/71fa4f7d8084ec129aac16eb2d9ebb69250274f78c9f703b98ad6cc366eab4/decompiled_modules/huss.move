module 0x1571fa4f7d8084ec129aac16eb2d9ebb69250274f78c9f703b98ad6cc366eab4::huss {
    struct HUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"376bfcb1b04b3b417eddb08f9bc412d37e91819883f8daf8a9f4ef10877f8b4c")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"376bfcb1b04b3b417eddb08f9bc412d37e91819883f8daf8a9f4ef10877f8b4c"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HUSS>(arg0, 9, 0x1::string::utf8(b"HUSS"), 0x1::string::utf8(b"Huss huss huss"), 0x1::string::utf8(b"In the trenches nobody bag works, they only wait for magic to happen, Huss huss huss!"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7e4c24b0702b5f7136657ffc78a87e127b073f96da81d928a86e5f9327f9ce56.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HUSS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HUSS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

