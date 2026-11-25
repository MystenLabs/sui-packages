module 0x59ceae2091921878ec298df08a3625e4c6ad9ed178d6932cdded51c0bd80f7a::gtlivioriv {
    struct GTLIVIORIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLIVIORIV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLIVIORIV>(arg0, 9, 0x1::string::utf8(b"GTLIVIORIV"), 0x1::string::utf8(b"Livio Rivera"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Cpaeqob4zShszbirUovi6wP3DqrVEG7Vl7wauObozGU_FfVoAAkuoZ2hJLuU_qg_I2VMnnXPqEyNCxi8WzwpTYDwpx6DB_DInsQptOuFBbwXal8Tl3NJ8yMkMt6qI487QpOdBzyObzw9zoxN68aeub_rYA66_MJqtuL1bQxr1i8I09FtM4kyg8l0yzAFS52tjBpBe7pks_WKqbCl_Wmo0qg4LYMl6pzyVoLA9wsn4y1Ohb689UNXDmEy8KFqEoV-jxVO-k_Ejq486Hv5vsbpEE9Ig7-Fn1qIAGbM1lPh_4bSlXdh3cjCa3D9Hct6e-wqmT5aATTFSAx0GWDMqYl6fA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLIVIORIV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLIVIORIV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

