module 0xe3cff91cdf37862c53fe2bf94557eaaa589dc1a732011ff02b9be9d1d8a78e37::pocketee {
    struct POCKETEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCKETEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39565d308793f18515c3e5a06aa728388a35610bc381dd8f2d62abc558dd9543")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39565d308793f18515c3e5a06aa728388a35610bc381dd8f2d62abc558dd9543"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<POCKETEE>(arg0, 9, 0x1::string::utf8(b"POCKETEE"), 0x1::string::utf8(b"Pocketee"), 0x1::string::utf8(b"A computer that fits in your shirt pocket. pocketee.xyz"), 0x1::string::utf8(b"https://pocketee.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<POCKETEE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<POCKETEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

