module 0xcb78b72c7363333de55e18d708fd15340e3acceadd69505066f01fac933be1e6::gtweb3godd {
    struct GTWEB3GODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWEB3GODD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWEB3GODD>(arg0, 9, 0x1::string::utf8(b"GTWEB3GODD"), 0x1::string::utf8(b"Evalina Casper"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/e3Xytj3YM7B9SqyBCg_tGJC_LYzYEXCClxeCvmMTJ0XuHzBWlGz9uWVE8Fq7g9OO3s_6C2c3O26BYUOeBYer-gM2h2qAY3CVvX8N9eIh3JooKWDEAgtHKlgnkaKugq-OjdYzEBTJQh-vbFndrgZpv1Oj51Gn9GjvOqZVTLnbLfFVC86EYkT_54109PSciyjsVrsLZmGlAc-j6aB_CHf-jUgMAf77WmgC2SVb9QHxTmPOzVMFyQBl1ilij5gUUutb1rG5AVUvw6BHyAVDipfe_NFdvEw5w5UXxm-tusKSIVmHCdDi0bVU-aFHe7cLZfRToDgbS4KZ03q_iQh0FAaqzw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWEB3GODD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWEB3GODD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

