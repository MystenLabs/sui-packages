module 0xacc93abff4bd8c560956a03a6305892597b9955b52779425630989bdd36e1cf5::gtkjess01 {
    struct GTKJESS01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKJESS01, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKJESS01>(arg0, 9, 0x1::string::utf8(b"GTKJESS01"), 0x1::string::utf8(b"K Jess"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/J9FF9PomBLDs1FNBZdQIwtdJv7HG-Ai85GNQ7eVzOWIfsZjCLeqIvMIzetw6Mg4yo2i1CDjICIevUcllt9ETheg4bJj8Lsc6YYqRVQNvFZHaRF3I8137dAUK03ffs4l9MGAFkr6OWcOklcpvSw3h805gUnHEwfYv-DJP53VKEXRKI5MGoiZzwd5q9JS-T0bAGEz6ACh_0IODV_crEz4eo2JjM9TNkBhs_IL3C6a_IoxDCE52gEXz6xM0B00779Jw2GpvAc7KI_sSVElTONp6Avt4sn0c4DxvDQ-MwR89UksThG2FgJ-xs_9tT8g99xUYVN014tnAeTu0nXq-fLA87w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKJESS01>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKJESS01>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

