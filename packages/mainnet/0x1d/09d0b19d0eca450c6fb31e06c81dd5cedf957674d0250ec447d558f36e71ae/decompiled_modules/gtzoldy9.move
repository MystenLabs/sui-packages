module 0x1d09d0b19d0eca450c6fb31e06c81dd5cedf957674d0250ec447d558f36e71ae::gtzoldy9 {
    struct GTZOLDY9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTZOLDY9, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTZOLDY9>(arg0, 9, 0x1::string::utf8(b"GTZOLDY9"), 0x1::string::utf8(b"Zoldy9"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/L2Dsu1IRgXzfD-vJ_ocIjd1qHkmDJPM9c6HXZuY2PzUfTVges9kfWk5bBxaFlOBG6p63nwpgX12F36bl4LokefZ1_XlugO6WnkmQ_xeQAFnH9UW8xsmTtGgbgu7m9jJfFHFkNdJ-qsR9x7Dt-Rof22BE906w8eOWCNUq8yb0yBRI4jfo1LB3I4jI7x3qpfFmWpJIuHbY_JQ_atrMqiSilwbVTW8KInp9hMIu8LUbJ-Iub72mGFMuexuyuO88XvRztQl1VHRXX9RnPXnKWQPoxCB9ZFVwFs7n1qmUtvoN3-tlVGPbqGA-gZF-YWlw5G3-sUCt1fmIGi3MWc2Bbv9wPg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTZOLDY9>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTZOLDY9>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

