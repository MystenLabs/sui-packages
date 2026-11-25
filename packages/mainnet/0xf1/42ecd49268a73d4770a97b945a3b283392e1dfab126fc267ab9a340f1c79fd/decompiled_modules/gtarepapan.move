module 0xf142ecd49268a73d4770a97b945a3b283392e1dfab126fc267ab9a340f1c79fd::gtarepapan {
    struct GTAREPAPAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAREPAPAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAREPAPAN>(arg0, 9, 0x1::string::utf8(b"GTAREPAPAN"), 0x1::string::utf8(b"Zymeth"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/eYSiTFujYcVXA8x5VvLh7y9gFbvfCZgrk3UiwIgyT7envC5vfHmHcRy3pkvw_UPENv8CpUl8h0tACQrUhPtxRGvHl0fFvUlb7HQf1UpOFIelYqtzDqIsP2w3LWxAj48ffMWJ92kKk8UwLZymxkTj3ER_oHws9azWJyRFYoytQDFCrqCOXaiKV-IY-C0ETUavR6AUaeVlgeuHzUDdmdIHXW6gNvhZEeKGeB64k7jMQHRdzfYcnhYmZpQcqXG1zQRCceBne9WCbBO1wO7-qsZTGO8fy6S2J08yaDQPqdYqiXD-Sn-_ThChSzflwOiGJXBth87jC46vpGL67kv1Qk_MYQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAREPAPAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAREPAPAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

