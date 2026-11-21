module 0xeb45be1171b353a66c6d9e5abf9464612af27b92f18afe0799840c4ac95bab1f::lotb {
    struct LOTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"0f77db6dfb98b6b85f7476fa73cc071b699a9caf06625e23fe827a222ccd4575")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"0f77db6dfb98b6b85f7476fa73cc071b699a9caf06625e23fe827a222ccd4575"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LOTB>(arg0, 9, 0x1::string::utf8(b"LOTB"), 0x1::string::utf8(b"Lotbook"), 0x1::string::utf8(b"Every coin gets a lot number. lotbook.xyz"), 0x1::string::utf8(b"https://lotbook.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LOTB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LOTB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

