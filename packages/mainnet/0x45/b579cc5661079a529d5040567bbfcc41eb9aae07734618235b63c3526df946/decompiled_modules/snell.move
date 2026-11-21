module 0x45b579cc5661079a529d5040567bbfcc41eb9aae07734618235b63c3526df946::snell {
    struct SNELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNELL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"cd7dc35c627f6ed72349459d1c2a9730f282b89fc9b863ed64d64a931fb77dde")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"cd7dc35c627f6ed72349459d1c2a9730f282b89fc9b863ed64d64a931fb77dde"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SNELL>(arg0, 9, 0x1::string::utf8(b"SNELL"), 0x1::string::utf8(b"Snell"), 0x1::string::utf8(b"Every coin gets its own hook. snellpad.xyz"), 0x1::string::utf8(b"https://snell-sol-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SNELL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SNELL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

