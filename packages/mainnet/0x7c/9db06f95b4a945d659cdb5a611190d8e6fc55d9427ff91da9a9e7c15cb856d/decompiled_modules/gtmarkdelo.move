module 0x7c9db06f95b4a945d659cdb5a611190d8e6fc55d9427ff91da9a9e7c15cb856d::gtmarkdelo {
    struct GTMARKDELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMARKDELO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMARKDELO>(arg0, 9, 0x1::string::utf8(b"GTMARKDELO"), 0x1::string::utf8(b"Ninja"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/HOPO6Md4rnHeU2L8tdzmi4YepgnUR0CI4Ok1yGLS5rxClNu8fP8kQtmCf1fxPoOMsVMyiH7mXP5Q_4UQIRpT6T9Y4ksxi3aZXMqCnzD-aNaeKUm8CeO1wuX2Nb9B64j6XcbJN6qvSEsY2ZKwuFx5-updhMep0wZYyH7wJ04TLXUJWzB0sogD2HKzWpcgzcj_AJyJdUgoYViMWZtAO6Oe_kzjrCW0PUK4qqHzR-POABEnaSsKVDbiMbatcXf6Bby1AMXmYI94hlxUtPxZGkGdZC6SETYHd46O9dRy2W_XyBRCLV6M0S90fqWeFXgRpnrfiDe7ZYlcMQ1l1a9T3waxIQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMARKDELO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMARKDELO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

