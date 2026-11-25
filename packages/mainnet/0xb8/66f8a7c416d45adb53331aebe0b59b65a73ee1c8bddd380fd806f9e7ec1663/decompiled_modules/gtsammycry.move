module 0xb866f8a7c416d45adb53331aebe0b59b65a73ee1c8bddd380fd806f9e7ec1663::gtsammycry {
    struct GTSAMMYCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSAMMYCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSAMMYCRY>(arg0, 9, 0x1::string::utf8(b"GTSAMMYCRY"), 0x1::string::utf8(b"Sammy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/tQDRosaD6lHx-isozB54cPCmhWUrnNPjoee0kCXml0Jk24jXR6nksNs8oA8vlzzW3KxyzdVXKsSXJGCFfOmCxJq22gSnBLAP6gcu3d8HmAjBwuVc7qET6eeRJ0kbx1QjWv5GAB6Q_wG7BUUKedTlpUJhXxlRvRkcfC0loGvp2OjcO2nSgPzZhb0HbOysCw1RTQ_kwBOnqbH_99tS_OjnzSuURZaTOQeQ4VTZBK-Q4wIcNkKIAZG03_OsiMAGNQ1XZcdDwHrHTyk721XyRwzcwoqv2clm-3hKGJ-C7BepjydYypcFP-GYP0DW-Tr5FlgWxYuJexVXM2NoVbBV9eMLkA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSAMMYCRY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSAMMYCRY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

