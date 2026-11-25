module 0x38c360d5ae04f1552981c8856e75a0053da8cbfcafd675c8c701e6aa6f113c09::gtxlevyn {
    struct GTXLEVYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXLEVYN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXLEVYN>(arg0, 9, 0x1::string::utf8(b"GTXLEVYN"), 0x1::string::utf8(b"xLeVYN"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Omz6M2AzdDHj3I6QX8v5-HL-TneYqMmE9IS6lgbL5_Oihw9_XbaXyMrNo7iaRdkCAxD-yMv_lNEKXQowKUInIMK4LHNJA34ENgtHiDH-bkWIIPEZqYUq-xsrcHEqrEGTFNB87VDp5k3VVxnHTHd2LmwGpuDIqKXG0QLKAFZ5XYNhKT3YNikSw6h30LlDI1Dz4Eiwtl5Bup1VcSLgE_Va1Bzc5umCA-z4CqVoJeXiufC8DHtCCRlMeVWVDkD_-4K6ZFml6D5VbM9Wxrjfchof7qYsF1-J8AH173uDfDUh4bf6IjBnmlFaLUT-ab4Rk9LLyreQkg4Ac-0UYJBpPMD7dg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXLEVYN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXLEVYN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

