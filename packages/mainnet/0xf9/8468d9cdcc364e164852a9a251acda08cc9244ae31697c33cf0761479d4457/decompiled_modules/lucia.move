module 0xf98468d9cdcc364e164852a9a251acda08cc9244ae31697c33cf0761479d4457::lucia {
    struct LUCIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f7b673d8815d535156fcf61e3f96ef66f2754c146398c13b565262e7d9dba47d")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f7b673d8815d535156fcf61e3f96ef66f2754c146398c13b565262e7d9dba47d"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LUCIA>(arg0, 9, 0x1::string::utf8(b"LUCIA"), 0x1::string::utf8(b"Lucia On Blast"), 0x1::string::utf8(x"54484520424947474553542043525950544f2048454953542048415320424547554e210a486f7020696e20746865204c616d626f2077697468204c756369612e0a5765206a7573742073656e7420426c61737420696e746f206f766572647269766521"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/0ad62b75eae747813b23cbb24b288adf4970e95e59f87bb8dc45fefb5281c337.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LUCIA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LUCIA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

