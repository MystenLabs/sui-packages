module 0xd9471001f157c7efc62116ff7db099e240d8b1f604a914c0f5012b491d92f41b::gtbartwosk {
    struct GTBARTWOSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBARTWOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBARTWOSK>(arg0, 9, 0x1::string::utf8(b"GTBARTWOSK"), 0x1::string::utf8(b"Bartwoski"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/KKX5Vpt2lB1E954M6ifHFl7IWPj3yitGo56jZ5zKNKFVZwid1DpG-3Cdft0ec8QXc6YnmEHsgddt8I2LeE-bMzeCsKchQu84oSHZ-Ha415uGIdkiUfdAo_vCTEiIi7ke0kjhvPkCq89KX9fgbu4ryChr3EKgc2kINzE6l2ubFoQLOeWU0_tMUH3_3nTA2sQ-Dj5m4GwdWA_7v5dgcJdaCHxmDGYXEuNo3fJ_RjEkQkU-nZNhIq6q3xkGb-taF08O3_Gzujf7yciscnMObQLRKzQeemELOGLUy7P_9wQF8_7wxWQsu3Df8lQm6Ws5Leow7uItTR7imH0PpvnNL9SX-A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBARTWOSK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBARTWOSK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

