module 0x37951bc7e2c1b070e03d353a1b4752ac9ee17a807d4ef87951b55839389f81b1::pressb {
    struct PRESSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESSB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"14c229dfc1a06a4c95881e8d9a8ff989fb610d6775ec3bb2fae784c28564ef51")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"14c229dfc1a06a4c95881e8d9a8ff989fb610d6775ec3bb2fae784c28564ef51"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PRESSB>(arg0, 9, 0x1::string::utf8(b"PRESSB"), 0x1::string::utf8(b"Press B"), 0x1::string::utf8(b"Press B"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/48a846e457980a1ca6a6dac03595963b65ea0d4cbe00c55c4db54d1280995dd7.webp"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PRESSB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PRESSB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

