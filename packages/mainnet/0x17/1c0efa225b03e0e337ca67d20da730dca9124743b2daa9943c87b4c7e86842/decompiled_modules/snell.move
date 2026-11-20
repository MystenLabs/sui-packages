module 0x171c0efa225b03e0e337ca67d20da730dca9124743b2daa9943c87b4c7e86842::snell {
    struct SNELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNELL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"bdc51acc6b2f2ef663868453ed3c3dc650bf09176999c1591334099a43a0d353")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"bdc51acc6b2f2ef663868453ed3c3dc650bf09176999c1591334099a43a0d353"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SNELL>(arg0, 9, 0x1::string::utf8(b"SNELL"), 0x1::string::utf8(b"Snell"), 0x1::string::utf8(b"Every coin gets its own hook. snellpad.xyz"), 0x1::string::utf8(b"https://snell-sol-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SNELL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SNELL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

