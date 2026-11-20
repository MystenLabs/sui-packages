module 0x109599bdf52fc9a0c66740b092622f34f2c544f6c7dc0fbae632b9025b9f8bf7::bramble {
    struct BRAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8efbef894e6c131792095c7c54636b3c9a581fdcf76c1d6646abde7c82c8c6a3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8efbef894e6c131792095c7c54636b3c9a581fdcf76c1d6646abde7c82c8c6a3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BRAMBLE>(arg0, 9, 0x1::string::utf8(b"BRAMBLE"), 0x1::string::utf8(b"Bramble"), 0x1::string::utf8(b"Plant seeds, grow thickets, harvest BRAMBLE. bramble-mauve.vercel.app"), 0x1::string::utf8(b"https://bramble-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BRAMBLE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BRAMBLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

