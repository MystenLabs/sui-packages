module 0x1037e13fd61e1d93e6474af5ffc5b6e300abe8d85a8e594b36fca09e64530c46::baro {
    struct BARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8658c33903265a047bc122afe889572ac72bcccfbff1330c261b7997b60bbb8f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8658c33903265a047bc122afe889572ac72bcccfbff1330c261b7997b60bbb8f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BARO>(arg0, 9, 0x1::string::utf8(b"BARO"), 0x1::string::utf8(b"Barogram"), 0x1::string::utf8(b"Every coin starts calm. barogram.xyz"), 0x1::string::utf8(b"https://barogram.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BARO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BARO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

