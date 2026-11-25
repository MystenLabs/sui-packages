module 0x7627384e742f46455be8289f943a4344b5ebb35834fc85b0e59caa64ff62b8c::gtxcven {
    struct GTXCVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTXCVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTXCVEN>(arg0, 9, 0x1::string::utf8(b"GTXCVEN"), 0x1::string::utf8(x"6e696e6720e5ae81"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/pyMG6aCw0lKloHyLFILu8Ev6Zh6ErqhECZhd-4hmwzA_Fs37Qtul0UuMzZ_aKttt8CPLbUHxAmd8Vtj8jUYA-0KIkqTmyaV8OcA7i819BNdVNI7ErR4bll4EocirgV5Fk-_IcULc9qcSwpZxh9lXuZOvuMJhiDfhetT7kUbjMP2dSH5YKh37JAwkrx71JrN0QUSQdtwAytdmPUeDirLkHNr46d-3kxkGyorifZj2dpIdVCZ-qHMgtmrvY6PxU5dUlhyEbW3RsYw-7V-8LBM-MDuDNZTKLQpji73h31iZmNS16-meMsFc4rT6nDHX7-Dx3tCkGLseLjrDTvMWzng-aA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTXCVEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTXCVEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

