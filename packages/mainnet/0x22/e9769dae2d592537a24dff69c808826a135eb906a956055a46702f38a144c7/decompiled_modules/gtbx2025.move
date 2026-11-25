module 0x22e9769dae2d592537a24dff69c808826a135eb906a956055a46702f38a144c7::gtbx2025 {
    struct GTBX2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBX2025, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBX2025>(arg0, 9, 0x1::string::utf8(b"GTBX2025"), 0x1::string::utf8(b"BasedBuilder"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/DzYflce5nUM9moK7dUD3z891vH1izxHovsSjj9OyPYmTy1u2rc8kfXiVhVGmQMqimGX2Ix7a5M2MkyfWOKNUx9iuSZ_jskrJB8cloD-dzmqcgGfChwBjxNiM4Pm3LPWfWP6Q9H6DwPeehnCndcUWK8V1S_EH12r4uhwnZ4A3lVJ7YH7pKtHLcFujd60XpFxk89accJEyv9JFCA87lWhI7YdYG4FOhm4mBEaWj_8qsrRxK9Erl7QlKnT5_UvR6fC9SZI5TxJUxNlUkjVrBo2x6ZaJaGXkeP1AGd53MEpxfU1iOHt5Lg83V29sH63azUzRdOUfa_9GEIc_OdwxCvi_Xw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBX2025>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBX2025>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

