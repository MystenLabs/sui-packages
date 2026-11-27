module 0x60f1a9af9020796120acb1b63c7b3a26f41aeca84385b22746d9c477bfbb7d13::det {
    struct DET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e071cd365ffc308333f3e17011d9d059f1bd6e296dd9342a57ae5410011d9b22")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e071cd365ffc308333f3e17011d9d059f1bd6e296dd9342a57ae5410011d9b22"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<DET>(arg0, 9, 0x1::string::utf8(b"DET"), 0x1::string::utf8(b"detox"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://viper-terminal.app/api/coin-icon/d7eff8e36903d932cf7e4fbbb8c6adcc3064f70e2d42a7e7cbc23d4e6de54171.png"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<DET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

