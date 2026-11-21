module 0x2cbc0ef1a7024125bb88071c0f8a8244c5d6f32f1a423d9281da8e8aafd6fd98::slap {
    struct SLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"764e975d0c09bc4a4b94c3aacffe4d707f6abd258337c18d9fe0d0a2df7334dd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"764e975d0c09bc4a4b94c3aacffe4d707f6abd258337c18d9fe0d0a2df7334dd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SLAP>(arg0, 9, 0x1::string::utf8(b"SLAP"), 0x1::string::utf8(b"Slapwall"), 0x1::string::utf8(b"Slap your coin on the wall. slapwall.fun"), 0x1::string::utf8(b"https://slapwall.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SLAP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SLAP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

