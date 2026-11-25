module 0xab719ffe91c9e8b275b7ad028fdac24dc525c3577675678eae3108516657d58d::gtheroape1 {
    struct GTHEROAPE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHEROAPE1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHEROAPE1>(arg0, 9, 0x1::string::utf8(b"GTHEROAPE1"), 0x1::string::utf8(b"HERO"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/RU1zOG3MY3B2endDPjKwfU3TdZJHD4dEEukUGEv8Q5ONKnY7Y26wZP4dL4yD4dYU3keP1_qKZjKX8BjV0B412dPf6cKKXF309ElkN8tMqkNaU4VtzYH2wf-crK9VFB4VGev9TOwnvppWg9NyaAoL-SWbRflbGjOElxZwVyWzNC1ukc5aKHHTmwtSvbpJYOs-2F7YvN-HPF7gR2g2XKb2vjrsaRsN0gcXaP13-Wv0XrKEC20oxonPsiqBUwHsO-U1z9KeoK49fqOR2Ag9AB8dIkY2TXWuZNeID1Hr78zCAQsKA4bj04rP4jn6UVheSS-dyme7bx2k8H4ISw1_PToCxg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHEROAPE1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHEROAPE1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

