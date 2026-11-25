module 0x27528b7108141d2daa4bf7456a79f8c79bb77a3570a8fe9a37ad0f0884fe5a4b::gtcharihaz {
    struct GTCHARIHAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCHARIHAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCHARIHAZ>(arg0, 9, 0x1::string::utf8(b"GTCHARIHAZ"), 0x1::string::utf8(b"NGMI Peng"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Toh9Q2MStt9r4J0H9EqZa2fNB21LrW1pUVvhV0-871FwEQmVXJ5rdHOm5d6uoVCWeUpgm9JmzPhGBwkcs-0d-kCK7h299N8cCI1NlrQBpYZXmzlhsw892Z1ooqAdPJgunwQALeXBiIBRcvjaQWpmbyRh4JcXYweeVGeQAMH2iUZtXrKfE9KBFF-WE7gjig5fJjFrHceGbEV-9g1ihIFManRlt6vO7-Ok2isyUXZqYC2XVx7XLG-6LGx77mLRsfoyvIpZ7h-AnMPubaDisV-WiPAD8kwq3PuaglQQJd9q_6Vv-1fie3f48L26Tifq0ywSvdQSh7M2-xNVsJNdhwF-lA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCHARIHAZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCHARIHAZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

