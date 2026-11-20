module 0xea8187a5b22236ffeef71d8e367a7094e097fb0b44e96739bbe6d11dae045b81::anti {
    struct ANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9c98fb8a5d2458a3daf6da6717ba658b4871a5640d452a63d76e85fc363cf964")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9c98fb8a5d2458a3daf6da6717ba658b4871a5640d452a63d76e85fc363cf964"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ANTI>(arg0, 9, 0x1::string::utf8(b"ANTI"), 0x1::string::utf8(b"Anthropic Inu offical"), 0x1::string::utf8(x"486f6c642024414e544920616e64206561726e207072652d49504f207368617265732e200a0a4445562d72756e206d656d65636f696e2c206e6f7420616666696c6961746564207769746820416e7468726f7069632e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/532c59c601066d09055b4ce303e06da848e790763357f10e934bcda65cb81579.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ANTI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ANTI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

