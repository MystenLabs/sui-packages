module 0xc11325d29de7ff51407456a0102fefb8d28f87423133f2346ca74595bb2401dc::gtaasitaka {
    struct GTAASITAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAASITAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAASITAKA>(arg0, 9, 0x1::string::utf8(b"GTAASITAKA"), 0x1::string::utf8(b"Asitaka"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/hiVXMqj2W57NiZwsDA6wvAErG_HhctMLk9RMc74K5S7q6d0U2TXO5eYcBQrnZH0evkoWEdoUiljTZxC2bKcrRb9anbmcZHWWkuuf80G4-yPq5SPYf6Mk1tbm_50apZqqEHHCEIDXQO_kp8wpUqfzOZnXQSgorVjBLdBGeCz3rUQiA0JPSbD-LJsttqksTEYDQUGUIrAf00vlwBsK-q0H5-3v6TAepbW5soykM_wRGja9PI104FlCuoYqDyMqhjmx0fv6iWtkXifn4jTDnCO0wXZb6AVMvplntVhd_44RH8Uv1HldxX9Gfei_GujOgPjD_knzoxZT_-l7TNXHRicNkA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAASITAKA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAASITAKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

