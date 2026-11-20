module 0xa684210e9f33e6d56d885b6f081aec11bd2b62846de5d96532c85ad34ed7f464::yorozu {
    struct YOROZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOROZU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"32231db839829f8538cb3c2d4775d8a8c0893981ad96b050c81c0c0fec7644f0")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"32231db839829f8538cb3c2d4775d8a8c0893981ad96b050c81c0c0fec7644f0"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<YOROZU>(arg0, 9, 0x1::string::utf8(b"YOROZU"), 0x1::string::utf8(b"YOROZU"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/969f2aab58d7e25605715be3260ff159643f6129f7faec1dd417345043166517.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<YOROZU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<YOROZU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

