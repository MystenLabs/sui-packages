module 0x755cd42acb5ab73892fa5b6c927ce21d2d8f4b7a03b7963acefd8b2b913973b0::gtdarylmc1 {
    struct GTDARYLMC1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDARYLMC1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDARYLMC1>(arg0, 9, 0x1::string::utf8(b"GTDARYLMC1"), 0x1::string::utf8(b"Daryl mc"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/KnzkpLVqIsOv3S2fqEoifWfYazl-caittrZQE8xTck9VwN3OzNaNjIbGL9jNrdZ6kj_6OfQdz40imQaQqcQisbBhwV-_t0AJNo-GivhgfHCEFFS-mrcf5LTmvD8UDUlt4OMZS9clrz1YYMnVty5buifqmzIV5NejOkA3YTPDeeCxcxW83c-vu4SZ-6TR4NTrOHLWcSTXXKHmRiY3emzRiDMV2O2jXEliHmECL224LVpCTQc3vms8Qp4QD54AMhE9-kPUOLWP-a6l08GCXQSweRP7hHpTyF5q69Ti7buaKVOi6sOoRcH5U-6_2KeqqEeHnoA4ZkSKe6cWGwrYhbFkMg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDARYLMC1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDARYLMC1>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

