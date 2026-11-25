module 0xb94c1c1261eef53524e7d359878816fe874d4e8321a65c182ae8a7b18f13d838::gtceriys00 {
    struct GTCERIYS00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCERIYS00, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCERIYS00>(arg0, 9, 0x1::string::utf8(b"GTCERIYS00"), 0x1::string::utf8(b"Vespa"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/j-uqe3x7_R185dOm0HEMPPyFjDs16PSOI1qvo2cV4_WkHJyXTph0h3hDafKQSr16K0OQdrjMWQHiMAgMjXznyKa4blGS2CQ5fUlo8RKmZrUHl2uwZ054h_Eiw_e0tBjX4tet_4MUIv4LbyVsPJGYSRuRmnwnNV7oKcf5m68-XBHtzOlhxnpZTJ-ljUTQAu9OXczu2x13zOoRr2jmFVw6uh98MRcw78zhynkyeioSIwNeXzMw_KpxQfxPymk5Fs9EBccHcYHwbN-5lGsBIuG61qazHVVgxvVTwxCeHJBKy4cQUpp8NIK_MAHi6ecMzT1dCqFpFCcmDQd3Z9MEzUPi-Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCERIYS00>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCERIYS00>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

