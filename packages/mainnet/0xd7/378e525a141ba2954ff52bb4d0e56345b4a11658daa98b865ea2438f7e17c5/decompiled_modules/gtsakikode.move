module 0xd7378e525a141ba2954ff52bb4d0e56345b4a11658daa98b865ea2438f7e17c5::gtsakikode {
    struct GTSAKIKODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSAKIKODE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSAKIKODE>(arg0, 9, 0x1::string::utf8(b"GTSAKIKODE"), 0x1::string::utf8(b"Sakiko"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/VHKnZMAw_SIWo6ll3PxENxwgIHjvNVN7DB1fQp7--G2Wys4qyrUeXOmnZTq_r6fjL_oYSAumCHA_rIy5jtcTl2ac2cfW23iaH9kT3sU8iJGA5oMl9S7Gkmo3m3dB27YiQdeyS17Tv87mxo0Neu92uzF9tgTjnkcJb5sTyyuVFhe4CJGkrorDL8cGwqw0UIT89q6BHTbfubvTFVqakAoFJyRQe7WAW-WEeW_rMQesEWVGVM0HLcOI-3DIE_9LpFdYV5EGZdnw-t7vkc_1avq6Dkb650tszZqfrMvODPB6kIjE7EooUe5f6g8a47EOZRP530W10AFJ3-5sKsx6-0tMbg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSAKIKODE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSAKIKODE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

