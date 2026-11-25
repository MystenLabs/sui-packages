module 0x4ce6342fb70bf169a2d6f03328a7fa5bc6f0251fe577d7348e6b1bd2a4a9edca::gtforeverb {
    struct GTFOREVERB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFOREVERB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFOREVERB>(arg0, 9, 0x1::string::utf8(b"GTFOREVERB"), 0x1::string::utf8(b"ForeverBear"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/c_acBaCQ_QM_eUAdwwRpVmeofXa0MTJraKwPo8Q_ikdtw9u0RLzdx-cYzWjDEpixlgVsVJZYzE0zVoXDAM0IZWTed3_RS9xnFGQQ60encycOmwTG78KzYSN-2iKpqWIHuyGuMCtVIS0XMP4MI96bwL1U6FXQuZ6Gw8vHVtEq36FLCzKeDy7H4BO8SX0gaaXfgtPd7Qu00lRFxpFmAQ4MWAzht1GOcFz7qawTvO6FH7zHicS0ZCs4K2p5Waz_bvb8ZGa7i_QCS5eBC4DpgcHha8aUZPtYlZ69wgY1gfNo1qrv2TgTWtpXPgUTXnK6ucdJ45iS8yxCMT14zakBh_nQ2A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFOREVERB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFOREVERB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

