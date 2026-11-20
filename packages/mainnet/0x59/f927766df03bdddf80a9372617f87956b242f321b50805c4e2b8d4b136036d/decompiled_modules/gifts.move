module 0x59f927766df03bdddf80a9372617f87956b242f321b50805c4e2b8d4b136036d::gifts {
    struct GIFTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9bc66a16ecfaa9227de51038091d7f7b050053dfcf9eb931c73c016eb2df47ac")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9bc66a16ecfaa9227de51038091d7f7b050053dfcf9eb931c73c016eb2df47ac"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GIFTS>(arg0, 9, 0x1::string::utf8(b"GIFTS"), 0x1::string::utf8(b"Gifts"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/e9ebc20c092e8f845a2012009bf2838abac1d08bfad67e97399309b07d34680d.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GIFTS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GIFTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

