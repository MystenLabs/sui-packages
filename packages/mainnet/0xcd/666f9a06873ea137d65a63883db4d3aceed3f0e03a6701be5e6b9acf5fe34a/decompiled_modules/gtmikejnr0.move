module 0xcd666f9a06873ea137d65a63883db4d3aceed3f0e03a6701be5e6b9acf5fe34a::gtmikejnr0 {
    struct GTMIKEJNR0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMIKEJNR0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMIKEJNR0>(arg0, 9, 0x1::string::utf8(b"GTMIKEJNR0"), 0x1::string::utf8(b"Mike"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/jzpcdrxqJrTZrDUOMjDp8oLEr6AUMOVSHujeMYzBoADS2FYPXC1YjGMjKGRus63F94l8arY37eRAwjFFI85riEDNBk0eau9t_c91uIyecO853SQb_gQJzwxMTQkFAG9gM6JrTpsWTAVi4QGnOwBFs_4gwvyH-nN2cBJuSCVHRkirZzgKiPGgGD1ZpVeiGIvaDzoAwNnme5yZh2THDhSilW2YNJkZcAeg08NOIPt0uFzaorUIwtRM7b9sOztgKqXm83nk5ymD6qNxKgBpdzSUBW4Wj3QR4Jz88KLppnUBgQNZhZ3C6lId5dV7Ls13dFc_mgnXsF-zfDdPx6i0-h0twg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMIKEJNR0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMIKEJNR0>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

