module 0x2db754bc5ff765deba6d5145423ec1a6a330db999698d3a825e9a48c8ffd6110::gthyplhome {
    struct GTHYPLHOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHYPLHOME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHYPLHOME>(arg0, 9, 0x1::string::utf8(b"GTHYPLHOME"), 0x1::string::utf8(b"Hypl_Home"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/eWZ7z6kl7z8oTM2i2kmila68n0NxRog02cG6b6MfwHygKqq3tAcZeY1w09TGmP7Il1jiIEaIGLinpah3k04ex0GQA5zB8OJhyBKMwX1u-5bsFitHvPhwOFabUsl1GbBv2XynrawpomoR4qW8Dy1hFnklyAzi1VXDNsPumK-IVAujrJFHGUKOwaznHsQBr0LiZnksk1KyM7xrmxklXtpAysdMKlLBBtS6TCUGR6lxsG61fiWUuvTN45A1_2iB3GCSQ4eGP6lFXOkfIZzmx9I0pnQdfS6H7KcIxHTpWg9cSc-1lx8zD_BF4EjoYzVnH2tPjbjTsZR0vvr5OiNvtrARqQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHYPLHOME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHYPLHOME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

