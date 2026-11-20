module 0xaad6a38399c5c75d3a03071d20954443e6bbc8e0c28a573c635596738cf41d4a::saggar {
    struct SAGGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"17a2941db5849872e1e9ca6ea303cd24b1c251e3e673fc0f3e9eba77cac2af44")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"17a2941db5849872e1e9ca6ea303cd24b1c251e3e673fc0f3e9eba77cac2af44"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SAGGAR>(arg0, 9, 0x1::string::utf8(b"SAGGAR"), 0x1::string::utf8(b"Saggar"), 0x1::string::utf8(b"Every coin gets fired in the kiln. saggar.xyz"), 0x1::string::utf8(b"https://saggar.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SAGGAR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SAGGAR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

