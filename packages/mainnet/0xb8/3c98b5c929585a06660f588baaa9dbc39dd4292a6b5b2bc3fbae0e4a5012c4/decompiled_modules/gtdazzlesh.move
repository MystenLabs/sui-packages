module 0xb83c98b5c929585a06660f588baaa9dbc39dd4292a6b5b2bc3fbae0e4a5012c4::gtdazzlesh {
    struct GTDAZZLESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTDAZZLESH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTDAZZLESH>(arg0, 9, 0x1::string::utf8(b"GTDAZZLESH"), 0x1::string::utf8(b"Bay Spain"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/D8_aIFezKpDumn1tkGr4LDOaRTie8XqQoH0rWCgfm7ki8rwIF5uGRjsC0McPcK9Gx663BZVdfdBRKf6Qs7N0znkqe0-1ItJ25N7UR1gBjFnD3pI_W3a_KethQH5PE5DPEtYLCveHwjJ_WTzU2gEdhgPfKV8FbXD3j4dUoZjMFtyp-4_LNeao6zor5MtFsNKeFhOE4FHOInYWrRNHLMc31Zn_hj2OvfLAPENWEh3YVez-CLIS41mGV5ZnPw4iNfSvSsWPIwLm0u43XHKOGhaPi-kSu4qIKu81m-NXT52zK6Yb-I1QbRTKBCroEyd5vDK0oVJLI2a6UMJHQjwwSRG8eQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTDAZZLESH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTDAZZLESH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

