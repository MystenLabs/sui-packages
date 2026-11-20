module 0xf3dac5f3b8bfcb36865c5ecfdfd3759bc2bfda9ddeffc66d494e0df8494a1b04::eli {
    struct ELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e2b31c32f833f673415bebb922ead483594622097b9df7ec9979e9f7455787e0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e2b31c32f833f673415bebb922ead483594622097b9df7ec9979e9f7455787e0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ELI>(arg0, 9, 0x1::string::utf8(b"ELI"), 0x1::string::utf8(b"ALI"), 0x1::string::utf8(b"dont buy"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/22613e9d8fe59ba54539c04b23ddc8be6f60295697319dd2e8ee5f2c051e4cd8.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ELI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ELI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

