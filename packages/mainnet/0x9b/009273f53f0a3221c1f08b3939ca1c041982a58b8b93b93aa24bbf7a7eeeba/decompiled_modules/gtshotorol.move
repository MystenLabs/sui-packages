module 0x9b009273f53f0a3221c1f08b3939ca1c041982a58b8b93b93aa24bbf7a7eeeba::gtshotorol {
    struct GTSHOTOROL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSHOTOROL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSHOTOROL>(arg0, 9, 0x1::string::utf8(b"GTSHOTOROL"), 0x1::string::utf8(b"Shoto"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/KpEdz3E06qlC4iWvy11936oChyYy7YJsZf67YrPBRkrLYGddUoGsz8XVBllrs4CscaD_72rMlmOMd9eUA8dAGw5fE7vm8ibi0wJl6vDDx1rZVZeMb85sng4FUaRVjEJfzoQm0HhljH2TGqVGm2otEn6Z_yBPTkMIVoES2Y60ilmCzKMyTlKMuFACBOBAo1TaDUWfUZxY_KozU3M8Xn8RRO7raZr593mYi9QFrZ-S0Uev80jt_ppr9mXJkfk6vWoIi7r50yQc6ySG73ka10FKBNb3RPbxredYHzHcWst53fxiNMAy2Oxns5TaKu08GrvmASAxX1dxspF3NcJ3D2yuGA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSHOTOROL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSHOTOROL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

