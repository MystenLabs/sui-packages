module 0x774b7b1ec503dbf98baf413ef409b6cad4464b7ba7639217a909d1439a27da9b::gtdxg69 {
    struct GTDXG69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDXG69, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDXG69>(arg0, 9, 0x1::string::utf8(b"GTDXG69"), 0x1::string::utf8(b"Dxvid.G"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Out_eVJDG161UNyg14XAE78Bza_jpbucJUW1yV7WBT934apLjjgdENiyAGZOGUqTUDrTY-YedAXf5aqA1tMNJsoHm_A0vXNrd8T6zUUWPeo91n9R_XJY8ICzlC-F3IWz8mbgXCDA6LsHhOgmKERiiTTLmJgKJYt78YaQZrINvnnslMFcFruZfFWHN5lBZrrHa0fi1b2LViE_Vrb9kxBXtWb1LoC4pPOutswaa_NteCpJodZmUMkvFVaNwClbSqiHJeCnFcT9EfjYBaf5v0BZwaiORN0CoI_FjISSoD-lEC5mEylamPrdQYZwh3BCNL4np-8FnTO6BbS0pW-tWqM5Cg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDXG69>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDXG69>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

