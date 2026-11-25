module 0x834d0f0cccdf6530054d1b651c7bfa6a94b16be3c892818e93a45c7711c35125::gteffzeee {
    struct GTEFFZEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEFFZEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEFFZEEE>(arg0, 9, 0x1::string::utf8(b"GTEFFZEEE"), 0x1::string::utf8(b"EffZee"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/n4HiwmMnRwgg83p4sKa3uTp7lRXFBp9oQmB9A8wNI34O6rxXCExtU916hxYG-6DwhOkroTYIoSVkH9lZ6p2r9ZCLtGB_UxHiHbuz5FPxxpasd5283A8jp0N8tW5w41DLSQHY-yOlgGs85_4Ud1NUQnp6F8np5ZC2Zo2Oggj6oPrEhZdraCxph1yRJSiVQLPI41dKXOE8rS4Tl966Lerv0UZFKJtRoYHXgV8Y3eZuXMpV7Hm_TvIKUH5EptgD_RJEH_DFbUFB0l8T8CZ4EpEv6U23lExQsc_CrBrRVzcfVHY0w7Zma9FXdDXUNk8u-_j4wNlHGHujqMWGAk9suwCL6w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEFFZEEE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEFFZEEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

