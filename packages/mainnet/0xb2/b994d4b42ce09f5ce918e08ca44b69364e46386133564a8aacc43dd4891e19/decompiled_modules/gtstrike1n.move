module 0xb2b994d4b42ce09f5ce918e08ca44b69364e46386133564a8aacc43dd4891e19::gtstrike1n {
    struct GTSTRIKE1N has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTRIKE1N, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTRIKE1N>(arg0, 9, 0x1::string::utf8(b"GTSTRIKE1N"), 0x1::string::utf8(b"Strike"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/TCuKaV9ZNDr0NrYnEENpqsR8wOUd0b9RXOUuSbMeQCcm6ZXIw4CIaabvbIeVgeHB-3JBMA060F0eMa_LKOqb6NUe6bUSbLBTuGKGjWOCyhJUcxe5TnOO751jHWN5vdwZeTtWVYEvVBG9RUFPs4ciU9BxPuHv1W-nJQYnYckwgi5gN-iukkeNkltEkJBB5uhVlljnQU3k2P89gDwb11QdgJPSW4ln4_VNHj992AMkChZL0tlHg6eO2dC-5KZlBeLIdgWL-e9LFt7N7VrOXuNX3TnqBj3g8XV9kXUJQMjJIFyY9s1Hd1wAMINFmEGuPSyeHAmkHQH0dBGVulBFXNTIeA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTRIKE1N>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTRIKE1N>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

