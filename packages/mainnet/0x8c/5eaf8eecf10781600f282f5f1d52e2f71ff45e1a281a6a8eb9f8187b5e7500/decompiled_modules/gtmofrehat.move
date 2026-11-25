module 0x8c5eaf8eecf10781600f282f5f1d52e2f71ff45e1a281a6a8eb9f8187b5e7500::gtmofrehat {
    struct GTMOFREHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMOFREHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMOFREHAT>(arg0, 9, 0x1::string::utf8(b"GTMOFREHAT"), 0x1::string::utf8(b"Moh Frehat"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iWkVptA_zpfBdSUwo5yFdEvpP_sVi4rNVnIZcHFOdv5QCbd3tmcY0ry5SciP56oRF7XWoK0rsQJOgkmHI7-K605Z7FU76iTJDENpjB2kikJr8DCoowjnx4pNlzDOpEo3XGhdu6_pdb1dEe4sBxm3zFXRNBvQ99nLlZAK17llrmLwd4kZ61CGoAgEPy2BWijXT5zURcUPzlxFt-Fu0kwFvlTPvz0tF8m3YOyqd0ygWNGsEcArAUpkzC-hon-_BdnajxEqc10LJsnn0MmJ7NhYFCxIee6XqqgLiR_n_qDTVA_2zEBu_GE2JWMWrkokahKd_DvYWxeLJYit98i0Pd3Dig.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMOFREHAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMOFREHAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

