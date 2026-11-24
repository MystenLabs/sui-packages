module 0xd8a122c6e13a8cb3a3240d9b06fb736c4e9b1f552610c6a7dcd8f75d509bed4b::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"09637c7a934b8be53636cc388b3063d57b2e1ea032c0dfe54cda14350e38c8a5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GHOST>(arg0, 9, 0x1::string::utf8(b"GHOST"), 0x1::string::utf8(b"GHOST"), 0x1::string::utf8(x"546865206f6e652074686174206d6f766573207768656e2065766572796f6e6520656c736520697320736c656570696e672e0a4e6f20666163652e204e6f206e6f6973652e204a7573742070726573656e63652e0a5061797320686f6c646572732e"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7bc216d7dcb5ce797245edaed985c2470f2d223faee5cd9e8ede7ab7d05f0dff.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GHOST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GHOST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

