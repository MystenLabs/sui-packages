module 0x29384e49d8c8eeca15fdb0406a0b8d02a73556bb71caa45de696a72774b30273::nvda {
    struct NVDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5011f9e14d58df66bcaa6033f4e4058190824302fca65ddf4db0e2dc270538a4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5011f9e14d58df66bcaa6033f4e4058190824302fca65ddf4db0e2dc270538a4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NVDA>(arg0, 9, 0x1::string::utf8(b"NVDA"), 0x1::string::utf8(b"NVIDIA"), 0x1::string::utf8(b"NVIDIA is a global technology company driving innovation in AI, graphics, gaming, and advanced computing. Building the future through powerful GPUs and artificial intelligence."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/11a7d4c59c03258bf6297cd3628f37cf5a63d49915501046d90f494a513bbceb.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NVDA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NVDA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

