module 0x837a116f8393e85194f0e808e32896062af717cfdbef6788fe1632cdac1dce8f::teeter {
    struct TEETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEETER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"199ba9dc56e4e4bd5cd15bb84ddcad0a9d833e9d65cd652758a715ed859643d0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"199ba9dc56e4e4bd5cd15bb84ddcad0a9d833e9d65cd652758a715ed859643d0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TEETER>(arg0, 9, 0x1::string::utf8(b"TEETER"), 0x1::string::utf8(b"Teeter"), 0x1::string::utf8(b"Coin launchpad on Robinhood Chain. teeter.lol"), 0x1::string::utf8(b"https://teeter.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TEETER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TEETER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

