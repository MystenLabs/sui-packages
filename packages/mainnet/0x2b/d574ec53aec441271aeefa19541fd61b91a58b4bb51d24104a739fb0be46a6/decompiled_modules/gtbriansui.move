module 0x2bd574ec53aec441271aeefa19541fd61b91a58b4bb51d24104a739fb0be46a6::gtbriansui {
    struct GTBRIANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTBRIANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTBRIANSUI>(arg0, 9, 0x1::string::utf8(b"GTBRIANSUI"), 0x1::string::utf8(b"brian.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/sRwPo9U0b7-9z2dMhQn7Smsvah-rDK0y78spGRh-hFH8MEKAoEP0htw0YFskjB3V0qk1nQfsvdP0qgePIVYJCfhoFLeTHa6T77yl-dcE5-nDJ5p3cTpe3NjHAqPKBYbitcltHMqYmk5iwoHeDxoiQheqymPtesxuLjxpprYreQaNjcfJ0fwnYnK_Xfkpa8zw5CvpUbTEm0v4uMOX7X9sW_7IHD5RCvk8ZAcu3Job89adHdF_K3efIq_EpK4JQVSc4aLB8D0JwEgRx_VgtVheKdykhOTwTn-VXTWrAvcmNK6c0ssqzV8W0k_EmC5-GbGAww9YK9wqjvamofCEvzh3Mw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTBRIANSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTBRIANSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

