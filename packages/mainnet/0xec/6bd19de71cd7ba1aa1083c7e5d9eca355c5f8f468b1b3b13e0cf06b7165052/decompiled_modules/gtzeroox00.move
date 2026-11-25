module 0xec6bd19de71cd7ba1aa1083c7e5d9eca355c5f8f468b1b3b13e0cf06b7165052::gtzeroox00 {
    struct GTZEROOX00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTZEROOX00, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTZEROOX00>(arg0, 9, 0x1::string::utf8(b"GTZEROOX00"), 0x1::string::utf8(b"0xhard.eth"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/hs8E1l9s_tPVZNyMKbs8NpK7hjH6yt__dYnHWLsnhX7qHaZSn6ndrd75_TAtv3yRjOvc1R8CSJUCn_tFLoLDrHO_pxwfBvJEMkZRKk-E2J1pYMF6ZfHxQnJlExDK9Sp5OkA1xukEy42Awl3OqyXHXvJ0EbQY7EYz7kdeesIe5JZ0lrO4bJ3ThtJi1jiMnZUTiUlp0RCNgUq5AwfqJ7GDagGRw9T9EsdOL4ezYdNt4Yq7EH0PO_K2rTtbV87_vfk_Sihy2_KF8DPdr_RIIOmKkySP1oTkCRwOoYY8o9NUHKLFdRgGQPCNOkH0OiU51m2GstsX-6XAJS6IiFRCYb4AAQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTZEROOX00>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTZEROOX00>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

