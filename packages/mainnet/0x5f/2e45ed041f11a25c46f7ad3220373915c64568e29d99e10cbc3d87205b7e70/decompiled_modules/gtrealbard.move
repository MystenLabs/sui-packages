module 0x5f2e45ed041f11a25c46f7ad3220373915c64568e29d99e10cbc3d87205b7e70::gtrealbard {
    struct GTREALBARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTREALBARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTREALBARD>(arg0, 9, 0x1::string::utf8(b"GTREALBARD"), 0x1::string::utf8(b"Bard Bard"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/qcFVBbZvUjD5H9wOBoIhEiczQnGmzHQWinVMDgByGSxmG-yeaQTDh_Bo90djuM58goXK3B2frQIdHjL0tCVzYDzGGl6Y13bY7qfYc6_BHWsyw3Vrm6pqYfMwBHX4pQ3SUSz_W-32R8YEfCdVTlOFKtaKTjFDQtWjegRVWYSCs5LmvI8RRAJrFtVFt3Gf7tELjuYRYKF_-M633sd2UG9PHUFb00m3ebf1L1uGrFjxGPhW3j5OmoC_RxFFRAHqW2pGx7luF_6-ap5C0lZqa7DdxUHjIedpW9P5F3WBtytl9yTutVXI2Y6yY1vidSPeXoBIE_FfSlKuKaLixBfmA4BoRg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTREALBARD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTREALBARD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

