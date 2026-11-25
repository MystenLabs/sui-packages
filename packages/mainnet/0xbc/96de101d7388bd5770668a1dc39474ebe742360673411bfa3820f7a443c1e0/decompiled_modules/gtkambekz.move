module 0xbc96de101d7388bd5770668a1dc39474ebe742360673411bfa3820f7a443c1e0::gtkambekz {
    struct GTKAMBEKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKAMBEKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKAMBEKZ>(arg0, 9, 0x1::string::utf8(b"GTKAMBEKZ"), 0x1::string::utf8(b"Gabell Kambek"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/WZbBi9Sj9a2Vnk-ybRMslTt6CZr0c_wo5fXcPPutBtt56g_8GfUY0HTHH8KlCEDGnJDHaBJNurq6Ke1HbaP_H5vgFQ2nnXCSQA8o631-vJqog44W9rI_HvZbyI9X4LgVjAoCSlGlSMZonJgWUMNmeZuIxKB3b-XFsQ3p2y5Ui2vHaR9cmU397Jqq-zQzJM2skcdokv8tjhwbSt6vvelWqLVeQiHPKQshmOwg3SLN_ImPnZvivxccn3ZyiC1aZlQ5vXr-9JfMyWIqLeFn2ZBKN19rJd4E3nvcxERz7-f_fHQRjKV__H8fSLX41vycMxlpsRyMsC05pmeqYd-7aaZlow.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKAMBEKZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKAMBEKZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

