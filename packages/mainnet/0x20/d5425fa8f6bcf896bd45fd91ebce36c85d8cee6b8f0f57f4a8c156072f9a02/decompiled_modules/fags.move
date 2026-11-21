module 0x20d5425fa8f6bcf896bd45fd91ebce36c85d8cee6b8f0f57f4a8c156072f9a02::fags {
    struct FAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9bc66a16ecfaa9227de51038091d7f7b050053dfcf9eb931c73c016eb2df47ac")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9bc66a16ecfaa9227de51038091d7f7b050053dfcf9eb931c73c016eb2df47ac"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FAGS>(arg0, 9, 0x1::string::utf8(b"FAGS"), 0x1::string::utf8(b"Mysten Fags"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/3543addb5471cd55a7f236b01870bf87e392fae4cb10de62ef80b3c93e85a4cc.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FAGS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FAGS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

