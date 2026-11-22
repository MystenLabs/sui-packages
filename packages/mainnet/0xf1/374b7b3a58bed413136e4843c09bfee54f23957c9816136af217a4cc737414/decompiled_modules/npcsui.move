module 0xf1374b7b3a58bed413136e4843c09bfee54f23957c9816136af217a4cc737414::npcsui {
    struct NPCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5011f9e14d58df66bcaa6033f4e4058190824302fca65ddf4db0e2dc270538a4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5011f9e14d58df66bcaa6033f4e4058190824302fca65ddf4db0e2dc270538a4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NPCSUI>(arg0, 9, 0x1::string::utf8(b"NPCSUI"), 0x1::string::utf8(b"NPCsui"), 0x1::string::utf8(b"NPCsui"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/424308160c06b4f43706804003bad97edc7674f80d65d771ef68b5594093ae3e.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NPCSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NPCSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

