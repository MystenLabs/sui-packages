module 0x68423641a3bdd00a07b8ea5255a0747bf357b9856e1e603c06f6d0c3d287009::gtsolanase {
    struct GTSOLANASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSOLANASE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSOLANASE>(arg0, 9, 0x1::string::utf8(b"GTSOLANASE"), 0x1::string::utf8(b"Solana Sensei"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/TV7EmTbQ2h_J9FARX4dFQ9TOLh6PwLyog3bV9Mvd-wYMBq1EIgcYVstaNkDxDyitGjP6-NoKWprof767QFrj_AIE7FEe8R0ptKVapYTEcyg0dsMzHGtDOjz2sPxX7Il6FV-Nnx-OhaBsZ35rJX28uaK4iRtJ25y9oCG0RH-1Cj3Oj8dLpClqjD82yiuVpsmdfSQAHbNNLztAagW0xecY4l7S82ceBGqL_lhk-p80sFXdWJ6sFSkJZy_Aak7KvXn1u74wtfyvfbKszKH5Y6QvMnM5DZVms28e7xfk7wfmx5dt4dgnDi7Xg2Y5fP6XbE08vbn5viSQe6acOrXsRV5LbA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSOLANASE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSOLANASE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

