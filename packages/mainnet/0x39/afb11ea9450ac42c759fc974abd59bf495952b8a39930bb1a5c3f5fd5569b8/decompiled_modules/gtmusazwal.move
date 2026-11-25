module 0x39afb11ea9450ac42c759fc974abd59bf495952b8a39930bb1a5c3f5fd5569b8::gtmusazwal {
    struct GTMUSAZWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMUSAZWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMUSAZWAL>(arg0, 9, 0x1::string::utf8(b"GTMUSAZWAL"), 0x1::string::utf8(b"Cryphex.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/ZI3fDU3G6DbDI2bXLmRHrL-g1tuaH7OKk3tFIuuCxp7S2pNyTGScdcI4aEbiUIWL7CNEwefw2Asw2cNXbULEsO-FxvuPsm2HFotX5EafGYXkJqxX-_O7xhD5FH6yFf3xR19UZGwaUKJlgdREuNdi51xdQdvXrw3J3e2tX8WBEiDrDXVwXPoBNs4Eg57p3tBdGUig7pVs7xqm5MfKjkH5FCn2QWyxUBHE_w12x2jKza8-jCyTk7X1j1AiAWEeBiqvb1tfDcbL-1irWm1VHOAnutyDdXQRvq2IVM_UTnYMRshQ1rTid5Rnd4Ce7nw8Slp7gNtIaeuw8AjefWcKXu9HhQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMUSAZWAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMUSAZWAL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

