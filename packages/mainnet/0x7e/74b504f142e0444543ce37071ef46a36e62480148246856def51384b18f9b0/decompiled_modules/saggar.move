module 0x7e74b504f142e0444543ce37071ef46a36e62480148246856def51384b18f9b0::saggar {
    struct SAGGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"1649742ccd6f6c11f20a9f639304e5876ef7fc73474c9fb1f9ef3ba2f58be2d1")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"1649742ccd6f6c11f20a9f639304e5876ef7fc73474c9fb1f9ef3ba2f58be2d1"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SAGGAR>(arg0, 9, 0x1::string::utf8(b"SAGGAR"), 0x1::string::utf8(b"Saggar"), 0x1::string::utf8(b"Every coin gets fired in the kiln. saggar.xyz"), 0x1::string::utf8(b"https://saggar.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SAGGAR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SAGGAR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

