module 0xca400117ade50f93b70974b1b8f8b07b6654049673ae70ebada37399121da19f::barnacle {
    struct BARNACLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARNACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"24fb29a2e6f2a10f5257b69fcfaa2f8e172311808898e578b881e30eadd60373")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"24fb29a2e6f2a10f5257b69fcfaa2f8e172311808898e578b881e30eadd60373"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BARNACLE>(arg0, 9, 0x1::string::utf8(b"BARNACLE"), 0x1::string::utf8(b"Barnacle"), 0x1::string::utf8(b"Memecoins that ride stock tokens. barnacle.lol"), 0x1::string::utf8(b"https://barnacle.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BARNACLE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BARNACLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

