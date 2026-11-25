module 0x1057a2c974961fb8aa1951522205135d18901bbbdf576d1e15b0ee1f114a9083::gtoxdesire {
    struct GTOXDESIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXDESIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXDESIRE>(arg0, 9, 0x1::string::utf8(b"GTOXDESIRE"), 0x1::string::utf8(b"Desired"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/bo22fT8-T9l0iT8lTwq5ttSD8sHcRgBW0EjqJErFnMTUd0GwQIS3SuTyUNABkJ1w-9mpODpTcidXycBp7Q6VxqKCwj8AEe_rnTNQI1MMPf0-u8pGy0AsY1mfM5dDCY6w3KGRuY_U4mNeh8KkV_DbzZP6fMpN-cySmBbz54d_iZlT4ZtjCn4gZ2Bd0VW8LJKDBLI0QZwD01xmToorA09Nk09G8hc_PIyh-WZNOLcojvvzU0Z3dJUAy9-Ef9yih6-aXfg_24XdZQSo17yaTuN1aht9XBIvrinhr5zhlO19i2YMxyxa2XWWC_Vb6VfxijmjN7I3PIzuPdG-3mtpuZNHww.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXDESIRE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXDESIRE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

