module 0x98af6107af6ffd27587971633e2de37bb6fa4be92b12db9f11aeebf86a4e73f7::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"88382f38dbfbecaf3d6c74038443bdda05cee5d8c07b1dd9ac2e51703eaec2f8")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"88382f38dbfbecaf3d6c74038443bdda05cee5d8c07b1dd9ac2e51703eaec2f8"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PEPS>(arg0, 9, 0x1::string::utf8(b"PEPS"), 0x1::string::utf8(b"Pepsi"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/084b18cfc4186f7d434b843fc9a05224f6bc212665d5ec665d0cc1566c6894e3.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PEPS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PEPS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

