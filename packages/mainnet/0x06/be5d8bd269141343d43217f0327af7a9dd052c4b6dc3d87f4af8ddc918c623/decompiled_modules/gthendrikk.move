module 0x6be5d8bd269141343d43217f0327af7a9dd052c4b6dc3d87f4af8ddc918c623::gthendrikk {
    struct GTHENDRIKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHENDRIKK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHENDRIKK>(arg0, 9, 0x1::string::utf8(b"GTHENDRIKK"), 0x1::string::utf8(b"Nosliw"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/BguojVEIhBSW4KBVANMtyBEHzr-TCgcDOQyTZYCn4ZN0QrRdoPZlXJgLHEdL1jQJhcU7pjYnMZ4XOkAE3z4m9YSz926QZCPER-wVOvITljmZxB5_gK0RUg83Yn2YBQDjhtEGbtrDgTZMDaduM67J7p0W7ivsIroQqj7s7nYSfv6emn7_-ifwXS91ij8AjSZfh-ZmLq2SxDdFe_vPLXpdffkHP8eIzpiPxmBiFNtsTSwyAL5Cu6JxV8vFHEINl8dogGzKVk4zPKQf47CMDpeGNIp0WrSPRLskOdWw4_fU1tfStmEjRC4AlTTqVMv05TyEUEjoxelkUbW50SeYw7dvPw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHENDRIKK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHENDRIKK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

