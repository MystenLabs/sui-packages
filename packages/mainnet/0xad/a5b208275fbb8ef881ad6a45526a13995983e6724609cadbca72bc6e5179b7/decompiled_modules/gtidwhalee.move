module 0xada5b208275fbb8ef881ad6a45526a13995983e6724609cadbca72bc6e5179b7::gtidwhalee {
    struct GTIDWHALEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIDWHALEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIDWHALEE>(arg0, 9, 0x1::string::utf8(b"GTIDWHALEE"), 0x1::string::utf8(b"Mighty Shill"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Lmkaa_OmCTOc8i_em6Ds2-yi3DBtvibPJWdUHXt3tUS8zwkaexLvgZbMnMWMAU6Ivcwc1vqtSyg42-2OXrSGBco_AFKOOZAQNxu_pgO-nlvGog5CJWkNq4uA92IBze3Kawdnpm8rHoaPaVs_0o94P2XwEu4yvQW4epW9K7hxnyDGp8iCMdq0dywhyTvqXSd4Lxcq3OUXEjhVITPN-dhsh7_MNOZtx_6nmkmtQBkdSuin0vU0ozcg1ZpiKrP5hMIG7ukLAokFm1lJJW3uWf2qwAe7tHtKaEDi8C5tED3TIA-d9FBy4ZQErzHZT9wc_man5Y1BoN38VIGn1C0L3xja2g.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIDWHALEE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIDWHALEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

