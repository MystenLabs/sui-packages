module 0x4b25d996d127726e8f12266eec79113eb5f7a687d322815812914b3e0d59242f::gtherb0x {
    struct GTHERB0X has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHERB0X, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHERB0X>(arg0, 9, 0x1::string::utf8(b"GTHERB0X"), 0x1::string::utf8(b"Herb_0x"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/bykV7fF___OscKGr2_zI_rOC0y4s4fNa-zopR1AqFUho1HjGc9iZaK3H_7d7DspwM8oiQG_Qo0Wj16xyckk82Z812UWHVVAnYUi2rBAQ7GSJuneKAqyq4YKn3ddzuQnkoSjXg1GEuB7CyTbTUzmSTG6u5hU7phWo8JhZCYEdKtRFNe2T9d5bszlkFdC1Nxz9slfo_EfXu6QCPsjv2jfnKpVk9uj2Tyuk_WCQOKZITivEFhtHjuGqXRjXXtiPvrz5IHjzPzeYhPZihy7oA0Fi8WSI0P7xjvtISZ5N6s7qjysX2ikR2C0vO61FNyqqjYPXJrgG9OH4Vb5m67ksar5QOA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHERB0X>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHERB0X>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

