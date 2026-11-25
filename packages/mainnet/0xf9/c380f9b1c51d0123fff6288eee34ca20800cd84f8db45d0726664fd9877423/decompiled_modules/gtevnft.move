module 0xf9c380f9b1c51d0123fff6288eee34ca20800cd84f8db45d0726664fd9877423::gtevnft {
    struct GTEVNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEVNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEVNFT>(arg0, 9, 0x1::string::utf8(b"GTEVNFT"), 0x1::string::utf8(b"Bones Senpai"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/VKXzxys4oeQqNGq_UlyPD1uTSffdRtWcfI6JMUg_a-MFEU6CTqSadVKCgtIUBkEyi3FIJ7qJzckVoh_H77RgPO8tCI4UvyhOQiiUctiw4-B8Io7g5lgWTAsRssCgAlQPkLKgUC4zgTJN0-S8k2-qrvtiprCh7UALgdHm4NHYbxmA0XJ-jCDrRJ0M7Cx-5ZK8vWUFiRyasRMfRMeMTqwb_i66Pe1E81AUP2evMlOEnLyOKPigqR8g-qwIbqJPievG-zTSrgIZ5oqt0oSxtV2ra-C93tsExNc72stmqLCxZhesZH5LK6cZS06vpbB0kT-XlR_p7F-fv9LK0hfMw6Mlqw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEVNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEVNFT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

