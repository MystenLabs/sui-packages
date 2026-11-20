module 0xdfeaca8262ab7eaff8b8ff76e9a76335bdd8bc91c2b060babca29a5af593c32d::hmoon {
    struct HMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"7bf7fbb19ef175a77751d74618318983a78aeb32763efa58d9a2db60016e191b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"7bf7fbb19ef175a77751d74618318983a78aeb32763efa58d9a2db60016e191b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HMOON>(arg0, 9, 0x1::string::utf8(b"HMOON"), 0x1::string::utf8(b"Hype moon"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9a448e09f73859e3b18b9aa41d262b5dfea5c245db66d5f5ba73db54210e410b.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HMOON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HMOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

