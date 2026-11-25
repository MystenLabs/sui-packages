module 0x609e580579b2aa02b7a141edbb11aa0c4ba79a6131affe61fd1d6a1e09fc3a68::gtparallel {
    struct GTPARALLEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPARALLEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPARALLEL>(arg0, 9, 0x1::string::utf8(b"GTPARALLEL"), 0x1::string::utf8(b"TrES-2b"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/I88OF10BuWZO0W0F-2Zslo3La5oIsL1zFJJ0kgeXEFrCHREp3VXRcj9uaDRWywT0RFSpn4L_I7f7tWbiH2xZkitJQduoWohVhF43_nBIJG1OYpxb-OqGLqAxN5PE140K86mIMww-VBEch5ULf9CcncuJziJIOvsTIj7RERQcQWd64-KcIhH0lYgL43pI6tkdZHHg3TqN64f78Ls_eqKMMRfv3FaDy_ey6YRNN42uYUxaDUqn8cYYCCf1aX5h8DIZ_H2DVyTCNV0siCgCBeE7zC_Rp1SHsk9Fw9b8Z3Y0LlXFrpYvKQfV6AUH57f0cQued-mg_wQ1UBBZc20L7uOqig.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPARALLEL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPARALLEL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

