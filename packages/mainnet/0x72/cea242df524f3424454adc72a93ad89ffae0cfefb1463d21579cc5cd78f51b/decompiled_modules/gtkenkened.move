module 0x72cea242df524f3424454adc72a93ad89ffae0cfefb1463d21579cc5cd78f51b::gtkenkened {
    struct GTKENKENED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKENKENED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKENKENED>(arg0, 9, 0x1::string::utf8(b"GTKENKENED"), 0x1::string::utf8(b"Ken kennedy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/E4E1WPKR1aWyTKtIrjOD1zwgInkyBX9wF8E44HP7onQYGcsncR26-FDUS_nOTWI_q_lWLwPzHs98PaniW_A7p4K-qJou2gyPDGKXim2d2jmbwl95_og8E4y1Pj2ORtv1dn_nhHlYRW9H48uBszFwxhfAe580o3kg6ZXCO79cnjgZZn58tXs2yft7gVVx4AD6mPWLeVA9SyZgS7GnLuOK4Jzc7f2VzaRtm6Xi1kTZjOJUzvp542jUmQJMYDyd5Ekxol7bJh3nWhTZepZnhNJrZwtSGDwMpg8yDuZO-JOLem52DDNNA9frYhiWbt5THueMaqu5QPFOobh3xTFJ3UgjMQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKENKENED>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKENKENED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

