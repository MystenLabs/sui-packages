module 0xb9052544787544ccbf8e58723d162fc498bbb92c557483dddcf8e737696a9e7d::bgta {
    struct BGTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"00d0aebce1d1900de7fd25121f6618c46177d83efd40bf92d83835f9e82f7d6d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"00d0aebce1d1900de7fd25121f6618c46177d83efd40bf92d83835f9e82f7d6d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BGTA>(arg0, 9, 0x1::string::utf8(b"BGTA"), 0x1::string::utf8(b"Blast GTA VI"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e0857881c2094bf3d84522d807ce6e6c4603730ef5d54d18f959f7fa92a66681.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BGTA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BGTA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

