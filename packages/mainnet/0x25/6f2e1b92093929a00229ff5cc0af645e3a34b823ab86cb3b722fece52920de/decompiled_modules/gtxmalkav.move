module 0x256f2e1b92093929a00229ff5cc0af645e3a34b823ab86cb3b722fece52920de::gtxmalkav {
    struct GTXMALKAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXMALKAV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXMALKAV>(arg0, 9, 0x1::string::utf8(b"GTXMALKAV"), 0x1::string::utf8(b"Malkav"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/KGONB-5zsxQt4LrVahttpT6wHHh-xuNdTHTMK4Ocv4RCoKnp2hHdeJiz25yVJOxpAl0er_96FOgDkz6OGdyFIyNX72lHtjU1cp35RE5hLT8YsO6nvkfDJd63EJX793F5Me6CR2_3gzRHwDKCqR2kTGduCOAEPpUSkEExMY1OT3O9LnzJ6PHQN6fBqklAjolbuTccdthocj9yj0B_T5M5lV_LinAEL6fUU1AuQv1uuweyz4q8kakPCj7B1eWNiascmQq04gyDJJLN44-ggheF4BZiBNQnUYkXVzDm4377LgK-NBu0nXAUqTVRI3gPGuYppS2wO5yj0TwFhHngWzVs_g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXMALKAV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXMALKAV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

