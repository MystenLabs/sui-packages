module 0x2890fa628485d50e3932d0537bef40cb821eab54bbb6c478bb9d6a468dc86428::gtiamnion {
    struct GTIAMNION has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIAMNION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIAMNION>(arg0, 9, 0x1::string::utf8(b"GTIAMNION"), 0x1::string::utf8(b"menion.eth"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/EC0BYCChdoOBy9neUSgmTKy7r3OrSZaGlJjasyEnOO2MdwU51hFiqz0Tu6vu2UQ_rI5GCjzPyXFww3ztvBhzQydEQAJUua8kIVz7sR4tCuEe3pUYPaqC8BZdzJ3trIxRWDpq5cpI-rsjzhiJCi7m6FVGd1hgkIa38jIZtKPspCA8ld0tl6UwTqZLp6ffhSi_Dsb2opYPsOYMk-iknitPRUQDU85dAISiLRB-7_W04T--PHxBCs7_tZcDOK-XK1-fxj_gZuamWKgJBU24ZwdSoS7E4gZlY-HxyoNfqenOKnlKhDoJUOdyECh7boFSjpmGubpjIyU0v9kzDuX4v75-aw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIAMNION>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIAMNION>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

