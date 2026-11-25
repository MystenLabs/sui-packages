module 0x718c8819e34c7b6afd74e248bd9cae3d711463544ee6bc0d3e1d3c8ea1b9a5f6::gtflamekai {
    struct GTFLAMEKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFLAMEKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFLAMEKAI>(arg0, 9, 0x1::string::utf8(b"GTFLAMEKAI"), 0x1::string::utf8(b"hell nah"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/RSa27XXMgiAppyKMmBJcwhOg62Ba7nBmp6G1rs9g8PgyaGZTvKSDfPQRmLaPGtOQE1l0146ApMHoPmv7QqTLv4huze8cMyjVlT0s4-a5GrA-faKu9PAHJjnh81nTV7fX6co0gNpxbtUqTmnzQFK2s23vhRwsPA9SdAsH2NBwjCaHqrsavjcIM_IuFVMzWVOqLTgqivA4hj6Cd4GwnY-VeZnjzRjUVkelYk0cYE6_41GEz7-dMDF0empqz9BI-i37w7si-iKMA52BNPpcbDF4K3TJVqw7Eb5kFcmz4uQ2mBND6rjT1imybGuyxbyoVo5Ju2wL0hOyPJN9pnZveo_3RQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFLAMEKAI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFLAMEKAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

