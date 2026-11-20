module 0x353a79191ec6516a34f3f94059efad0e92e7c9bf660f5f5c12ff64256056da3a::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"29b1f816a4e7ad6c3d5786d3d1eb91c200e438726cfe7eef14e3058dd952f46b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"29b1f816a4e7ad6c3d5786d3d1eb91c200e438726cfe7eef14e3058dd952f46b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BLAST>(arg0, 9, 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://d2ol7oe51mr4n9.cloudfront.net/user_3KSVpBFs6FNE6Kl3p4mU3cJ7PTE/a5b14914-0107-44da-ab9c-2c591fe23e2a.png"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BLAST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BLAST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

