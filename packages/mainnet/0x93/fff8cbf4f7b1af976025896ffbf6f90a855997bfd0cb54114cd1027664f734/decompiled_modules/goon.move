module 0x93fff8cbf4f7b1af976025896ffbf6f90a855997bfd0cb54114cd1027664f734::goon {
    struct GOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GOON>(arg0, 9, 0x1::string::utf8(b"GOON"), 0x1::string::utf8(b"Gooner"), 0x1::string::utf8(x"5468652070757265737420676f6f6e657220746f6b656e206f6e207375692e0a4e6f207574696c6974792e204e6f20726f61646d61702e204a75737420686f6c6420616e6420676f6f6e2e0a5061797320686f6c6465727320736f20796f752063616e206b65657020676f6f6e696e6720666f72657665722e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/a7949c369162a9a9ee1adcd69bc17ca1e35146a7c83e1799018a2dafb0f1ca30.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GOON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

