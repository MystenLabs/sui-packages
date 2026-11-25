module 0x2a8afec96649cf716a0301426c0ae9dc55a5e58ef193f2dca52c17fd4adf690::gttojizxn {
    struct GTTOJIZXN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTOJIZXN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTOJIZXN>(arg0, 9, 0x1::string::utf8(b"GTTOJIZXN"), 0x1::string::utf8(b"Toji"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/qY8WLOmMUJ4w-O4AmDQFTdKDXId45mogZZe8Czl5blQDXE8XzVuzzrEXbRLbkrD5mD47g9XDg8U_DqusmSwdKwciQp7dkt7nfRpyRKDaPRlBWUBjTXgr4E-SACax1sK5v269B9j487mkHdgGZbQGgFJTcJ5PKrwYEq_CQVLxbyFExBLL1lMVDgzw0hUyGWJKzV9LIJGVgmt0hQeZsh9GqG4p11MwFfkwvDVowgNZmywbcZ8Usf1xNpuSMDV-Lnhy460q_LtpeVnqt5Cgv65p8vxkVt3IcU4eGpLsSumhWox9xz0XDctTLLUneLHacB_tWDQTvHSYb10NfnUd8KGACA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTOJIZXN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTOJIZXN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

