module 0xfe4608d30a26f1807600faf16e93c6ac234d7c9daf11db7ff3633b42e2b5b282::gtfrenchy9 {
    struct GTFRENCHY9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFRENCHY9, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFRENCHY9>(arg0, 9, 0x1::string::utf8(b"GTFRENCHY9"), 0x1::string::utf8(b"Frenchy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Ha8BlUEH_MxMOUs2x_fQbh7tCNVDDEre_RS2E2JCUaarhx7r2S2-uI6JhoEYM0Gj8z0NfQ2pBo4McyFZAHzBw0SQ0dAl5de1Xqe9-xn09Dv6ln6dsnyUcBPFq9-65vCmusReLrtT8jn_klRyKMgrKew3LoBoEDhZzBKuYa9IXVvmFa4YgyphsbCZZMCDWUmN9H0tBoGJ8vSdKLVLEuZYgj-qIEglxN11GHDejVGbDAvwrxSP12stwl_1nxtCP1zhl2dn0Hk-HKVMVcpMG2NcYvfwFoeNSLcMHAxjS7Q6Py0EZQDyDw4rrmL1G2YMA7BWD7dsYs8M9H282kq5t2gS9A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFRENCHY9>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFRENCHY9>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

