module 0x74be8f71386db95cd59e1f7702b137aff52320a4234081ff642899fcd42b3f7::gtgorillag {
    struct GTGORILLAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGORILLAG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTGORILLAG>(arg0, 9, 0x1::string::utf8(b"GTGORILLAG"), 0x1::string::utf8(b"GorillaGlue"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/VcdP5xpwCfWdkWtBxF0S5wtpKaHgFsV88x0TRQF4pfxyWUSBlYmr-mgmHd_nFghKJxDCvur2hqpehBDit97EQ2caF6YNBMp9m02CAYGJvWBDyhokVQbJTYqqTDRuj3wYv-367tOVuw-pbCsnc1XuPFEKRHd5a7LKKHqayDU8j5mD0kdM5CK-Bai9wY4sTcQq_P3LdcCsKBxhObrCsg3gOGbMl6HW7YsyBZeuq8GZIO3LYVug9ssliKVOqRIvcdaDRcFzyZhBJWTbWZ9lLx892x_AhA358EsWIQvknyHETxKR-h4wv10W53Klqh6i12TaTdskar8Uwbg6Ju1hvGWR_A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTGORILLAG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTGORILLAG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

