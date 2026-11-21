module 0xc02daa4f5e0cb3e9a20071400953c8e075697f56ee10d7eafd69c3e59e9d3738::yorozu {
    struct YOROZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOROZU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"82d934c042a2a13bbb67837a5a5ec0d371935f116b7bda00f0f9861cd35fd0aa")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"82d934c042a2a13bbb67837a5a5ec0d371935f116b7bda00f0f9861cd35fd0aa"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<YOROZU>(arg0, 9, 0x1::string::utf8(b"YOROZU"), 0x1::string::utf8(b"YOROZU"), 0x1::string::utf8(b"The infinity game in beta. Yorozu is an on-chain experiment in AI creativity."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/969f2aab58d7e25605715be3260ff159643f6129f7faec1dd417345043166517.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<YOROZU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<YOROZU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

